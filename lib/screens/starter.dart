import 'package:flutter/material.dart';

import '../widgets/navigationbar.dart';
// import '../screens/departments.dart';
import '../screens/products/products.dart';
import './landingpage/landingpage.dart';
import '../screens/wishlist.dart';
import '../screens/profile.dart';

class Starter extends StatefulWidget {
  final String location;
  final String locationId;
  final String userId;
  final int index;
  Starter({this.location, this.locationId, this.index, this.userId});
  @override
  _StarterState createState() => _StarterState();
}

class _StarterState extends State<Starter> {
  PageController _pageController = PageController();
  int _currentIndex = 0;
  String _location;
  String _locationId;
  int _index;

  void initState() {
    _location = widget.location;
    _locationId = widget.locationId;
    _index = widget.index;
    super.initState();
  }

  void _onPageChanged(int index) {
    print(index);
    setState(() {
      _currentIndex = index;
    });
  }

  void _onItemTapped(int selectedIndex) {
    _pageController.jumpToPage(selectedIndex);
  }

  @override
  Widget build(BuildContext context) {
    print("starter"+widget.userId);
    // print();
    final List<Widget> _screens = [
      LandingPage(location: _location, locationId: _locationId, userId: widget.userId,),
      Products(index: _index, locationId: _locationId, userId: widget.userId),
      Wishlist(),
      Profile(),
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
        bottomNavigationBar: MyBottomNavigationBar(
          currentIndex: _currentIndex,
          onItemTapped: _onItemTapped,
        ));
  }
}
