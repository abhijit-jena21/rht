import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import '../../utils/size_config.dart';

typedef TapCallback = void Function(int selectedIndex);

class AdminBottomNavigationBar extends StatefulWidget {
  final int currentIndex;
  final TapCallback onItemTapped;
  const AdminBottomNavigationBar({Key key, this.currentIndex, this.onItemTapped})
      : super(key: key);
  @override
  _AdminBottomNavigationBarState createState() => _AdminBottomNavigationBarState();
}

class _AdminBottomNavigationBarState extends State<AdminBottomNavigationBar> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return BottomNavigationBar(
      currentIndex: widget.currentIndex,
      onTap: widget.onItemTapped,
      type: BottomNavigationBarType.fixed,
      selectedItemColor: Theme.of(context).accentColor,
      selectedIconTheme: IconThemeData(color: Theme.of(context).primaryColor),
      unselectedIconTheme: IconThemeData(color: Colors.black87.withOpacity(0.7)),
      unselectedItemColor: Colors.black87.withOpacity(0.7),
      selectedFontSize: 12,
      showSelectedLabels: true,
      showUnselectedLabels: true,
      items: [
        BottomNavigationBarItem(
            icon: Icon(
              Icons.home_filled,
            ),
            label: 'Home',
            backgroundColor: Colors.white),
        BottomNavigationBarItem(
            label: 'Products',
            icon: Icon(
              Icons.apps,
            ),
            backgroundColor: Colors.white),
        BottomNavigationBarItem(
            label: 'Orders',
            icon: Icon(
              Icons.list_alt,
            ),
            backgroundColor: Colors.white),
        // BottomNavigationBarItem(
        //     label: 'Profile',
        //     icon: Icon(
        //       MdiIcons.face,
        //     ),
        //     backgroundColor: Colors.white)
      ],
    );
  }
}
