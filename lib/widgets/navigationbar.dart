import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:rht/utils/size_config.dart';

typedef TapCallback = void Function(int selectedIndex);

class MyBottomNavigationBar extends StatefulWidget {
  final int currentIndex;
  final TapCallback onItemTapped;
  const MyBottomNavigationBar({Key key, this.currentIndex, this.onItemTapped})
      : super(key: key);
  @override
  _MyBottomNavigationBarState createState() => _MyBottomNavigationBarState();
}

class _MyBottomNavigationBarState extends State<MyBottomNavigationBar> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return BottomNavigationBar(
      currentIndex: widget.currentIndex,
      onTap: widget.onItemTapped,
      type: BottomNavigationBarType.fixed,
      selectedItemColor: Theme.of(context).accentColor,
      selectedFontSize: SizeConfig.defaultSize * 1.2,
      showSelectedLabels: true,
      showUnselectedLabels: false,
      items: [
        BottomNavigationBarItem(
            icon: Icon(
              Icons.home_filled,
              // size: SizeConfig.defaultSize,
              color: Colors.black87,
            ),
            label: 'Home',
            backgroundColor: Colors.white),
        BottomNavigationBarItem(
            label: 'Products',
            icon: Icon(
              Icons.apps,
              // size: SizeConfig.defaultSize,
              color: Colors.black87,
            ),
            backgroundColor: Colors.white),
        BottomNavigationBarItem(
            label: 'Wishlist',
            icon: Icon(
              MdiIcons.heart,
              // size: SizeConfig.defaultSize,
              color: Colors.black87,
            ),
            backgroundColor: Colors.white),
        BottomNavigationBarItem(
            label: 'Profile',
            icon: Icon(
              MdiIcons.face,
              // size: SizeConfig.defaultSize,
              color: Colors.black87,
            ),
            backgroundColor: Colors.white)
      ],
    );
  }
}
