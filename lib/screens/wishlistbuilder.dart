import 'package:flutter/material.dart';
import '../models/product.dart';
import '../screens/wishlistedproductcard.dart';


class WishlistBuilder extends StatefulWidget {
  final List<Product> snapshot;
  WishlistBuilder(this.snapshot);
  @override
  _WishlistBuilderState createState() => _WishlistBuilderState();
}

class _WishlistBuilderState extends State<WishlistBuilder> {
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10.0,
          mainAxisSpacing: 5.0,
          childAspectRatio: 1.1,
        ),
        padding: EdgeInsets.all(2.0),
        itemCount: widget.snapshot.length,
        itemBuilder: (BuildContext context, int index) {
          return WishlistedProductCard(
            widget.snapshot[index].name,
            widget.snapshot[index].img,
            widget.snapshot[index].details, 
            widget.snapshot[index].price,
            widget.snapshot[index].rent,
            widget.snapshot[index].duration,
            widget.snapshot[index].itemsid,
            );
        },
        
      );
  }
}