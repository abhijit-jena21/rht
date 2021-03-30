import 'package:flutter/material.dart';
import '../models/product.dart';
import '../screens/admin/adminproductcard.dart';
import '../screens/splash_screen.dart';
import '../widgets/productcard.dart';

class ProductList extends StatefulWidget {
  final List<Product> snapshot;
  final String userId;
  // final String role;
  ProductList(this.snapshot, this.userId);

  @override
  _ProductListState createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  @override
  Widget build(BuildContext context) {
    // if (snapshot.length == 0) {
    //   return Center(
    //     child: Text("Wow, such empty"),
    //   );
    // } else {
    if (admin == false)
      return GridView.builder(
        shrinkWrap: true,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10.0,
          mainAxisSpacing: 5.0,
          childAspectRatio: 1,
        ),
        padding: EdgeInsets.all(5.0),
        itemCount: widget.snapshot.length,
        // ignore: missing_return
        itemBuilder: (BuildContext context, int index) {
          return ProductCard(
              widget.userId,
              widget.snapshot[index].sId,
              widget.snapshot[index].name,
              widget.snapshot[index].img,
              widget.snapshot[index].details,
              widget.snapshot[index].price,
              widget.snapshot[index].rent,
              widget.snapshot[index].deposit,
              widget.snapshot[index].duration,
              widget.snapshot[index].itemsid,
              widget.snapshot[index].stock,
              widget.snapshot[index].locationid);
        },
      );
    else {
      void refresh(int index) {
            setState(() {
              widget.snapshot.removeAt(index);
            });
          }
      return GridView.builder(
        shrinkWrap: true,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 1,
          crossAxisSpacing: 10.0,
          mainAxisSpacing: 5.0,
          childAspectRatio: 2.3,
        ),
        padding: EdgeInsets.all(5.0),
        itemCount: widget.snapshot.length,
        // ignore: missing_return
        itemBuilder: (BuildContext context, int index) {
          return AdminProductCard(
              widget.snapshot[index].sId,
              widget.snapshot[index].name,
              widget.snapshot[index].img,
              widget.snapshot[index].details,
              widget.snapshot[index].price,
              widget.snapshot[index].rent,
              widget.snapshot[index].deposit,
              widget.snapshot[index].duration,
              widget.snapshot[index].itemsid,
              widget.snapshot[index].locationid,
              index,
              refresh);
        },
      );
    }
  }
}
