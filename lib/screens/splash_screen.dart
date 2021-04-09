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
String finalToken;
String userId;
bool finalAdmin;
bool admin = false;
String serverLink = "http://fc1f5a6a516a.ngrok.io";

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
      userId = user.id;
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
      setState(() {
        getPhone();
        getName();
        getAddress();
        getEmail();
        getToken();
        getAdmin();
        getUserLocation().whenComplete(() async {
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
    setState(() {
      finalId = obtainedId;
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

  Future getToken() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    var obtainedToken = sharedPreferences.getString('token');
    setState(() {
      finalToken = obtainedToken;
    });
  }

  Future getAdmin() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    var obtainedAdmin = sharedPreferences.getBool('isadmin');
    setState(() {
      finalAdmin = obtainedAdmin;
    });
  }

  @override
  Widget build(BuildContext context) {
    print(finalPhone.toString());
    return Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          // fit: StackFit.expand,
          children: <Widget>[
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.25,
            ),
            Container(
              alignment: Alignment.center,
              child: FadeAnimatedTextKit(
                duration: Duration(seconds: 5),
                text: ["RHT"],
                textStyle: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 50.0),
              ),
            ),
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
                  "Loading data",
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
