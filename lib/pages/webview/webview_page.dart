import 'package:flutter/material.dart';
import 'package:flutter_midtrans/core/errors/webview_error_handler.dart';
import 'package:webview_flutter/webview_flutter.dart';

part 'constants.dart';

class WebviewPage extends StatefulWidget {
  /// WebViewPage using Snap Midtrans
  ///
  /// To customize the payment UI,
  /// you can check https://dashboard.sandbox.midtrans.com/settings/snap_preference
  const WebviewPage({super.key, required this.token});
  final String token;

  @override
  State<WebviewPage> createState() => _WebviewPageState();
}

class _WebviewPageState extends State<WebviewPage> {
  late final WebViewController _controller;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onNavigationRequest: (request) {
            final url = request.url;

            // If the URL contains 'settlement' means success,
            // it will block WebView navigation and exit the WebView
            if (url.endsWith('settlement')) {
              Navigator.of(context).pop();
              return NavigationDecision.prevent;
            }

            return NavigationDecision.navigate;
          },
          onPageStarted: (_) => setState(() => isLoading = true),
          onPageFinished: (_) => setState(() => isLoading = false),
          onWebResourceError: (error) =>
              WebViewErrorHandler.handle(context, error),
        ),
      )
      ..loadRequest(Uri.parse("$_urlWebViewMidtrans/${widget.token}"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const SizedBox(),
        title: Text(
          'Method Payment',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        centerTitle: true,
      ),

      body: SafeArea(
        child: isLoading
            ? const Center(child: CircularProgressIndicator())
            : WebViewWidget(controller: _controller),
      ),
    );
  }
}
