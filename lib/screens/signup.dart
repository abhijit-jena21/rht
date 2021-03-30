import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/services.dart';
import 'package:rht/screens/cart.dart';
import 'package:rht/screens/splash_screen.dart';

import '../my_navigator.dart';
import '../utils/constants.dart';
import '../services/authservice.dart';
import 'otp/otp_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';

class Res {
  String error;
  String result;

  Res({this.error, this.result});

  factory Res.fromJson(Map<String, dynamic> json) {
    return Res(error: json['error'], result: json['result']);
  }
}

class SignupScreen extends StatefulWidget {
  final String phone;
  final String _route;
  final String _receivedId;
  SignupScreen(this.phone, this._route, this._receivedId);
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  String _name;
  String _email;
  String _phno;
  String _addr;

  String _from = "signup";

  String valString;

  MyNavigator myNavigator;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  InputDecoration customInputDecoration(IconData icon, String title) {
    return InputDecoration(
      contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 2.0),
        borderRadius: BorderRadius.all(Radius.circular(5)),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.black54, width: 2.0),
        borderRadius: BorderRadius.all(Radius.circular(5)),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.red[400], width: 2.0),
        borderRadius: BorderRadius.all(Radius.circular(5)),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 2.0),
        borderRadius: BorderRadius.all(Radius.circular(5)),
      ),
      border: OutlineInputBorder(
        borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 2.0),
        borderRadius: BorderRadius.all(Radius.circular(5)),
      ),
      prefixIcon: Icon(
        icon,
        // Icons.account_box_outlined,
        color: Theme.of(context).primaryColor,
      ),
      hintText: title,
      hintStyle: kHintTextStyle,
    );
  }

  Widget _buildname() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Name',
          style: Theme.of(context).textTheme.bodyText1.copyWith(color: Theme.of(context).primaryColor)
        ),
        SizedBox(height: 10.0),
        TextFormField(
          keyboardType: TextInputType.name,
          textCapitalization: TextCapitalization.words,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          style: TextStyle(
            color: Colors.black87,
            fontFamily: 'Montserrat',
          ),
          decoration: customInputDecoration(
              Icons.account_box_outlined, 'Enter your name'),
          // ignore: missing_return
          validator: (value) {
            if (value.isEmpty) {
              return 'Name is Required';
            }
            // return null;
          },
          onSaved: (String value) {
            setState(() {
              _name = value;
            });
          },
        ),
        // ),
      ],
    );
  }

  Widget _buildaddress() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Address',
          style: Theme.of(context).textTheme.bodyText1.copyWith(color: Theme.of(context).primaryColor),
        ),
        SizedBox(height: 10.0),
        TextFormField(
          keyboardType: TextInputType.streetAddress,
          textCapitalization: TextCapitalization.words,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          style: TextStyle(
            color: Colors.black87,
            fontFamily: 'Montserrat',
          ),
          decoration: customInputDecoration(
              Icons.add_business_outlined, 'Enter your Address'),
          validator: (String value) {
            if (value.isEmpty) {
              return 'Address is Required';
            }
            return null;
          },
          onSaved: (String value) {
            setState(() {
              _addr = value;
            });
          },
        ),
      ],
    );
  }

  Widget _buildemail() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Email',
          style: Theme.of(context).textTheme.bodyText1.copyWith(color: Theme.of(context).primaryColor),
        ),
        SizedBox(height: 10.0),
        TextFormField(
          keyboardType: TextInputType.emailAddress,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          // maxLength: 10,
          style: TextStyle(
            color: Colors.black87,
            fontFamily: 'Montserrat',
          ),
          decoration: customInputDecoration(Icons.email, 'Enter your Email'),
          validator: (String value) {
            if (value.isEmpty) {
              return 'Email is Required';
            } else if (!RegExp("^[a-zA-Z0-9+_.-]+@[A-Za-z0-9.-]+.[a-z]")
                .hasMatch(value)) {
              return 'Please enter a valid email';
            }
            return null;
          },
          onSaved: (String value) {
            setState(() {
              _email = value;
            });
          },
        ),
      ],
    );
  }

  Widget _buildphoneno() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Phone no',
          style: Theme.of(context).textTheme.bodyText1.copyWith(color: Theme.of(context).primaryColor),
        ),
        SizedBox(height: 10.0),
        TextFormField(
          initialValue: widget.phone,
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
      await AuthService()
          .signUp(_name, _email, _phno, _addr, widget._receivedId)
          .then(
        (val) async {
          print(val);
          final Map parsed = json.decode(val.toString());
          final res = Res.fromJson(parsed);
          print(res.result);

          if (res.result == 'Phone Authentication Required!') {
            myNavigator = MyNavigator(_phno, _from);
            final SharedPreferences sharedPreferences =
                await SharedPreferences.getInstance();
            sharedPreferences.setString('address', _addr);
            finalAddress = _addr;
            sharedPreferences.setString('name', _name);
            finalName = _name;
            sharedPreferences.setString('email', _email);
            finalEmail = _email;

            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => OtpScreen(
                        _phno, _from, widget._route, widget._receivedId)));
          }
          if (res.result == 'Phone Number already Registered!!') {
            Fluttertoast.showToast(
                msg: 'User already exists',
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

  Widget _buildSignBtn() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25.0),
      width: double.infinity,
      child: RaisedButton(
        // elevation: 3.0,
        // onPressed: () => MyNavigator.goToOtp(context),
        onPressed: formSubmit,
        padding: EdgeInsets.all(15.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
        color: Theme.of(context).accentColor,
        child: Text(
          'Sign Me Up',
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

  Widget _buildLoginpBtn() {
    return GestureDetector(
      onTap: () => MyNavigator.goToLogin(context),
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: 'Existing User? ',
              style: TextStyle(
                fontFamily: 'Montserrat',
                color: Color(0xFFFFA751),
                fontSize: 18.0,
                fontWeight: FontWeight.w400,
              ),
            ),
            TextSpan(
              text: 'Log In',
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
      onTap: () => Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context)=>Cart(userId: finalId,)),
        (_)=>false),
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: 'Back',
              style: TextStyle(
                fontFamily: 'Montserrat',
                color: Color(0xFF343434),
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
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Stack(
            children: <Widget>[
              Container(
                height: double.infinity,
                width: double.infinity,
                color: Colors.white,
              ),
              Container(
                  child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(
                  horizontal: 30.0,
                  vertical: 10.0,
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      // ClipPath(
                      //   clipper: WaveClipperTwo(),
                      //   child: Container(
                      //     color: Color(0xFF8B4513),
                      //     height: 90.0,
                      //   ),
                      // ),
                      SizedBox(
                        height: 30.0,
                      ),
                      Text(
                        'Welcome to RHT!'
                        '\nLet\'s get you started ',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.black87,
                          fontFamily: 'Montserrat',
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 60.0),
                      _buildname(),
                      SizedBox(
                        height: 10.0,
                      ),
                      SizedBox(height: 10.0),
                      _buildaddress(),
                      SizedBox(
                        height: 10.0,
                      ),
                      SizedBox(height: 10.0),
                      _buildemail(),
                      SizedBox(
                        height: 10.0,
                      ),
                      SizedBox(height: 10.0),
                      _buildphoneno(),
                      SizedBox(height: 10.0),
                      // _buildRememberMeCheckbox(),
                      _buildSignBtn(),
                      // _buildLoginpBtn(),
                      SizedBox(height: 20.0),
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
