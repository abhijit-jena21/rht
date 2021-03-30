import 'package:flutter/material.dart';
import 'package:rht/screens/admin/adminstarter.dart';
import 'package:rht/screens/myprofile/currentorders.dart';
import 'package:rht/screens/myprofile/orderstatus.dart';
import 'package:rht/screens/myprofile/pastorders.dart';
import 'package:rht/screens/myprofile/useredit.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../my_navigator.dart';
import '../../services/usercheckservice.dart';
import 'package:rht/screens/login.dart';
import '../../screens/splash_screen.dart';
import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rht/screens/myprofile/piechart.dart';

class Res {
  String error;
  String result;

  Res({this.error, this.result});

  factory Res.fromJson(Map<String, dynamic> json) {
    return Res(error: json['error'], result: json['result']);
  }
}

class ProfileSecondPage extends StatefulWidget {
  void Function(int) onButtonTapped;
  ProfileSecondPage({this.onButtonTapped});
  @override
  _ProfileSecondPageState createState() => _ProfileSecondPageState();
}

class _ProfileSecondPageState extends State<ProfileSecondPage> {
  Dio dio = new Dio();
  bool exist;
  var res;
  MyNavigator myNavigator;
  String response;
  Usercheck usercheck = Usercheck();

  void initState() {
    super.initState();
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
    // usercheck.account(finalId, exist).then((result) {
    //   print(result);
    //   final Map parsed = json.decode(result.toString());
    //   res = Res.fromJson(parsed);
    //   print(res.result);
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[200],
        extendBodyBehindAppBar: true,
        extendBody: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              ProfileHeader(
                title: finalPhone == null ? "Hello Guest" : "Hello $finalName",
                //subtitle: "",
                /* actions: <Widget>[
                  MaterialButton(
                    color: Colors.white,
                    shape: CircleBorder(),
                    elevation: 0,
                    child: Icon(Icons.edit),
                    onPressed: () {Navigator.push(context,
                  MaterialPageRoute(builder: (context) => CreatProfile())
              );},
                  )
                ],*/
              ),
              if (finalPhone==null) guest(context),
              // SizedBox(height: 25.0),
              if (finalPhone!=null) user(context),
            ],
          ),
        ));
  }
}

var res;
Widget guest(BuildContext context) {
  return Container(
    padding: EdgeInsets.only(left: 20, right: 20, top: 5, bottom: 5),
    child: Column(
      children: <Widget>[
        Container(
          width: 700,
          height: 65,
          child: FlatButton(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Icon(Icons.login_rounded, color: Theme.of(context).accentColor),
                Text(
                  "Login",
                  style: TextStyle(fontSize: 16, color: Colors.black54),
                ),
                Icon(Icons.arrow_forward_ios_rounded, color: Colors.black38),
              ],
            ),
            color: Colors.white,
            onPressed: () {
              // print("here" + res.result);
              // if (res.result == "Not registered")
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => LoginScreen("/profile")));
            },
          ),
        ),
      ],
    ),
  );
}

enum ButtonAction {
  cancel,
  Logout,
}

void showMaterialDialog<T>({BuildContext context, Widget child}) {
  showDialog<T>(
    context: context,
    builder: (BuildContext context) => child,
  );
}

Widget user(BuildContext context) {
  return Container(
    padding: EdgeInsets.only(left: 20, right: 20, top: 5, bottom: 5),
    child: Column(
      children: <Widget>[
        SizedBox(height: 10),
        Container(
          width: 700,
          height: 65,
          child: FlatButton(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Icon(Icons.notifications, color: Theme.of(context).accentColor),
                Text(
                  "Edit Profile",
                  style: TextStyle(fontSize: 16, color: Colors.black54),
                ),
                Icon(Icons.arrow_forward_ios_rounded, color: Colors.black38),
              ],
            ),
            color: Colors.white,
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => CreatProfile()));
            },
          ),
        ),
        SizedBox(height: 10),
        Container(
          width: 700,
          height: 65,
          child: FlatButton(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Icon(Icons.list,
                    color: Theme.of(context).accentColor),
                Text(
                  "Current Orders",
                  style: TextStyle(fontSize: 16, color: Colors.black54),
                ),
                Icon(Icons.arrow_forward_ios_rounded, color: Colors.black38),
              ],
            ),
            color: Colors.white,
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => CurrentOrders()));
            },
          ),
        ),
        SizedBox(height: 10),
        Container(
          width: 700,
          height: 65,
          child: FlatButton(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Icon(Icons.replay_circle_filled, color: Theme.of(context).accentColor),
                Text(
                  "Past Orders",
                  style: TextStyle(fontSize: 16, color: Colors.black54),
                ),
                Icon(Icons.arrow_forward_ios_rounded, color: Colors.black38),
              ],
            ),
            color: Colors.white,
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => PastOrders()));
            },
          ),
        ),
        SizedBox(height: 10),
        Container(
          width: 700,
          height: 65,
          child: FlatButton(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Icon(Icons.local_shipping_rounded,
                    color: Theme.of(context).accentColor),
                Text(
                  "Order Status",
                  style: TextStyle(fontSize: 16, color: Colors.black54),
                ),
                Icon(Icons.arrow_forward_ios_rounded, color: Colors.black38),
              ],
            ),
            color: Colors.white,
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => OrderStatus(from:"profile")));
            },
          ),
        ),
        SizedBox(height: 10),
        Container(
          width: 700,
          height: 65,
          child: FlatButton(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Icon(Icons.stacked_bar_chart,
                    color: Theme.of(context).accentColor),
                Text(
                  "Admin",
                  style: TextStyle(fontSize: 16, color: Colors.black54),
                ),
                Icon(Icons.arrow_forward_ios_rounded, color: Colors.black38),
              ],
            ),
            color: Colors.white,
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => AdminStarter(
                            adminLocation: finalAdminLocation,
                            adminLocationId: finalAdminLocationId,
                          )));
            },
          ),
        ),
        SizedBox(height: 10),
        Container(
          width: 700,
          height: 65,
          child: FlatButton(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Icon(Icons.logout, color: Theme.of(context).accentColor),
                Text(
                  "Log out",
                  style: TextStyle(fontSize: 16, color: Colors.black54),
                ),
                Icon(Icons.arrow_forward_ios_rounded, color: Colors.black38),
              ],
            ),
            color: Colors.white,
            onPressed: () {
              showMaterialDialog<ButtonAction>(
                context: context,
                child: AlertDialog(
                  title: const Text(
                    'Are you sure you want to log out of RHT?',
                    style: TextStyle(color: Colors.black45, fontSize: 16),
                  ),
                  actions: <Widget>[
                    FlatButton(
                      child: const Text(
                        'Cancel',
                        style: TextStyle(color: Color(0xFF2873f0)),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    FlatButton(
                      child: const Text(
                        'Logout',
                        style: TextStyle(color: Color(0xFF2873f0)),
                      ),
                      onPressed: () async {
                        final SharedPreferences sharedPreferences =
                            await SharedPreferences.getInstance();
                        sharedPreferences.remove('phone');
                        sharedPreferences.remove('name');
                        sharedPreferences.remove('userId');
                        sharedPreferences.remove('location');
                        sharedPreferences.remove('locationId');
                        finalId = null;
                        finalName = "Guest";
                        finalPhone = null;
                        finalLocation = null;
                        finalLocationId = null;
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SplashScreen()),
                            (_) => false);
                      },
                    ),
                  ],
                ),
              );
            },
          ),
        ),
        SizedBox(height: 10),
      ],
    ),
  );
}

class ProfileHeader extends StatelessWidget {
  final String title;
  final String subtitle;
  final List<Widget> actions;

  const ProfileHeader(
      {Key key, @required this.title, this.subtitle, this.actions})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Ink(
          height: 290,
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
          ),
        ),
        if (actions != null)
          Container(
            width: double.infinity,
            height: 180,
            padding: const EdgeInsets.only(bottom: 0.0, right: 0.0),
            alignment: Alignment.bottomRight,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: actions,
            ),
          ),
        Container(
          width: double.infinity,
          margin: const EdgeInsets.only(top: 60),
          child: Column(
            children: <Widget>[
              Avatar(
                //image: avatar,
                radius: 50,
                backgroundColor: Colors.white,
                // borderColor: Colors.white12,
                // borderWidth: 4.0,
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                title,
                style: TextStyle(
                  fontSize: 29,
                  color: Colors.white,
                ),
              ),
              if (subtitle != null) ...[
                const SizedBox(height: 5.0),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 19,
                    color: Colors.white,
                  ),
                ),
              ]
            ],
          ),
        )
      ],
    );
  }
}

class Avatar extends StatelessWidget {
  final Color borderColor;
  final Color backgroundColor;
  final double radius;
  final double borderWidth;

  const Avatar(
      {Key key,
      this.borderColor = Colors.grey,
      this.backgroundColor,
      this.radius = 70,
      this.borderWidth = 5})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius + borderWidth,
      // backgroundColor: borderColor,
      child: CircleAvatar(
        radius: radius,
        backgroundColor: backgroundColor != null
            ? backgroundColor
            : Theme.of(context).primaryColor,
        child: Icon(
          Icons.person,
          color: Theme.of(context).accentColor,
          size: 78,
        ),
      ),
    );
  }
}
