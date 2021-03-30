import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';
import '../screens/splash_screen.dart';

class AuthService {
  Dio dio = new Dio();

  signUp(name, email, phone, address, userid) async {
    final String pathUrl = "$serverLink/api/signup";
    try {
      return await dio.post(pathUrl,
          data: {
            "_id": userid,
            "name": name,
            "email": email,
            "phone": phone,
            "address": address
          },
          options: Options(headers: {
            'Content-type': 'application/json; charset=UTF-8',
          }));
    } on DioError catch (e) {
      Fluttertoast.showToast(
          msg: 'Something went wrong',
          toastLength: Toast.LENGTH_SHORT,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 15.0);
    }
  }

  login(phone, userid) async {
    final String pathUrl = "$serverLink/api/loginNew";
    try {
      return await dio.post(pathUrl,
          data: {
            "contact": phone,
            "userid": userid
          },
          options: Options(headers: {
            'Content-type': 'application/json; charset=UTF-8',
          }));
    } catch (e) {
      Fluttertoast.showToast(
          // msg: e.response.data['msg'],
          msg: "Something Went Wrong",
          toastLength: Toast.LENGTH_SHORT,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 15.0);
    }
  }

  useredit(userid, name, address, email) async {
    final String pathUrl = "$serverLink/api/editprofile";
    try {
      return await dio.post(pathUrl,
          data: {
            "_id": userid,
            "name": name,
            "address": address,
            "email": email
          },
          options: Options(headers: {
            'Content-type': 'application/json; charset=UTF-8',
          }));
    } catch (e) {
      Fluttertoast.showToast(
          msg: "Couldn't connect to server",
          toastLength: Toast.LENGTH_SHORT,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          fontSize: 15.0);
    }
  }

  authHandler(otp, number, from) async {
    final String pathUrl = "$serverLink/api/auth";
    try {
      return await dio.post(pathUrl,
          data: {
            "otpentered": otp,
            "from": from,
          },
          options: Options(headers: {
            'Content-type': 'application/json; charset=UTF-8',
          }));
    } on DioError catch (e) {
      print("here33");
    }
  }
}
