import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';

class AuthService {
  Dio dio = new Dio();

  signUp(name, email, phone, address) async {
    final String pathUrl = "http://10.0.3.2:8080/api/signUp";
    try {
      return await dio.post(pathUrl,
          data: {
            "Name": name,
            "Email": email,
            "Phone": phone,
            "Address": address
          },
          options: Options(headers: {
            'Content-type': 'application/json; charset=UTF-8',
          }));
    } on DioError catch (e) {
      Fluttertoast.showToast(
          msg: e.response.data['msg'],
          toastLength: Toast.LENGTH_SHORT,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 15.0);
    }
  }
  login(phone) async {
    final String pathUrl = "http://10.0.3.2:8080/api/login";
    try {
      return await dio.post(pathUrl,
          data: {
            "contact": phone,
          },
          options: Options(headers: {
            'Content-type': 'application/json; charset=UTF-8',
          }));
    } on DioError catch (e) {
      Fluttertoast.showToast(
          msg: e.response.data['msg'],
          toastLength: Toast.LENGTH_SHORT,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 15.0);
    }
  }
  
  authHandler(otp, number, from) async {
    final String pathUrl = "http://10.0.3.2:8080/api/auth";
    try {
      return await dio.post(pathUrl,
          data: {
            "otpentered": otp,
            "number": number,
            "from": from,
          },
          options: Options(headers: {
            'Content-type': 'application/json; charset=UTF-8',
          }));
    } on DioError catch (e) {
      Fluttertoast.showToast(
          msg: e.response.data['msg'],
          toastLength: Toast.LENGTH_SHORT,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 15.0);
    }
  }
}
