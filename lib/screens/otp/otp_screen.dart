import 'package:flutter/material.dart';

// import '../widgets/constants.dart';
import '../../utils/size_config.dart';
import './otp_body.dart';

class OtpScreen extends StatelessWidget {
  final String _number;
  final String _from;
  final String _route;
  final String receivedId;
  OtpScreen(this._number, this._from, this._route, this.receivedId);
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
        backgroundColor: Color(0xFFFFFFFF),
        elevation: 0,
        // title: Center(
        //   child: Text("OTP Verification",
        //   style: kLabelStyle,),
        // ),
      ),
      body: Body(_number, _from, _route, receivedId),
    );
  }
}
