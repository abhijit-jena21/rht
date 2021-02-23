import 'package:flutter/material.dart';

import '../widgets/navigationbar.dart';
import '../screens/departments.dart';
import './landingpage/landingpage.dart';
import '../screens/wishlist.dart';
import '../screens/profile.dart';

class Starter extends StatefulWidget {
  @override
  _StarterState createState() => _StarterState();
}

class _StarterState extends State<Starter> {
  PageController _pageController = PageController();
  int _currentIndex = 0;
  final List<Widget> _screens = [
    LandingPage(),
    Departments(),
    Wishlist(),
    Profile(),
  ];
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
    return Scaffold(
        body: PageView(
          controller: _pageController,
          children: _screens,
          onPageChanged: _onPageChanged,
          physics: NeverScrollableScrollPhysics(),
        ),
        bottomNavigationBar:
            MyBottomNavigationBar(currentIndex: _currentIndex, onItemTapped: _onItemTapped,));
  }
}
