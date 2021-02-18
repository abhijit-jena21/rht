import 'package:flutter/material.dart';

class MyAppBar extends StatefulWidget implements PreferredSizeWidget {
  @override
  // TODO: implement preferredSize
    Size get preferredSize => const Size.fromHeight(kToolbarHeight);
  @override
  _MyAppBarState createState() => _MyAppBarState();
}

class _MyAppBarState extends State<MyAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
    elevation: 0,
    title: Text(
      'RHT',
      style: Theme.of(context).textTheme.headline1,
    ),
    actions: [
      new IconButton(
        icon: Icon(Icons.search),
        color: Color(0xff5A5A5A),
        onPressed: null,
      ),
      new IconButton(
        icon: Icon(Icons.shopping_cart),
        color: Color(0xff5A5A5A),
        onPressed: null,
      ),
    ],
    );
  }
}

// AppBar myAppBar(BuildContext context) => AppBar(
//     backgroundColor: Colors.white,
//     elevation: 0,
//     title: Text(
//       'RHT',
//       style: Theme.of(context).textTheme.headline1,
//     ),
//     actions: [
//       new IconButton(
//         icon: Icon(Icons.search),
//         color: Color(0xff5A5A5A),
//         onPressed: null,
//       ),
//       new IconButton(
//         icon: Icon(Icons.shopping_cart),
//         color: Color(0xff5A5A5A),
//         onPressed: null,
//       ),
//     ],
//   );
