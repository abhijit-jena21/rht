import 'package:flutter/material.dart';
import '../models/product.dart';
import '../screens/admin/adminproductcard.dart';
import '../screens/splash_screen.dart';
import '../widgets/productcard.dart';

class ProductList extends StatelessWidget {
  final List<Product> snapshot;
  final String userId;
  // final String role;
  ProductList(this.snapshot, this.userId);

  @override
  Widget build(BuildContext context) {
    // if (snapshot.length == 0) {
    //   return Center(
    //     child: Text("Wow, such empty"),
    //   );
    // } else {
    return GridView.builder(
      shrinkWrap: true,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 5.0,
        mainAxisSpacing: 5.0,
        childAspectRatio: 1,
      ),
      padding: EdgeInsets.all(5.0),
      itemCount: snapshot.length,
      // ignore: missing_return
      itemBuilder: (BuildContext context, int index) {
        if (admin==false)
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
              snapshot[index].locationid);
        else
          return AdminProductCard(
            snapshot[index].sId,
              snapshot[index].name,
              snapshot[index].img,
              snapshot[index].details,
              snapshot[index].price,
              snapshot[index].rent,
              snapshot[index].duration,
              snapshot[index].itemsid,
              snapshot[index].locationid
          );
      },
    );
  }
}
