import 'package:flutter/material.dart';

class MyNavigator {
  String number;
  String from;
  String id;
  Function func;
  String userId;
  MyNavigator(this.number, this.from);
  MyNavigator.category(this.id);
  MyNavigator.user(this.userId);
  void goToSignup(BuildContext context) {
    Navigator.pushNamed(context, "/signup");
  }

  static void goToLogin(BuildContext context) {
    Navigator.pushNamed(context, "/login");
  }


  static void goToHome(BuildContext context) {
    Navigator.pushNamedAndRemoveUntil(context, "/home", (_) => false);
  }

}
