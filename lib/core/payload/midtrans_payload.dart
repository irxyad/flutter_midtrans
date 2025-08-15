/// Minimum payload for Midtrans as required by the backend
/// To see other parameters, please refer to the Midtrans documentation
/// which can be adjusted according to the backend
/// https://github.com/Midtrans/midtrans-nodejs-client/blob/master/examples/snap/snapAdvancedExample.js
class MidtransPayload {
  final String orderId;
  final int grossAmount;
  final String firstName;
  final String email;
  final String phone;

  MidtransPayload({
    required this.orderId,
    required this.grossAmount,
    required this.firstName,
    required this.email,
    required this.phone,
  });

  Map<String, dynamic> toMap() => {
    'orderId': orderId,
    'grossAmount': grossAmount,
    'firstName': firstName,
    'email': email,
    'phone': phone,
  };
}
