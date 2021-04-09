import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pinput/pin_put/pin_put.dart';
import 'package:rht/my_navigator.dart';
import 'package:rht/screens/splash_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../services/authservice.dart';
import 'package:sms_autofill/sms_autofill.dart';

class Res {
  String error;
  String result;

  Res({this.error, this.result});

  factory Res.fromJson(Map<String, dynamic> json) {
    return Res(error: json['error'], result: json['result']);
  }
}

class OtpForm extends StatefulWidget {
  final String _name;
  final String _addr;
  final String _email;
  final String _number;
  final String _from;
  final String route;
  final String _receivedId;
  final String userId;
  final bool isAdmin;
  const OtpForm(this._name, this._addr, this._email, this._number, this._from,
      this.route, this._receivedId,
      {this.userId, this.isAdmin});

  @override
  _OtpFormState createState() => _OtpFormState();
}

class _OtpFormState extends State<OtpForm> {
  final TextEditingController _pinPutController = TextEditingController();
  final FocusNode _pinPutFocusNode = FocusNode();
  MyNavigator myNavigator;
  final BoxDecoration pinPutDecoration = BoxDecoration(
    color: const Color(0xFFFFFFFF),
    borderRadius: BorderRadius.circular(5.0),
    border: Border.all(
      color: Color(0xFF2873F0),
    ),
  );

  void initState() {
    super.initState();
    _listenOtp();
  }

  void auth(otp, number, from) async {
    await AuthService()
        .authHandler(otp, widget._name, widget._addr, number, widget._email,
            widget._receivedId, from)
        .then(
      (val) async {
        print("val" + val.toString());

        final Map parsed = json.decode(val.toString());
        final res = Res.fromJson(parsed);
        print(res.result);

        if (res.result == 'The signUp authentication is successful!' ||
            res.result == 'The Login authentication is successful!') {
          print("headers" + val.headers["token"].join(""));
          var token = val.headers["token"].join("");
          final SharedPreferences sharedPreferences =
              await SharedPreferences.getInstance();
          sharedPreferences.setString('phone', number);

          await sharedPreferences.setString('userId', widget.userId);
          finalId = widget.userId;
          finalPhone = number;
          await sharedPreferences.setString('address', widget._addr);
          finalAddress = widget._addr;
          sharedPreferences.setString('name', widget._name);
          finalName = widget._name;
          sharedPreferences.setString('email', widget._email);
          finalEmail = widget._email;
          sharedPreferences.setString('token', token);
          finalToken = token;
          sharedPreferences.setBool('isadmin', widget.isAdmin);
          finalAdmin = widget.isAdmin;
          // admin = widget.isAdmin;
          print(finalPhone.toString());

          Navigator.pushNamedAndRemoveUntil(
              context, widget.route, (_) => false);
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

  void _listenOtp() async {
    await SmsAutoFill().listenForCode;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 60),
      // child: PinPut(
      //     fieldsCount: 4,
      //     textStyle: const TextStyle(fontSize: 25.0, color: Colors.black54),
      //     eachFieldWidth: 40.0,
      //     eachFieldHeight: 55.0,
      //     focusNode: _pinPutFocusNode,
      //     controller: _pinPutController,
      //     submittedFieldDecoration: pinPutDecoration,
      //     selectedFieldDecoration: pinPutDecoration,
      //     followingFieldDecoration: pinPutDecoration,
      //     pinAnimationType: PinAnimationType.fade,
      //     onSubmit: (otp) async {
      //       auth(otp, widget._number, widget._from);
      //     })
      child: PinFieldAutoFill(
        codeLength: 4,
        focusNode: _pinPutFocusNode,
        controller: _pinPutController,
        decoration: UnderlineDecoration(
          colorBuilder: FixedColorBuilder(Colors.blue),
          textStyle: Theme.of(context).textTheme.bodyText1.copyWith(color: Colors.black87)
        ),
        onCodeChanged: (val) {
          print(val);
        },
        onCodeSubmitted: (otp) async {
          auth(otp, widget._number, widget._from);
        },
      ),
    );
  }
}
