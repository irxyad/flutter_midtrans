import 'package:flutter/material.dart';
import 'package:flutter_midtrans/core/payload/midtrans_payload.dart';
import 'package:flutter_midtrans/core/widgets/button_payment.dart';

part 'constants.dart';

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  bool useWebView = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(title: const Text('Midtrans Flutter')),
        body: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            spacing: 15,
            children: [
              ...[
                _amountController,
                _firstNameController,
                _emailController,
                _phoneController,
              ].map(
                (form) => TextField(
                  controller: form.controller,
                  decoration: InputDecoration(
                    labelText: form.name,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                    ),
                  ),
                ),
              ),

              SwitchListTile(
                value: useWebView,
                onChanged: (val) {
                  setState(() => useWebView = val);
                },
                title: Text(
                  'Use Snap WebView',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),

              // Button Payment
              ButtonPayment(
                useWebView: useWebView,
                payload: MidtransPayload(
                  // Must hot reload (just save the file) to get a fresh orderId
                  // or the orderId can be handled on the backend
                  orderId: "user123_${DateTime.now().millisecondsSinceEpoch}",
                  grossAmount:
                      int.tryParse(_amountController.controller.text) ?? 0,
                  firstName: _firstNameController.controller.text,

                  // The invoice will be sent via email if [Send email to customer] is enabled in Midtrans
                  email: _emailController.controller.text,
                  phone: _phoneController.controller.text,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
