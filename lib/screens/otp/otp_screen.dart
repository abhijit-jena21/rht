import 'package:flutter/material.dart';

// import '../widgets/constants.dart';
import '../../utils/size_config.dart';
import './otp_body.dart';

class OtpScreen extends StatelessWidget {
  final String _number;
  final String _from;
  OtpScreen(this._number, this._from);
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Color(0xFFFFA751)),
        backgroundColor: Color(0xFFFFFFFF),
        elevation: 0,
        // title: Center(
        //   child: Text("OTP Verification",
        //   style: kLabelStyle,),
        // ),
      ),
      body: Body(_number,_from),
    );
  }
}
