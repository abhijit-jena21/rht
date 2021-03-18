import 'package:flutter/material.dart';
import '../screens/cart.dart';
import '../screens/splash_screen.dart';
import '../screens/search.dart';

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
      automaticallyImplyLeading: false,
      backgroundColor: Color(0xFF2873f0),
      elevation: 0,
      title: Text(
        'RHT',
        style: Theme.of(context)
            .textTheme
            .headline5
            .copyWith(color: Color(0xFFFFFFFF), fontWeight: FontWeight.bold),
      ),
      actions: [
        new IconButton(
            icon: Icon(Icons.search),
            color: Color(0xffFFFFFF),
            onPressed: () {
              showSearch(context: context, delegate: Search());
            }),
        new IconButton(
          icon: Icon(Icons.shopping_cart),
          color: Color(0xffFFFFFF),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => Cart(
                          userId: finalId,
                        )));
          },
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
//       style: Theme.of(context).textTheme.headline6,
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
