import 'package:midtrans_sdk/midtrans_sdk.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class Midtrans {
  Midtrans._internal();
  static final Midtrans instance = Midtrans._internal();

  late final MidtransSDK sdk;

  Future<void> init() async {
    sdk = await MidtransSDK.init(
      config: MidtransConfig(
        clientKey: dotenv.env['MIDTRANS_CLIENT_KEY'] ?? "",
        merchantBaseUrl: dotenv.env['MIDTRANS_MERCHANT_BASE_URL'] ?? "",
        enableLog: true,
        
      ),
    );
    
  }
}
