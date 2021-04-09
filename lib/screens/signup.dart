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
import 'package:rht/.env.dart';
import 'package:dio/dio.dart';
import 'package:mapbox_search_flutter/mapbox_search_flutter.dart';
import 'package:country_code_picker/country_code_picker.dart';


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
  final String route;
  final String receivedId;
  final String userId;
  // MapBoxPlace pace = MapBoxPlace();
  SignupScreen({this.phone, this.route, this.receivedId, this.userId});
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  String _name;
  String _email;
  String _phno;
  String _addr;

  Dio dio = Dio();

  String _from = "signup";

  String valString;

  MyNavigator myNavigator;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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
        // color: Theme.of(context).accentColor,
      ),
      hintText: title,
      hintStyle: kHintTextStyle,
    );
  }

  Widget _buildname() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text('Name',
            style: Theme.of(context)
                .textTheme
                .bodyText1
                .copyWith(color: Theme.of(context).primaryColor)),
        SizedBox(height: 10.0),
        TextFormField(
          keyboardType: TextInputType.name,
          textCapitalization: TextCapitalization.words,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          autofocus: true,
          style: TextStyle(
            color: Colors.black87,
            fontFamily: 'Montserrat',
          ),
          decoration: customInputDecoration(Icons.account_box_outlined, 'Name'),
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

  // void findPlace(String placeName) async {
  //   if (placeName.length > 1) {
  //     String autoCompleteUrl =
  //         "https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$placeName&key=$placesKey&sessiontoken=1234567890";
  //     try {
  //       print("her22");
  //       var res = await dio.get(autoCompleteUrl);
  //       print(res);
  //     } catch (e) {
  //       print("here 33");
  //     }
  //   }
  // }

  Widget _buildaddress() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Address',
          style: Theme.of(context)
              .textTheme
              .bodyText1
              .copyWith(color: Theme.of(context).primaryColor),
        ),
        SizedBox(height: 10.0),
        // Container(
        //   height: 75,
        //   child: MapBoxPlaceSearchWidget(
        //     // height: 30,
        //     popOnSelect: false,
        //     apiKey:
        //         "pk.eyJ1IjoiYWJoaWppdGplbmEiLCJhIjoiY2tuOHc0ZzhuMTF6dDJ3bzY3cWFsbzY4ayJ9.24M_6iAb55kSVx_SBpiadA",
        //     country: "in",
        //     searchHint: 'Address',
        //     onSelected: (place) {
        //       MapBoxPlace searchedplace = place;
        //       print(searchedplace);
        //       print(place.runtimeType);
        //       print("place" + place.toRawJson());
        //       print(searchedplace.context[0].text);
        //       setState(() {
        //         var addr = place;
        //         print(addr);
        //       });
        //     },
        //     context: context,
        //   ),
        // )

        TextFormField(
          keyboardType: TextInputType.streetAddress,
          textCapitalization: TextCapitalization.words,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          style: TextStyle(
            color: Colors.black87,
            fontFamily: 'Montserrat',
          ),
          decoration:
              customInputDecoration(Icons.add_business_outlined, 'Address'),
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
          style: Theme.of(context)
              .textTheme
              .bodyText1
              .copyWith(color: Theme.of(context).primaryColor),
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
          decoration: customInputDecoration(Icons.email, 'Email'),
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
                textStyle: Theme.of(context).textTheme.bodyText1.copyWith(color: Colors.black87),
                dialogTextStyle: Theme.of(context).textTheme.bodyText1.copyWith(color: Colors.black87),
                searchStyle: Theme.of(context).textTheme.bodyText1.copyWith(color: Colors.black87),
              ),
            ),
            Expanded(
              flex: 3,
                          child: TextFormField(
                initialValue: widget.phone != null ? widget.phone : null,
                readOnly: widget.phone != null ? true : false,
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
      ],
    );
  }

  void formSubmit() async {
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();

      _phno = "+91" + _phno;
      // print(_phno);
      await AuthService().signUp(widget.receivedId, _phno).then(
        (val) async {
          print(val);
          final Map parsed = json.decode(val.toString());
          final res = Res.fromJson(parsed);
          print(res.result);

          if (res.result == 'Phone Authentication Required!') {
            myNavigator = MyNavigator(_phno, _from);

            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => OtpScreen(
                          _name,
                          _addr,
                          _email,
                          _phno,
                          _from,
                          widget.route,
                          widget.receivedId,
                          userId: widget.userId,
                          isAdmin: false,
                        )));
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
      // ignore: deprecated_member_use
      child: RaisedButton(
        elevation: 0,
        onPressed: formSubmit,
        padding: EdgeInsets.all(15.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
        color: Theme.of(context).buttonColor,
        child: Text(
          'Sign Up',
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

  // ignore: unused_element
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
    return IconButton(
        icon: Icon(
          Icons.arrow_back,
          color: Colors.black54,
        ),
        onPressed: () {
          if (widget.route == "/checkout")
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                    builder: (context) => Cart(
                          userId: finalId,
                        )),
                (_) => false);
          else if (widget.route == "/profile") Navigator.pop(context);
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
        body: Container(
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(
                horizontal: 20.0,
                vertical: 10.0,
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.01,
                    ),
                    Text(
                      'Welcome to RHT!'
                      '\nLet\'s get you started ',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontFamily: 'Montserrat',
                        fontSize: 25.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.04),
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
                    _buildSignBtn(),
                    SizedBox(height: 20.0),
                  ],
                ),
              ),
            )));
  }
}
