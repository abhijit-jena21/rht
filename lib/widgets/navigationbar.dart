import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

typedef TapCallback = void Function(int selectedIndex);

class MyBottomNavigationBar extends StatefulWidget {
  final int currentIndex;
  final TapCallback onItemTapped;
  const MyBottomNavigationBar({Key key, this.currentIndex, this.onItemTapped}):super(key: key);
  @override
  _MyBottomNavigationBarState createState() =>
      _MyBottomNavigationBarState();
}

class _MyBottomNavigationBarState extends State<MyBottomNavigationBar> {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: widget.currentIndex,
      onTap: widget.onItemTapped,
      type: BottomNavigationBarType.fixed,
      selectedItemColor: Theme.of(context).accentColor,
      selectedFontSize: 12,
      showSelectedLabels: true,
      showUnselectedLabels: false,
      items: [
        BottomNavigationBarItem(
            icon: Icon(
              Icons.home_filled,
              color: Colors.black87,
            ),
            label: 'Home',
            backgroundColor: Colors.white),
        BottomNavigationBarItem(
            label: 'Departments',
            icon: Icon(
              Icons.apps,
              color: Colors.black87,
            ),
            backgroundColor: Colors.white),
        BottomNavigationBarItem(
            label: 'Wishlist',
            icon: Icon(
              MdiIcons.heart,
              color: Colors.black87,
            ),
            backgroundColor: Colors.white),
        BottomNavigationBarItem(
            label: 'Profile',
            icon: Icon(
              MdiIcons.face,
              color: Colors.black87,
            ),
            backgroundColor: Colors.white)
      ],
    );
  }
}
