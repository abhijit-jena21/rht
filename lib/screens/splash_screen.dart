import 'dart:async';
import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import '../screens/location.dart';
import '../screens/starter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:fluttertoast/fluttertoast.dart';

String finalPhone;
String finalEmail;
String finalName = "Guest";
String finalId;
String finalLocationId;
String finalLocation;
String finalAdminLocationId;
String finalAdminLocation;
String finalAddress;
String userId;
bool admin = false;
String serverLink = "http://2a6a37089d2d.ngrok.io";

class UserId {
  String id;

  UserId({this.id});

  UserId.fromJson(Map<String, dynamic> json) {
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    return data;
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Dio dio = new Dio();
  bool isExec;

  userCreate() async {
    try {
      final String pathUrl = "$serverLink/api/usercreation";
      Response response = await dio.get(pathUrl);
      var responseData = response.data;
      print(responseData);
      var user = UserId.fromJson(json.decode(responseData));
      print("here" + user.id);
      userId = user.id;
      print('splash' + userId);
      final SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      await sharedPreferences.setString('userId', userId);

      setState(() {
        finalId = userId;
      });
    } catch (e) {
      Fluttertoast.showToast(
          msg: "Couldn't connect to server",
          toastLength: Toast.LENGTH_SHORT,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 15.0);
    }
  }

  void initState() {
    isExec = false;
    getUserId().whenComplete(() async {
      if (finalId == null) await userCreate();
      // Timer(Duration(seconds: 10), () {});
      // else{
      print('splash2' + finalId.toString());
      setState(() {
        getPhone();
        getName();
        getAddress();
        getUserLocation().whenComplete(() async {
          // print(finalAdminLocation + "on splash");
          // print(finalAdminLocationId + 'on splash screen');
          if (finalId != null && finalLocationId == null) {
            Timer(
                Duration(seconds: 3),
                () => {
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Location(userId: finalId)),
                          (_) => false)
                    });
          } else if (finalId != null && finalLocationId != null) {
            Timer(
                Duration(seconds: 3),
                () => {
                      // MyNavigator.goToHome(context),
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Starter(
                                  location: finalLocation,
                                  locationId: finalLocationId,
                                  userId: finalId)),
                          (_) => false)
                    });
          }
        });
      });
    }
        // }
        );
    super.initState();
  }

  Future getUserId() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    var obtainedId = sharedPreferences.getString('userId');
    // var obtainedLocationId = sharedPreferences.getString('locationId');
    // var obtainedLocation = sharedPreferences.getString('location');

    setState(() {
      finalId = obtainedId;
      // finalLocationId = obtainedLocationId;
      // finalLocation = obtainedLocation;
    });
  }

  Future getUserLocation() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    var obtainedLocationId = sharedPreferences.getString('locationId');
    var obtainedLocation = sharedPreferences.getString('location');
    var obtainedAdminLocationId =
        sharedPreferences.getString('adminLocationId');
    var obtainedAdminLocation = sharedPreferences.getString('adminLocation');
    setState(() {
      // finalId = obtainedId;
      finalLocationId = obtainedLocationId;
      finalLocation = obtainedLocation;
      finalAdminLocation = obtainedAdminLocation;
      finalAdminLocationId = obtainedAdminLocationId;
    });
  }

  Future getPhone() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    var obtainedPhone = sharedPreferences.getString('phone');
    setState(() {
      finalPhone = obtainedPhone;
    });
  }

  Future getAddress() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    var obtainedAddress = sharedPreferences.getString('address');
    setState(() {
      finalAddress = obtainedAddress;
    });
  }

  Future getEmail() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    var obtainedEmail = sharedPreferences.getString('email');
    setState(() {
      finalEmail = obtainedEmail;
    });
  }

  Future getName() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    var obtainedName = sharedPreferences.getString('name');
    setState(() {
      finalName = obtainedName;
    });
  }

  @override
  Widget build(BuildContext context) {
    // if (isExec == false) {
    //   userCreate();
    //   isExec = true;
    // }
    print(finalPhone.toString());
    return Scaffold(
        backgroundColor: Theme.of(context).accentColor,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          // fit: StackFit.expand,
          children: <Widget>[
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.25,
            ),
            Container(
              alignment: Alignment.center,
              // decoration: BoxDecoration(
              //     gradient: LinearGradient(
              //   begin: Alignment.topLeft,
              //   end: Alignment.bottomRight,
              //   colors: [
              //     Theme.of(context).primaryColor,
              //     Theme.of(context).accentColor
              //   ],
              // )),
              // child: Image.asset(
              //   'assets/images/splash.png',
              //   fit: BoxFit.fill,
              // ),
              child: FadeAnimatedTextKit(
                duration: Duration(seconds: 5),
                text: ["RHT"],
                textStyle: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 50.0),
              ),
            ),

            // Column(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: <Widget>[
            //     Expanded(
            //       flex: 2,
            //       child:
            // Container(
            // child: Column(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: <Widget>[
            //     CircleAvatar(
            //       backgroundColor: Color(0xFFCD853F),
            //       radius: 50.0,
            //       child: Icon(
            //         Icons.shopping_cart,
            //         color: Colors.brown,
            //         size: 50.0,
            //       ),
            //     ),
            //     Padding(
            //       padding: EdgeInsets.only(top: 10.0),
            //     ),

            // ],
            // ),
            // ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.25,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                CircularProgressIndicator(
                  backgroundColor: Colors.white,
                  strokeWidth: 1,
                ),
                Padding(
                  padding: EdgeInsets.only(top: 20.0),
                ),
                Text(
                  "Fetching data",
                  softWrap: true,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 10.0,
                      color: Colors.white),
                )
              ],
            ),
          ],
        ));
  }
}
