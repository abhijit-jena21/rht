import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pinput/pin_put/pin_put.dart';
import 'package:rht/my_navigator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../services/authservice.dart';

class Res {
  String error;
  String result;

  Res({this.error, this.result});

  factory Res.fromJson(Map<String, dynamic> json) {
    return Res(error: json['error'], result: json['result']);
  }
}

class OtpForm extends StatefulWidget {
  final String _number;
  final String _from;
  final String route;
  const OtpForm(this._number, this._from, this.route);

  @override
  _OtpFormState createState() => _OtpFormState();
}

class _OtpFormState extends State<OtpForm> {
  final TextEditingController _pinPutController = TextEditingController();
  final FocusNode _pinPutFocusNode = FocusNode();
  MyNavigator myNavigator;
  final BoxDecoration pinPutDecoration = BoxDecoration(
    color: const Color(0xFFFFFFFF),
    borderRadius: BorderRadius.circular(10.0),
    border: Border.all(
      color: const Color(0xFFFFA751),
    ),
  );

  void auth(otp, number, from) async {
    await AuthService().authHandler(otp, number, from).then(
      (val) async {
        print(val);
        final Map parsed = json.decode(val.toString());
        final res = Res.fromJson(parsed);
        print(res.result);

        if (res.result == 'The signUp authentication is successful!' ||
            res.result == 'The Login authentication is successful!') {
          Navigator.pushNamedAndRemoveUntil(context, widget.route, (_) => false);
          final SharedPreferences sharedPreferences =
              await SharedPreferences.getInstance();
          sharedPreferences.setString('phone', number);
        } else if (res.error == 'OTP Did not Match!') {
          Fluttertoast.showToast(
              msg: 'Please enter correct OTP',
              toastLength: Toast.LENGTH_SHORT,
              backgroundColor: Color(0xFF666666),
              textColor: Color(0xFFFFFFFF),
              fontSize: 15.0);
        } else if (res.error == 'Data Deleted, Signup again!') {
          Fluttertoast.showToast(
              msg: 'SignUp again!',
              toastLength: Toast.LENGTH_SHORT,
              backgroundColor: Color(0xFF666666),
              textColor: Color(0xFFFFFFFF),
              fontSize: 15.0);
          myNavigator.goToSignup(context);
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 60),
        child: PinPut(
            fieldsCount: 4,
            textStyle:
                const TextStyle(fontSize: 25.0, color: Color(0xFFFF4E00)),
            eachFieldWidth: 40.0,
            eachFieldHeight: 55.0,
            focusNode: _pinPutFocusNode,
            controller: _pinPutController,
            submittedFieldDecoration: pinPutDecoration,
            selectedFieldDecoration: pinPutDecoration,
            followingFieldDecoration: pinPutDecoration,
            pinAnimationType: PinAnimationType.fade,
            onSubmit: (otp) async {
              print(otp);
              auth(otp, widget._number, widget._from);
            }));
  }
}
