import 'dart:io';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

import 'api_status.dart';

class SendOrder {
  static Future<Object> sendOrder(String orderText) async {
    await dotenv.load(fileName: ".env");
    String? lineApiKey = dotenv.get('LINE_API_KEY');

    try {
      var headers = {
        'Authorization': 'Bearer ${lineApiKey}',
        'Content-Type': 'application/x-www-form-urlencoded',
        'Access-Control-Allow-Origin': '*',
        // 'Access-Control-Allow-Headers': 'Content-Type',
        // "Access-Control-Allow-Methods": "GET,POST,PUT",
        // "Access-Control-Allow-Headers": "*",
        // "Access-Control-Allow-Credentials": 'true',
        // "Referrer-Policy": "no-referrer-when-downgrade",
        "X-Requested-With": "XMLHttpRequest",
        "Accept": "*/*"
      };
      var request = http.Request(
          'POST',
          Uri.parse(
              'https://cors-anywhere.herokuapp.com/https://notify-api.line.me/api/notify')); // ใช้ cors-anywhere.herokuapp แก้ปัญหาเฉพาะหน้าเกี่ยวกับ cors
      request.bodyFields = {'message': orderText};
      request.headers.addAll(headers);
      http.StreamedResponse response = await request.send();

      if (200 == response.statusCode) {
        return Success(code: 200, response: 'Success');
      } else {
        return Failure(code: 100, errorResponse: 'Invalid Response');
      }
    } on SocketException {
      return Failure(code: 101, errorResponse: 'No Internet Connection');
    } on FormatException {
      return Failure(code: 102, errorResponse: 'Invalid Format');
    } catch (e) {
      return Failure(code: 103, errorResponse: 'Unknown Error');
    }
  }
}
