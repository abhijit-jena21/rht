import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'drawer_bloc.dart';
import 'notification.dart';
import 'userprofile.dart';
import 'appbarcustom.dart';
import 'bottomshape.dart';
import 'drawer_item.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'useredit.dart';
import '../../my_navigator.dart';


class DrawerLayout extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
      builder: (context, orientation) {
        return Scaffold(
          key: _scaffoldKey,
          body: Column(
            children: <Widget>[
              BlocBuilder<DrawerBloc, DrawerStates>(
                builder: (context, DrawerStates state) {
                  return CustomAppBar( 
                    isBig: (state is UserProfileScreen),
                    height: (state is UserProfileScreen) ? 250 : 150,
                    
                    title: 
                    findSelectedTitle(state),
                    trailing: IconButton(
                      onPressed: () {
                        _scaffoldKey.currentState.openEndDrawer();
                      },
                      icon: Container(
                        child: Center(child: Icon(Icons.settings)),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(
                            color: Theme.of(context).scaffoldBackgroundColor,
                          ),
                        ),
                      ),
                    ),
                    childHeight: 100,
                    child: (state is UserProfileScreen)
                        ? ClipOval(
                            child: Container(
                              color: Theme.of(context).scaffoldBackgroundColor,
                              height: 100,
                              width: 100,
                              child: Container(
                                margin: const EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(color: Theme.of(context).primaryColor, width: 2),
                                ),
                                child:Center(
            child: Stack(children: <Widget>[
              CircleAvatar(
              radius: 60,
             // backgroundImage: dio().getImage(userID.phoneno),
              ),
             Positioned(
               bottom: 0.0,
               right: 1.0,
          child: InkWell(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => CreatProfile())
              );
            },
             
            child: Container(
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.grey.shade200,
                          
                          // borderRadius: BorderRadius.circular(4),
                          // border: Border.all(
                          //   color: Theme.of(context).scaffoldBackgroundColor,
                          
                        ),
              child: Icon(
                Icons.edit,
                color: Colors.black,
                size: 20.0,
              ),
            ),
          ),
             ),
            ]),
            ),
                              ),
                            ),
                          )
                        : null,
                  );
                },
              ),
              Expanded(
                child: BlocBuilder<DrawerBloc, DrawerStates>(
                  builder: (context, DrawerStates state) {
                    return state as Widget;
                  },
                ),
              ),
            ],
          ),
          endDrawer: ClipPath(
            clipper: _DrawerClipper(),
            child: Drawer(
              child: SingleChildScrollView(
                child: Container(
                  padding: const EdgeInsets.only(top: 48, bottom: 32),
                  height: (orientation == Orientation.portrait) ? MediaQuery.of(context).size.height : MediaQuery.of(context).size.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: Container(
                          height: 40,
                          width: 40,
                          margin: const EdgeInsets.only(right: 20, bottom: 20),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Theme.of(context).primaryColor,
                          ),
                          child: Icon(Icons.close),
                        ),
                      ),
                      DrawerItem(
                        text: "My Profile",
                        onPressed: () {
                          Navigator.of(context).pop();
                          BlocProvider.of<DrawerBloc>(context).add(DrawerEvents.ProfileEvent);
                        },
                      ),
                      DrawerItem(
                        text: "Language",
                        onPressed: () {},
                      ),
                      DrawerItem(
                        text: "Privacy",
                        onPressed: () {},
                      ),
                      DrawerItem(
                        text: "Notifications",
                        onPressed: () {
                          Navigator.of(context).pop();
                          BlocProvider.of<DrawerBloc>(context).add(DrawerEvents.NotificationEvent);
                        },
                      ),
                      SizedBox(height:20),
                      FlatButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                          _openSignOutDrawer(context);
                        },
                        child: RichText(
                          text:TextSpan(children: [
                            TextSpan(
                              text: "Sign out",
                              style: TextStyle(
                                fontSize: 18,
                                color: Theme.of(context).primaryColor,
                                decoration: TextDecoration.underline,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ]),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  String findSelectedTitle(DrawerStates state) {
    if (state is UserProfileScreen) {
      return " My Profile";
    } else {
      assert(state is NotificationScreen);
      return " Notification Settings";
    }
  }

  void _openSignOutDrawer(BuildContext context) {
    showModalBottomSheet(
        shape: BottomSheetShape(),
        backgroundColor: Theme.of(context).primaryColor,
        context: context,
        builder: (context) {
          return Container(
            padding: const EdgeInsets.only(
              top: 24,
              bottom: 16,
              left: 48,
              right: 48,
            ),
            height: 180,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Text(
                  "Are you sure you want to sign out from RHT?",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Expanded(
                      child: MaterialButton(
                        onPressed: () async {
                          final SharedPreferences sharedPreferences =
                                await SharedPreferences.getInstance();
                                 sharedPreferences.remove('phone');
                                      MyNavigator.goToLogin(context);},
                        color: Theme.of(context).scaffoldBackgroundColor,
                        child: Text(
                          "Log out",
                          style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: OutlineButton(
                        onPressed: () {},
                        borderSide: BorderSide(
                          color: Theme.of(context).scaffoldBackgroundColor,
                        ),
                        color: Theme.of(context).primaryColor,
                        child: Text(
                          "Stay logged in",
                          style: TextStyle(
                            color: Theme.of(context).scaffoldBackgroundColor,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        });
  }
}

class _DrawerClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();

    path.moveTo(50, 0);
    path.quadraticBezierTo(0, size.height / 2, 50, size.height);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}