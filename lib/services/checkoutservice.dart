import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';
import '../screens/splash_screen.dart';

class CheckoutService {
  Dio dio = new Dio();

  checkOut(userid) async {
    final String pathUrl = "$serverLink/api/checkout";
    try {
      return await dio.post(pathUrl,
          data: {
            "id": userid,
          },
          options: Options(headers: {
            'Content-type': 'application/json; charset=UTF-8',
            'Token': '$finalToken',
            'Admin': '$finalAdmin'
          }));
    } catch (e) {
      Fluttertoast.showToast(
          msg: "Something went wrong",
          toastLength: Toast.LENGTH_SHORT,
          backgroundColor: Colors.grey.shade600,
          textColor: Colors.white,
          fontSize: 15.0);
    }
  }
}