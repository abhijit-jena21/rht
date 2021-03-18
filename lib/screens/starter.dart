import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../screens/splash_screen.dart';
import '../widgets/navigationbar.dart';
// import '../screens/departments.dart';
import '../screens/products/products.dart';
import './landingpage/landingpage.dart';
import '../screens/wishlist.dart';
import 'myprofile/drawer_bloc.dart';
import 'myprofile/drawer_layout.dart';

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
  final GlobalKey<ProductsState> _productKey = GlobalKey();
  PageController _pageController = PageController();
  int _currentIndex = 0;
  String _location;
  String _locationId;
  int _index=0;
  // TabController _tabController;

  void initState() {
    _location = widget.location;
    _locationId = widget.locationId;
    // _index = widget.index;
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

  void onButtonTapped(int pageindex, int index, String locationId) {
    setState(() {
      _index = index;
      _locationId = locationId;
      // _tabController = tabController;
    });
    print("re" + _index.toString());
    _pageController.jumpToPage(pageindex);
    // _productKey.currentState.tabController.animateTo(_index);
  }

  @override
  Widget build(BuildContext context) {
    // print("starter" + widget.userId);
    // print();
    final List<Widget> _screens = [
      LandingPage(
        location: _location,
        locationId: _locationId,
        userId: widget.userId,
        onButtonTapped: onButtonTapped,
      ),
      Products(
        key: _productKey,
        index: _index,
        locationId: _locationId,
        userId: widget.userId,
        // tabController: _tabController,
      ),
      Wishlist(
        pathUrl: "$serverLink/api/wishlistproducts",
        userId: widget.userId,
        // onButtonTapped: onButtonTapped2,
      ),
      BlocProvider<DrawerBloc>(
        create: (context) => DrawerBloc(),
        child: DrawerLayout(),
      ),
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
