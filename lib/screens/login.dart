import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:rht/screens/cart.dart';
import 'package:rht/screens/splash_screen.dart';
import '../screens/signup.dart';
import '../screens/otp/otp_screen.dart';

import '../utils/constants.dart';
import '../my_navigator.dart';
import '../services/authservice.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Res {
  String sId;
  String phone;
  String name;
  String address;
  String email;

  Res({this.sId, this.phone, this.name, this.address, this.email});

  factory Res.fromJson(Map<String, dynamic> json) {
    return Res(
        sId: json['userid'],
        phone: json['contact'],
        name: json['name'],
        address: json['address'],
        email: json['email']);
  }
}

class LoginScreen extends StatefulWidget {
  final String _route;
  LoginScreen(this._route);
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _phno;
  String _from = "login";

  MyNavigator myNavigator;

  Res res;
  void initState() {
    super.initState();
    res = new Res();
  }

  InputDecoration customInputDecoration(IconData icon, String title) {
    return InputDecoration(
      contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
      focusedBorder: OutlineInputBorder(
        borderSide:
            BorderSide(color: Theme.of(context).primaryColor, width: 2.0),
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
        borderSide:
            BorderSide(color: Theme.of(context).primaryColor, width: 2.0),
        borderRadius: BorderRadius.all(Radius.circular(5)),
      ),
      border: OutlineInputBorder(
        borderSide:
            BorderSide(color: Theme.of(context).primaryColor, width: 2.0),
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

  Widget _buildphoneno() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Phone no',
          style: Theme.of(context)
              .textTheme
              .bodyText1
              .copyWith(color: Theme.of(context).primaryColor),
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
      var phno = "+91" + _phno;
      // print(_phno);
      await AuthService().login(_phno, finalId).then(
        (val) async {
          print(val);
          final Map parsed = json.decode(val.toString());
          res = Res.fromJson(parsed);
          print(res.sId);

          if (res.sId != finalId) {
            myNavigator = MyNavigator(_phno, _from);
            // myNavigator.goToOtp(context);
            final SharedPreferences sharedPreferences =
                await SharedPreferences.getInstance();
            sharedPreferences.setString('address', res.address);
            finalAddress = res.address;
            sharedPreferences.setString('name', res.name);
            finalName = res.name;
            sharedPreferences.setString('email', res.email);
            finalEmail = res.email;

            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        OtpScreen(phno, _from, widget._route, res.sId)));
          } else if (res.sId == finalId && res.name == "guest") {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        SignupScreen(_phno, widget._route, res.sId)));
            // MyNavigator.goToOtp(context);
          } else if (res.sId == finalId && res.name != "guest") {
            final SharedPreferences sharedPreferences =
                await SharedPreferences.getInstance();
            sharedPreferences.setString('address', res.address);
            finalAddress = res.address;
            sharedPreferences.setString('name', res.name);
            finalName = res.name;
            sharedPreferences.setString('email', res.email);
            finalEmail = res.email;
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        OtpScreen(phno, _from, widget._route, res.sId)));
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
        // elevation: 3.0,
        onPressed: formSubmit,
        padding: EdgeInsets.all(15.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
        color: Theme.of(context).accentColor,
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
      onTap: () => myNavigator.goToSignup(context),
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
      onTap: () {
        if (widget._route == "/checkout")
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                  builder: (context) => Cart(
                        userId: finalId,
                      )),
              (_) => false);
        else if (widget._route == "/profile") Navigator.pop(context);
      },
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
                            'Hello.\nWelcome to RHT.',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.blue.shade600,
                              fontFamily: 'Montserrat',
                              fontSize: 30.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 30.0),
                          _buildphoneno(),
                          _buildLogBtn(),
                          // _buildSignupBtn(),
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
