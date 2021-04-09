import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:rht/screens/cart.dart';
import 'package:rht/screens/splash_screen.dart';
import 'package:rht/widgets/progressindicator.dart';
import '../screens/signup.dart';
import '../screens/otp/otp_screen.dart';

import '../utils/constants.dart';
import '../my_navigator.dart';
import '../services/authservice.dart';
import 'package:sms_autofill/sms_autofill.dart';
import 'package:country_code_picker/country_code_picker.dart';

class Res {
  String sId;
  String phone;
  String name;
  String address;
  String email;
  bool isAdmin;

  Res(
      {this.sId,
      this.phone,
      this.name,
      this.address,
      this.email,
      this.isAdmin});

  factory Res.fromJson(Map<String, dynamic> json) {
    return Res(
        sId: json['userid'],
        phone: json['contact'],
        name: json['name'],
        address: json['address'],
        email: json['email'],
        isAdmin: json['isadmin']);
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
  MyProgressIndicatorWidget myProgressIndicatorWidget =
      MyProgressIndicatorWidget();

  String _phno;
  String _from = "login";
  bool visible = false;

  loadProgress() {
    if (visible == true) {
      setState(() {
        visible = false;
      });
    } else {
      setState(() {
        visible = true;
      });
    }
  }

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
        borderSide: BorderSide(color: Colors.black38, width: 2.0),
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
        color: Theme.of(context).accentColor,
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
          Row(
            children: [
              Expanded(
                flex: 1,
                  child: CountryCodePicker(
                  enabled: false,
                  flagWidth: 32,
                  hideMainText: true,
                  initialSelection: 'IN',
                  padding: EdgeInsets.zero,
                  showFlag: true,
                  alignLeft: true,
                  textStyle: Theme.of(context)
                      .textTheme
                      .bodyText1
                      .copyWith(color: Colors.black87),
                  dialogTextStyle: Theme.of(context)
                      .textTheme
                      .bodyText1
                      .copyWith(color: Colors.black87),
                  searchStyle: Theme.of(context)
                      .textTheme
                      .bodyText1
                      .copyWith(color: Colors.black87),
                ),
              ),
              Expanded(
                flex: 3,
                child: TextFormField(
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
                  decoration:
                      customInputDecoration(Icons.phone_android_rounded, 'Phone'),
                ),
              ),
            ],
          ),
        ]);
  }

  void formSubmit() async {
    loadProgress();
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
            loadProgress();
            myNavigator = MyNavigator(_phno, _from);
            final signcode = await SmsAutoFill().getAppSignature;
            print("signcode" + signcode.toString());
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => OtpScreen(res.name, res.address,
                        res.email, phno, _from, widget._route, finalId,
                        userId: res.sId, isAdmin: res.isAdmin)));
          } else if (res.sId == finalId && res.name == "guest") {
            loadProgress();
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => SignupScreen(
                        phone: _phno,
                        route: widget._route,
                        receivedId: res.sId,
                        userId: res.sId)));
          } else if (res.sId == finalId && res.name != "guest") {
            loadProgress();
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => OtpScreen(res.name, res.address,
                        res.email, phno, _from, widget._route, finalId)));
            // MyNavigator.goToOtp(context);
          }
        },
      );
    }
  }

  Widget _progress() {
    return Visibility(
        maintainSize: true,
        maintainAnimation: true,
        maintainState: true,
        visible: visible,
        child: Container(
            margin: EdgeInsets.only(top: 10, bottom: 5),
            child: LinearProgressIndicator()));
  }

  Widget _buildLogBtn() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25.0),
      width: double.infinity,
      // ignore: deprecated_member_use
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // ignore: deprecated_member_use
          RaisedButton(
            // elevation: 3.0,
            onPressed: formSubmit,
            elevation: 0,
            padding: EdgeInsets.all(15.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.0),
            ),
            color: Theme.of(context).buttonColor,
            child: Text(
              'Log In',
              style: TextStyle(
                color: Color(0xFFFFFFFF),
                letterSpacing: 1.5,
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                fontFamily: 'Montserrat',
              ),
            ),
          ),
          _progress()
        ],
      ),
    );
  }

  // ignore: unused_element
  Widget _buildSignupBtn() {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => SignupScreen(
                      route: widget._route,
                      receivedId: finalId,
                      userId: finalId,
                    )));
      },
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: 'New User? ',
              style: TextStyle(
                fontFamily: 'Montserrat',
                color: Theme.of(context).primaryColor,
                fontSize: 18.0,
                fontWeight: FontWeight.w400,
              ),
            ),
            TextSpan(
              text: 'Sign Up',
              style: TextStyle(
                decoration: TextDecoration.underline,
                fontFamily: 'Montserrat',
                color: Theme.of(context).accentColor,
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
    return IconButton(
        icon: Icon(
          Icons.arrow_back,
          color: Colors.black54,
        ),
        onPressed: () {
          if (widget._route == "/checkout")
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                    builder: (context) => Cart(
                          userId: finalId,
                        )),
                (_) => false);
          else if (widget._route == "/profile") Navigator.pop(context);
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            foregroundColor: Colors.white,
            backgroundColor: Colors.white,
            shadowColor: Colors.transparent,
            leading: _buildSkipBtn()),
        backgroundColor: Theme.of(context).primaryColor,
        body: Container(
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            height: MediaQuery.of(context).size.height,
            child: SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              padding: EdgeInsets.symmetric(
                horizontal: 20.0,
                vertical: 10.0,
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    //  ClipPath(
                    //   clipper: WaveClipperTwo(),
                    //   child: Container(
                    //     color:Color(0xFF8B4513),
                    //     height: 90.0,
                    //   ),
                    // ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.1,
                    ),
                    Text(
                      'Hello!\nWelcome to RHT',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontFamily: 'Montserrat',
                        fontSize: 25.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.1),
                    _buildphoneno(),
                    _buildLogBtn(),
                    SizedBox(
                      height: 30,
                    ),
                    _buildSignupBtn(),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.1,
                    ),
                    // _buildSkipBtn(),
                  ],
                ),
              ),
            )));
  }
}
