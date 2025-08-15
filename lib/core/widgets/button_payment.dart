import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_midtrans/core/payload/midtrans_payload.dart';
import 'package:flutter_midtrans/core/services/get_token.dart';
import 'package:flutter_midtrans/core/services/midtrans_service.dart';
import 'package:flutter_midtrans/pages/webview/webview_page.dart';
import 'package:midtrans_sdk/midtrans_sdk.dart';

class ButtonPayment extends StatefulWidget {
  const ButtonPayment({
    super.key,
    required this.payload,
    required this.useWebView,
  });
  final bool useWebView;
  final MidtransPayload payload;

  @override
  State<ButtonPayment> createState() => _ButtonPaymentState();
}

class _ButtonPaymentState extends State<ButtonPayment> {
  final MidtransSDK _midtrans = Midtrans.instance.sdk;
  bool isLoading = false;

  @override
  void dispose() {
    _midtrans.removeTransactionFinishedCallback();
    super.dispose();
  }

  Future<void> getToken() async {
    if (isLoading) return;

    // Check the payload for any empty data
    final isValid = widget.payload.toMap().values.every(
      (value) => value != null && value != '',
    );

    if (!isValid) {
      log('Payload is not valid');

      return;
    }

    setState(() => isLoading = true);

    final tokenResult = await TokenService().getToken(widget.payload);

    setState(() => isLoading = false);

    tokenResult.fold((error) {}, (token) {
      if (token.isNotEmpty) {
        // If using WebView, proceed to the WebView page
        if (widget.useWebView) {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => WebviewPage(token: token)),
          );

          return;
        }

        // If not using WebView, proceed to the page from the midtrans-sdk package
        _midtrans.startPaymentUiFlow(token: token);
      } else {
        log('Token kosong!');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 55,
      child: ElevatedButton(
        style: ButtonStyle(
          overlayColor: WidgetStateColor.fromMap({
            WidgetState.pressed: Colors.blue,
            WidgetState.hovered: Colors.blue,
          }),
          foregroundColor: WidgetStatePropertyAll(Colors.white),
          shape: WidgetStatePropertyAll(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          ),
          shadowColor: WidgetStatePropertyAll(Colors.transparent),
          visualDensity: VisualDensity.compact,
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          backgroundColor: WidgetStatePropertyAll(Colors.blue.shade800),
          splashFactory: InkRipple.splashFactory,
        ),
        onPressed: getToken,
        child: Text(isLoading ? 'Loading...' : 'Pay Now'),
      ),
    );
  }
}
