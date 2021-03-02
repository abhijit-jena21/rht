import 'package:flutter/material.dart';
import 'package:rht/models/product.dart';
import 'package:rht/widgets/productcard.dart';

class ProductList extends StatelessWidget {
  final List<Product> snapshot;
  ProductList(this.snapshot);
  @override
  Widget build(BuildContext context) {
    // if (snapshot.length == 0) {
    //   return Center(
    //     child: Text("Wow, such empty"),
    //   );
    // } else {
      return GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10.0,
          mainAxisSpacing: 5.0,
          childAspectRatio: 1.1,
        ),
        padding: EdgeInsets.all(2.0),
        itemCount: snapshot.length,
        itemBuilder: (BuildContext context, int index) {
          return buildCard(snapshot[index].name, snapshot[index].rent,
              snapshot[index].img[0], snapshot[index].itemsid, false, false, context);
        },
        // children: <Widget>[
        //   SizedBox(height: 15.0),
        //   Container(
        //       padding: EdgeInsets.only(right: 15.0),
        //       width: MediaQuery.of(context).size.width - 30.0,
        //       height: MediaQuery.of(context).size.height - 50.0,
        //       child: GridView.count(
        //         crossAxisCount: 2,
        //         primary: false,
        //         crossAxisSpacing: 10.0,
        //         mainAxisSpacing: 15.0,
        //         childAspectRatio: 0.8,
        //         children: <Widget>[
        //           buildCard('Refrigerator', '\Rs.209.99', 'fridge.jpg', false,
        //               false, context),
        //           // buildCard('Chimney', 'Rs.\500.99', 'chimney.jpg', true, false,
        //           //     context),
        //           // buildCard('Water Purifier', 'rs.\150.99', 'filter.jpg', false,
        //           //     true, context),
        //           // buildCard('Microwave', '\Rs.298.99', 'oven.jpg', false, false,
        //           //     context)
        //         ],
        //       )),
        //   SizedBox(height: 15.0)
        // ],
      );
    }
  }
