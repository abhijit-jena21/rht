import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../utils/constants.dart';
import '../../utils/size_config.dart';
import '../splash_screen.dart';
import './otp_form.dart';

// ignore: must_be_immutable
class Body extends StatelessWidget {
  String _number;
  String _from;
  String _route;
  Dio dio = new Dio();
  Body(this._number, this._from, this._route);
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding:
            EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: SizeConfig.screenHeight * 0.05),
              Text(
                "OTP Verification",
                style: kLabelStyle,
              ),
              Container(
                  padding: EdgeInsets.symmetric(horizontal: 5, vertical: 20),
                  child: Text("We sent your code to your phone no.",
                      style: Theme.of(context).textTheme.headline3)),
              // Container(
              //   padding: EdgeInsets.symmetric(horizontal: 5,vertical: 20),
              //   child: buildTimer()),
              OtpForm(_number, _from, _route),
              SizedBox(height: SizeConfig.screenHeight * 0.1),
              GestureDetector(
                onTap: () async {
                  await dio.get("$serverLink/api/resend");
                },
                child: Text(
                  "Resend OTP Code",
                  style: TextStyle(
                      decoration: TextDecoration.underline,
                      color: Color(0xFFFFA751),
                      fontSize: 15),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  // Row buildTimer() {
  //   return Row(
  //     mainAxisAlignment: MainAxisAlignment.center,
  //     children: [
  //       Text("This code will expired in "),
  //       TweenAnimationBuilder(
  //         tween: Tween(begin: 30.0, end: 0.0),
  //         duration: Duration(seconds: 30),
  //         builder: (_, value, child) => Text(
  //           "00:${value.toInt()}",
  //           style: TextStyle(color: Colors.brown),
  //         ),
  //       ),
  //     ],
  //   );
  // }
}
