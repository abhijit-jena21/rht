import "package:flutter/material.dart";

// ignore: unused_element
Widget buildCard(String name, int price, String imgPath, List<String> items,
    bool added, bool isFavorite, context) {
  return Padding(
      padding: EdgeInsets.only(top: 5.0, bottom: 5.0, left: 5.0, right: 5.0),
      child: InkWell(
          onTap: () {},
          child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.0),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        spreadRadius: 3.0,
                        blurRadius: 5.0)
                  ],
                  color: Colors.white),
              child: Column(mainAxisSize: MainAxisSize.min, children: [
                SizedBox(
                  height: 110,
                  // width: 110,
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      Hero(
                          tag: imgPath,
                          child: Container(
                              height: 110,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: NetworkImage(imgPath),
                                      fit: BoxFit.contain)))),
                      Positioned(
                        top: 5,
                        right: 10,
                        child: SizedBox(
                          height: 25,
                          width: 25,
                          child: FlatButton(
                            padding: EdgeInsets.zero,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50)),
                            color: Colors.grey[200],
                            onPressed: () {},
                            child: isFavorite
                                ? Icon(
                                    Icons.favorite,
                                    color: Color(0xFFEF7532),
                                    size: 18,
                                  )
                                : Icon(
                                    Icons.favorite_border,
                                    color: Color(0xFFEF7532),
                                    size: 18,
                                  ),
                          ),
                        ),
                      ),
                      if (items.length == 0)
                          Positioned(
                            bottom: 5,
                            // right: 10,
                            child: SizedBox(
                                height: 25,
                                width: 75,
                                child: Container(
                                  alignment: Alignment.center,
                                  color: Colors.redAccent,
                                  child: Text(
                                    "Out of stock",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 10),
                                  ),
                                )),
                          ),
                        
                    ],
                  ),
                ),
                // Padding(
                //     padding: EdgeInsets.all(5.0),
                //     child: Row(
                //         mainAxisAlignment: MainAxisAlignment.end,
                //         children: [
                //           isFavorite
                //               ? Icon(Icons.favorite, color: Color(0xFFEF7532))
                //               : Icon(Icons.favorite_border,
                //                   color: Color(0xFFEF7532))
                //         ])),

                SizedBox(height: 7.0),
                Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.only(left: 10),
                  height: 20,
                  child: Text(name,
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          color: Color(0xFF575E67),
                          // fontFamily: 'Varela',
                          fontSize: 12.0)),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.only(left: 10),
                  height: 20,
                  child: Text("Rs. " + price.toString(),
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          color: Color(0xFFCC8053),
                          // fontFamily: 'Varela',
                          fontSize: 12.0)),
                ),

                // Padding(
                //     padding: EdgeInsets.all(8.0),
                //     child: Container(color: Color(0xFFEBEBEB), height: 1.0)),
              ]))));
}
// SizedBox(
//     width: double.infinity,
//     child: FlatButton(
//         onPressed: () {},
//         child: Padding(
//             padding: EdgeInsets.only(left: 5.0, right: 5.0),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 Icon(Icons.shopping_basket,
//                     color: Color(0xFFD17E50), size: 12.0),
//                 Text('Add to cart',
//                     style: TextStyle(
//                         // fontFamily: 'Varela',
//                         color: Color(0xFFD17E50),
//                         fontWeight: FontWeight.bold,
//                         fontSize: 12.0))
//               ],
//             )))),
