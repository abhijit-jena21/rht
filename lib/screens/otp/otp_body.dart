import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../../utils/size_config.dart';
import '../splash_screen.dart';
import './otp_form.dart';
import 'package:delayed_display/delayed_display.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'dart:async';

// ignore: must_be_immutable
class Body extends StatefulWidget {
  String _name;
  String _addr;
  String _email;
  String _number;
  String _from;
  String _route;
  String _receivedId;
  String userId;
  bool isAdmin;

  Body(this._name, this._addr, this._email, this._number, this._from,
      this._route, this._receivedId,
      {this.userId, this.isAdmin});

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  Dio dio = new Dio();

  Timer _timer;
  bool hide = false;
  int _start = 10;

  int endTime = DateTime.now().millisecondsSinceEpoch + 1000 * 30;

  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_start == 0) {
          setState(() {
            timer.cancel();
            hide = true;
          });
        } else {
          setState(() {
            _start--;
          });
        }
      },
    );
  }

  void initState() {
    super.initState();
    startTimer();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  Widget resend() {
    // ignore: deprecated_member_use
    return RaisedButton(
      elevation: 0,
      color: Theme.of(context).accentColor,
      child: Text(
        "Resend OTP Code",
        style: TextStyle(
            // decoration: TextDecoration.underline,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontSize: 15),
      ),
      onPressed: () async {
        // startTimer();
        await dio.post("$serverLink/api/resend",
            data: {"_id": widget._receivedId},
            options: Options(headers: {
              'Content-type': 'application/json; charset=UTF-8',
            }));
      },
    );
  }

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
                style: Theme.of(context)
                    .textTheme
                    .headline6
                    .copyWith(color: Theme.of(context).primaryColor),
              ),
              Container(
                  padding: EdgeInsets.symmetric(horizontal: 5, vertical: 20),
                  child: Text("We sent your code to your phone no.",
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1
                          .copyWith(color: Colors.black54))),
              OtpForm(widget._name, widget._addr, widget._email, widget._number,
                  widget._from, widget._route, widget._receivedId,
                  userId: widget.userId, isAdmin: widget.isAdmin),
              SizedBox(height: SizeConfig.screenHeight * 0.1),
              CountdownTimer(
                endTime: endTime,
                textStyle: TextStyle(
                    color: Theme.of(context).accentColor, fontSize: 15),
                endWidget: resend(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
