import 'dart:convert';
import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_midtrans/core/errors/errors.dart';
import 'package:flutter_midtrans/core/payload/midtrans_payload.dart';
import 'package:http/http.dart' as http;

class TokenService {
  Future<Either<Failure, String>> getToken(MidtransPayload payload) async {
    var url = "${dotenv.env['BASE_URL'] ?? ''}/get-snap-token";

    var payloadJson = jsonEncode(payload.toMap());

    try {
      log('FETCHING $url \nDATA: $payloadJson');

      var response = await http.post(
        Uri.parse(url),
        headers: <String, String>{'Content-Type': 'application/json'},
        body: payloadJson,
      );

      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);

        return right(jsonResponse['token']);
      } else {
        var jsonError = jsonDecode(response.body);

        log("ERROR GET TOKEN: ${jsonError['detail']}");

        return left(
          Failure(code: response.statusCode, message: jsonError['message']),
        );
      }
    } catch (e, str) {
      debugPrint(e.toString());
      debugPrintStack(stackTrace: str);
      return left(Failure(code: 400, message: e.toString()));
    }
  }
}
