import 'package:flutter/material.dart';
import 'package:rht/screens/myprofile/profilenew.dart';
import '../screens/splash_screen.dart';
import '../widgets/navigationbar.dart';
import '../screens/products/products.dart';
import './landingpage/landingpage.dart';
import '../screens/wishlist.dart';

class Starter extends StatefulWidget {
  static final GlobalKey<StarterState> starterKey = GlobalKey();
  final String location;
  final String locationId;
  final String userId;
  final int index;
  Starter({this.location, this.locationId, this.index, this.userId})
      : super(key: starterKey);
  @override
  StarterState createState() => StarterState();
}

class StarterState extends State<Starter> {
  final GlobalKey<ProductsState> _productKey = GlobalKey();
  // ignore: unused_field
  final GlobalKey<StarterState> _myKey = GlobalKey();
  PageController _pageController = PageController();
  int _currentIndex = 0;
  String _location;
  String _locationId;
  int _index = 0;

  void initState() {
    super.initState();
    setState(() {
      _location = widget.location;
    _locationId = widget.locationId;
    });
    
    print("_location" + _location);
    print("starter:" + widget.location);
    print("starter:" + finalLocation);
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

  void onButtonTapped(int pageindex, int index, String locationId) {
    setState(() {
      _index = index;
      _locationId = locationId;
    });
    print("re" + _index.toString());
    _pageController.jumpToPage(pageindex);
  }

  void onButtonTapped2(int pageindex) {
    Navigator.pop(context);
    print(pageindex);
    _pageController.jumpToPage(pageindex);
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> _screens = [
      LandingPage(
        location: finalLocation,
        locationId: finalLocationId,
        userId: widget.userId,
        onButtonTapped: onButtonTapped,
      ),
      Products(
        key: _productKey,
        index: _index,
        locationId: finalLocationId,
        userId: widget.userId,
      ),
      Wishlist(
        pathUrl: "$serverLink/api/wishlistproducts",
        userId: widget.userId,
      ),
      ProfileSecondPage(onButtonTapped: onButtonTapped2)
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
