import 'package:flutter/material.dart';

import './adminhome.dart';
import './adminorders.dart';
import './adminproducts.dart';
import './adminprofile.dart';
import './adminbottomnavbar.dart';
import '../splash_screen.dart';

class AdminStarter extends StatefulWidget {
  final String adminLocation;
  final String adminLocationId;
  AdminStarter({this.adminLocation, this.adminLocationId});
  @override
  _AdminStarterState createState() => _AdminStarterState();
}

class _AdminStarterState extends State<AdminStarter> {
  PageController _pageController = PageController();
  int _currentIndex = 0;
  void _onPageChanged(int index) {
    print(index);
    setState(() {
      _currentIndex = index;
    });
  }

  void _onItemTapped(int selectedIndex) {
    _pageController.jumpToPage(selectedIndex);
  }

  void initState() {
    super.initState();
    admin = true;
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> _screens = [
      AdminHome(
        location: widget.adminLocation,
        locationId: widget.adminLocationId,
      ),
      AdminProducts(locationId: widget.adminLocationId,),
      AdminOrders(),
      AdminProfile(),
      // LandingPage(
      //   location: _location,
      //   locationId: _locationId,
      //   userId: widget.userId,
      //   onButtonTapped: onButtonTapped,
      // ),
      // Products(
      //   key: _productKey,
      //   index: _index,
      //   locationId: _locationId,
      //   userId: widget.userId,
      //   tabController: _tabController,
      // ),
      // Wishlist(
      //   pathUrl: "http://10.0.3.2:8080/api/wishlistproducts",
      //   userId: widget.userId,
      //   onButtonTapped: onButtonTapped2,
      // ),
      // Profile(),
    ];
    return Scaffold(
        body: PageView(
          controller: _pageController,
          children: _screens,
          onPageChanged: _onPageChanged,
          physics: NeverScrollableScrollPhysics(),
        ),
        // body: Navigator(
        //   onGenerateRoute: (screen) {
        //     Widget page = LandingPage(title: _title, locationId: _locationId);
        //     if (screen.name == 'products')
        //       page = Products(index: _index, locationId: _locationId);
        //     return MaterialPageRoute(builder: (_) => page);
        //   },
        // ),
        bottomNavigationBar: AdminBottomNavigationBar(
          currentIndex: _currentIndex,
          onItemTapped: _onItemTapped,
        ));
  }
}
