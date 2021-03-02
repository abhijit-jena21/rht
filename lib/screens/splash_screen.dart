import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:rht/screens/starter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../my_navigator.dart';

String finalPhone;
String finalId;
String finalLocationId;
String finalLocation;

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
  String userId;

  void userCreate() async {
    final String pathUrl = "http://10.0.3.2:8080/api/usercreation";
    Response response = await dio.get(pathUrl);
    var responseData = response.data;
    print(responseData);
    var user = UserId.fromJson(json.decode(responseData));
    print("here" + user.id);
    userId = user.id;
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    sharedPreferences.setString('userId', userId);
  }

  void initState() {
    userCreate();
    getUserId().whenComplete(() async {
      // print("here2" + finalLocationId);
      if (finalId == null && finalLocation == null)
        Timer(
            Duration(seconds: 3),
            () => {
                  MyNavigator.goToLocation(context),
                });
      else
        Timer(
            Duration(seconds: 3),
            () => {
                  // MyNavigator.goToHome(context),
                  Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        Starter(title: finalLocation, locationId: finalLocationId)),
                (_) => false)
                });
    });

    // getValidationData().whenComplete(() async {
    //   // if(finalPhone == null)
    //   //   Timer(Duration(seconds: 3), () => MyNavigator.goToSignup(context));
    //   // else
    //   Timer(
    //       Duration(seconds: 3),
    //       () => {
    //             MyNavigator.goToLocation(context),
    //           });
    // });
    super.initState();
  }

  Future getUserId() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    var obtainedId = sharedPreferences.getString('userId');
    var obtainedLocationId = sharedPreferences.getString('locationId');
    var obtainedLocation = sharedPreferences.getString('location');

    setState(() {
      finalId = obtainedId;
      finalLocationId = obtainedLocationId;
      finalLocation = obtainedLocation;
    });
  }

  // Future getUserLocation() async {
  //   final SharedPreferences sharedPreferences =
  //       await SharedPreferences.getInstance();

  //   setState(() {
  //     finalLocation = obtainedLocation;
  //   });
  // }

  Future getValidationData() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    var obtainedPhone = sharedPreferences.getString('phone');
    setState(() {
      finalPhone = obtainedPhone;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(color: Color(0xFF8B4513)),
            child: Image.asset(
              'assets/images/splash.png',
              fit: BoxFit.fill,
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Expanded(
                flex: 2,
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      CircleAvatar(
                        backgroundColor: Color(0xFFCD853F),
                        radius: 50.0,
                        child: Icon(
                          Icons.shopping_cart,
                          color: Colors.brown,
                          size: 50.0,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 10.0),
                      ),
                      Text(
                        "RHT",
                        style: TextStyle(
                            color: Colors.brown,
                            fontWeight: FontWeight.bold,
                            fontSize: 24.0),
                      )
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    CircularProgressIndicator(),
                    Padding(
                      padding: EdgeInsets.only(top: 20.0),
                    ),
                    Text(
                      "Easy Rental \nfor everyone",
                      softWrap: true,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15.0,
                          color: Colors.brown),
                    )
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
