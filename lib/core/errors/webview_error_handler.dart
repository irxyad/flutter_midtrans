import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewErrorHandler {
  static const List<String> fatalErrors = [
    'net::ERR_INTERNET_DISCONNECTED',
    'net::ERR_NAME_NOT_RESOLVED',
    'net::ERR_CONNECTION_REFUSED',
    'net::ERR_CONNECTION_RESET',
    'net::ERR_ADDRESS_UNREACHABLE',
    'net::ERR_TIMED_OUT',
    'net::ERR_CLEARTEXT_NOT_PERMITTED',
  ];

  static void handle(BuildContext context, WebResourceError error) {
    debugPrint('WebView Error [${error.errorCode}]: ${error.description}');

    if (fatalErrors.any((e) => error.description.contains(e))) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Failed to load page. Please try again later.'),
        ),
      );
      Navigator.pop(context);
      return;
    }

    if (error.description.contains('net::ERR_BLOCKED_BY_ORB')) {
      debugPrint('Non-fatal error: ORB blocked resource, lanjutkan...');
      return;
    }

    debugPrint('Unhandled WebView error: ${error.description}');
  }
}
