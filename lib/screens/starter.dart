import 'package:flutter/material.dart';

import '../widgets/navigationbar.dart';
// import '../screens/departments.dart';
import '../screens/products/products.dart';
import './landingpage/landingpage.dart';
import '../screens/wishlist.dart';
import '../screens/profile.dart';

class Starter extends StatefulWidget {
  final String title;
  final String locationId;
  final int index;
  Starter({this.title, this.locationId, this.index});
  @override
  _StarterState createState() => _StarterState();
}

class _StarterState extends State<Starter> {
  PageController _pageController = PageController();
  int _currentIndex = 0;
  String _title;
  String _locationId;
  int _index;

  void initState() {
    _title = widget.title;
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
    final List<Widget> _screens = [
      LandingPage(title: _title, locationId: _locationId),
      Products(index: _index, locationId: _locationId),
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
        bottomNavigationBar: MyBottomNavigationBar(
          currentIndex: _currentIndex,
          onItemTapped: _onItemTapped,
        ));
  }
}
