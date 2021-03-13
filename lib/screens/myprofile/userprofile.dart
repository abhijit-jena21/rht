import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:rht/screens/login.dart';
import '../../screens/splash_screen.dart';
import '../../services/usercheckservice.dart';
import '../../my_navigator.dart';
import 'drawer_bloc.dart';

import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Res {
  String error;
  String result;

  Res({this.error, this.result});

  factory Res.fromJson(Map<String, dynamic> json) {
    return Res(error: json['error'], result: json['result']);
  }
}

class UserProfileScreen extends StatefulWidget with DrawerStates {
  @override
  _UserProfileScreenState createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  Dio dio = new Dio();
  bool exist;
  var res;
  MyNavigator myNavigator;
  String response;
  Usercheck usercheck = Usercheck();

  void initState() {
    super.initState();
    // setState(() {
    if (finalPhone == null) {
      exist = false;
      {
        Fluttertoast.showToast(
            msg: 'User doesn\'t exist',
            toastLength: Toast.LENGTH_SHORT,
            backgroundColor: Color(0xFF666666),
            textColor: Color(0xFFFFFFFF),
            fontSize: 15.0);
      }
    } else {
      exist = true;
    }
    usercheck.account(finalId, exist).then((result) {
      print(result);
      final Map parsed = json.decode(result.toString());
      res = Res.fromJson(parsed);
      print(res.result);
    });
  }

  @override
  Widget build(BuildContext context) {
    var userName = "Guest";
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: <Widget>[
            Text(
              "Hello $userName",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black.withOpacity(0.5),
                fontSize: 18,
              ),
            ),
            if (exist == false) button(),
            // SizedBox(height: 25.0),
            if (exist == true) box(context)
          ],
        ),
      ),
    );
  }

  Widget button() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            height: 30,
          ),
          InkWell(
            onTap: () {
              print("here" + res.result);
              if (res.result == "Not registered")
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => LoginScreen("/profile")));
            },
            child: Container(
              height: 40,
              width: 150,
              decoration: BoxDecoration(
                color: Color(0xFFFFA751),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Center(
                child: Text(
                  "Login",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Widget box(BuildContext context) {
  return Align(
    alignment: Alignment.centerLeft,
    child: ListView(
      shrinkWrap: true,
      children: <Widget>[
        ListTile(
          // leading: Icon(Icons.edit),
          title: Text(
            'Order Status',
            style: Theme.of(context).textTheme.headline3,
          ),
        ),
        ListTile(
          // leading: Icon(Icons.b),
          title: Text(
            'Current Orders',
            style: Theme.of(context).textTheme.headline3,
          ),
        ),
        ListTile(
          // leading: Icon(Icons.report),
          title: Text(
            'Past Orders',
            style: Theme.of(context).textTheme.headline3,
          ),
        ),
        ListTile(
          // leading: Icon(Icons.report),
          title: Text(
            'Reports',
            style: Theme.of(context).textTheme.headline3,
          ),
        ),
      ],
    ),
  );
}

/*
@override
Widget build(BuildContext context) {
return Scaffold(
body: circular
? Center(child: CircularProgressIndicator())
: ListView(
children: <Widget>[
head(),
Divider(
thickness: 0.8,
),
("Name"),
("Address",
("DOB"),
],
),
);
}

Widget head() {
return Padding(
padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
child: Column(
crossAxisAlignment: CrossAxisAlignment.start,
children: <Widget>[
Text(
profileModel.phoneno,
style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
),
SizedBox(
height: 10,
),
],
),
);
}

Widget otherDetails(String label, String value) {
return Padding(
padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
child: Column(
crossAxisAlignment: CrossAxisAlignment.start,
children: <Widget>[
Text(
"",
style: TextStyle(
fontSize: 17,
fontWeight: FontWeight.bold,
),
),
SizedBox(
height: 5,
),
Text(
value,
style: TextStyle(fontSize: 15),
)
],
),
);
}
}*/
