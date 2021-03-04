import 'package:flutter/material.dart';
import 'package:rht/models/product.dart';
import 'package:rht/widgets/productcard.dart';

class ProductList extends StatelessWidget {
  final List<Product> snapshot;
  final String userId;
  ProductList(this.snapshot, this.userId);
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
        return ProductCard(
          userId,
          snapshot[index].sId,
          snapshot[index].name,
          snapshot[index].img,
          snapshot[index].details,
          snapshot[index].price,
          snapshot[index].rent,
          snapshot[index].duration,
          snapshot[index].itemsid,
        );
      },
    );
  }
}
