import 'package:flutter/material.dart';

// import '../widgets/constants.dart';
import '../../utils/size_config.dart';
import './otp_body.dart';

class OtpScreen extends StatelessWidget {
  final String _name;
  final String _addr;
  final String _email;
  final String _number;
  final String _from; 
  final String _route;
  final String receivedId;
  final String userId;
  final bool isAdmin;
  OtpScreen(this._name, this._addr, this._email, this._number, this._from,
      this._route, this.receivedId,
      {this.userId, this.isAdmin});
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
      body: Body(
        _name,
        _addr,
        _email,
        _number,
        _from,
        _route,
        receivedId,
        userId: userId,
        isAdmin: isAdmin
      ),
    );
  }
}
