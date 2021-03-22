import 'package:flutter/material.dart';
import './screens/subcategories.dart';

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

  // void goToOtp(BuildContext context) {
  //   Navigator.push(context,
  //       MaterialPageRoute(builder: (context) => OtpScreen(number, from)));
  // }

  static void goToLogin(BuildContext context) {
    Navigator.pushNamed(context, "/login");
  }

  // static void goToLocation(BuildContext context) {
  //   // Navigator.pushNamed(context, "/location");
  //   Navigator.pushAndRemoveUntil(
  //       context,
  //       MaterialPageRoute(builder: (context) => Location(userId: userId)),
  //       (_) => false);
  // }

  static void goToHome(BuildContext context) {
    Navigator.pushNamedAndRemoveUntil(context, "/home", (_) => false);
  }

  void goToCategory(BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => SubCategories(id)));
  }
  // void goToProduct(BuildContext context){
  //   Navigator.push(
  //     context, MaterialPageRoute(builder: (context)=> ProductDetail(name,img,details,price,rent,duration,items))
  //   )
  // }
}
