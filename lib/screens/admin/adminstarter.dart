import 'package:flutter/material.dart';

import './adminhome.dart';
import './adminorders.dart';
import './adminproducts.dart';
import '../../widgets/admin/adminbottomnavbar.dart';
import '../splash_screen.dart';

class AdminStarter extends StatefulWidget {
  static GlobalKey<_AdminStarterState> starterKey = GlobalKey();
  final String adminLocation;
  final String adminLocationId;
  AdminStarter({this.adminLocation, this.adminLocationId})
      : super(key: starterKey);
  @override
  _AdminStarterState createState() => _AdminStarterState();
}

class _AdminStarterState extends State<AdminStarter> {
  PageController _pageController = PageController();
  int _currentIndex = 0;
  // ignore: unused_field
  String _location;
  // ignore: unused_field
  String _locationId;
  int _index = 0;
  void _onPageChanged(int index) {
    // print(index);
    setState(() {
      _currentIndex = index;
    });
  }

  void _onItemTapped(int selectedIndex) {
    _pageController.jumpToPage(selectedIndex);
  }

  void onButtonTapped(int pageindex, int index, String locationId) {
    print("here456");
    setState(() { 
      _locationId = locationId;
    });
    print("re" + _index.toString());
    Navigator.pop(context);
    print(pageindex);
    _pageController.jumpToPage(pageindex);
    // _productKey.currentState.tabController.animateTo(_index);
  }

  void initState() {
    super.initState();
    admin = true;
  }

  Future<bool> _onWillPop() async {
    return (await showDialog(
          context: context,
          builder: (context) => new AlertDialog(
            // title: new Text('Are you sure?'),
            content: new Text(
              'Do you want to exit Admin side?',
              style: Theme.of(context)
                  .textTheme
                  .bodyText1
                  .copyWith(color: Colors.black87),
            ),
            actions: <Widget>[
              // ignore: deprecated_member_use
              new FlatButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: new Text('No'),
              ),
              // ignore: deprecated_member_use
              new FlatButton(
                onPressed: () {
                  setState(() {
                    admin = false;                  
                  });
                  
                  Navigator.of(context).pop(true);
                  
                },
                child: new Text('Yes'),
              ),
            ],
          ),
        )) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> _screens = [
      AdminHome(
        location: widget.adminLocation,
        locationId: widget.adminLocationId,
        onButtonTapped: onButtonTapped,
      ),
      AdminProducts(
        locationId: widget.adminLocationId,
        index: _index,
        onButtonTapped: onButtonTapped,
      ),
      AdminOrders(),
      // AdminProfile(),
    ];
    // return WillPopScope(
    //   onWillPop: _onWillPop,
      // child: 
      return Scaffold(
          body: PageView(
            controller: _pageController,
            children: _screens,
            onPageChanged: _onPageChanged,
            physics: NeverScrollableScrollPhysics(),
          ),
          bottomNavigationBar: AdminBottomNavigationBar(
            currentIndex: _currentIndex,
            onItemTapped: _onItemTapped,
          ));
  }
}
