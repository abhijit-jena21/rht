import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/constants.dart';
import '../my_navigator.dart';
import '../services/authservice.dart';

class Res {
  String error;
  String result;

  Res({this.error, this.result});

  factory Res.fromJson(Map<String, dynamic> json) {
    return Res(error: json['error'], result: json['result']);
  }
}

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _phno;
  String _from = "login";

  MyNavigator myNavigator;

  InputDecoration customInputDecoration(IconData icon, String title) {
    return InputDecoration(
      contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Color(0xFFFFA751), width: 2.0),
        borderRadius: BorderRadius.all(Radius.circular(40)),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.black54, width: 2.0),
        borderRadius: BorderRadius.all(Radius.circular(40)),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.red[400], width: 2.0),
        borderRadius: BorderRadius.all(Radius.circular(40)),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Color(0xFFFFA751), width: 2.0),
        borderRadius: BorderRadius.all(Radius.circular(40)),
      ),
      border: OutlineInputBorder(
        borderSide: BorderSide(color: Color(0xFFFFA751), width: 2.0),
        borderRadius: BorderRadius.all(Radius.circular(40)),
      ),
      prefixIcon: Icon(
        icon,
        // Icons.account_box_outlined,
        color: Color(0xFFFFA751),
      ),
      hintText: title,
      hintStyle: kHintTextStyle,
    );
  }

  Widget _buildphoneno() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Phone no',
          style: kLabelStyle,
        ),
        SizedBox(height: 10.0),
        TextFormField(
          keyboardType: TextInputType.phone,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: (String value) {
            if (value.isEmpty) {
              return 'Phone Number is Required';
            } else if ((value.length < 10) || (value.length > 10)) {
              return 'Enter valid phone number';
            }
            return null;
          },
          onSaved: (String value) {
            setState(() {
              _phno = value;
            });
          },
          style: TextStyle(
            color: Colors.black87,
            fontFamily: 'Montserrat',
          ),
          decoration: customInputDecoration(
              Icons.phone_android_rounded, 'Enter your Phone no'),
        ),
      ],
    );
  }

  void formSubmit() async {
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      _phno = "+91" + _phno;
      // print(_phno);
      await AuthService().login(_phno).then(
        (val) async {
          print(val);
          final Map parsed = json.decode(val.toString());
          final res = Res.fromJson(parsed);
          print(res.result);

          if (res.result == 'Welcome Buddy,Enter Otp!') {
            myNavigator = MyNavigator(_phno, _from);
            myNavigator.goToOtp(context);
            final SharedPreferences sharedPreferences =
                await SharedPreferences.getInstance();
            sharedPreferences.setString('phone', _phno);
            
            // OtpScreen(_phno, _from);
          } else if (res.result == 'Not Registered!') {
            Fluttertoast.showToast(
                msg: 'User doesn\'t exist',
                toastLength: Toast.LENGTH_SHORT,
                backgroundColor: Color(0xFF666666),
                textColor: Color(0xFFFFFFFF),
                fontSize: 15.0);
            // MyNavigator.goToOtp(context);
          }
        },
      );
    }
  }

  Widget _buildLogBtn() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25.0),
      width: double.infinity,
      child: RaisedButton(
        elevation: 3.0,
        onPressed: formSubmit,
        padding: EdgeInsets.all(15.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        color: Color(0xFFFFA751),
        child: Text(
          'Log Me In',
          style: TextStyle(
            color: Color(0xFFFFFFFF),
            letterSpacing: 1.5,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'Montserrat',
          ),
        ),
      ),
    );
  }

  Widget _buildSignupBtn() {
    return GestureDetector(
      onTap: () => MyNavigator.goToSignup(context),
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: 'New User? ',
              style: TextStyle(
                fontFamily: 'Montserrat',
                color: Color(0xFFFFA751),
                fontSize: 18.0,
                fontWeight: FontWeight.w400,
              ),
            ),
            TextSpan(
              text: 'Sign Up',
              style: TextStyle(
                fontFamily: 'Montserrat',
                color: Color(0xFFFF4E00),
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSkipBtn() {
    return GestureDetector(
      onTap: () => MyNavigator.goToHome(context),
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: 'Skip for now',
              style: TextStyle(
                fontFamily: 'Montserrat',
                color: Color(0xFFFF4E00),
                fontSize: 15.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Stack(
            children: <Widget>[
              Container(
                height: double.infinity,
                width: double.infinity,
                color: Color(0xFFffffff),
              ),
              Container(
                  height: double.infinity,
                  child: SingleChildScrollView(
                    physics: AlwaysScrollableScrollPhysics(),
                    padding: EdgeInsets.symmetric(
                      horizontal: 30.0,
                      vertical: 10.0,
                    ),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          //  ClipPath(
                          //   clipper: WaveClipperTwo(),
                          //   child: Container(
                          //     color:Color(0xFF8B4513),
                          //     height: 90.0,
                          //   ),
                          // ),
                          SizedBox(
                            height: 30.0,
                          ),
                          Text(
                            'Welcome back! \nGood to see you. ',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.brown,
                              fontFamily: 'Montserrat',
                              fontSize: 30.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 30.0),
                          _buildphoneno(),
                          _buildLogBtn(),
                          _buildSignupBtn(),
                          SizedBox(
                            height: 30.0,
                          ),
                          _buildSkipBtn(),
                        ],
                      ),
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
