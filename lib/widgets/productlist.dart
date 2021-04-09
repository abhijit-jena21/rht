import 'package:flutter/material.dart';
import '../models/product.dart';
import 'admin/adminproductcard.dart';
import '../screens/splash_screen.dart';
import '../widgets/productcard.dart';
import 'package:async/async.dart';

class ProductList extends StatefulWidget {
  final ProductPage snapshot;
  final String userId;
  final Function(String) callBack;
  // final String role;
  ProductList(this.snapshot, this.userId, this.callBack);
  @override
  _ProductListState createState() => _ProductListState();
}

enum ProductLoadMoreStatus { LOADING, STABLE }

class _ProductListState extends State<ProductList> {
  ProductLoadMoreStatus loadMoreStatus = ProductLoadMoreStatus.STABLE;
  final ScrollController scrollController = new ScrollController();
  List<Product> products;
  int currentPageNumber;
  CancelableOperation productOperation;

  bool onNotification(ScrollNotification notification) {
    if (notification is ScrollUpdateNotification) {
      if (scrollController.position.maxScrollExtent > scrollController.offset &&
          scrollController.position.maxScrollExtent - scrollController.offset <=
              50) {
        if (loadMoreStatus != null &&
            loadMoreStatus == ProductLoadMoreStatus.STABLE) {
          loadMoreStatus = ProductLoadMoreStatus.LOADING;
          productOperation = CancelableOperation.fromFuture(widget
              .callBack((currentPageNumber + 1).toString())
              .then((productObject) {
            currentPageNumber = int.parse(productObject.page);
            loadMoreStatus = ProductLoadMoreStatus.STABLE;
            if (productObject.islastpage == "true") loadMoreStatus = null;
            setState(() => products.addAll(productObject.products));
          }));
        }
      }
    }
    return true;
  }

  @override
  void initState() {
    products = widget.snapshot.products;
    currentPageNumber = int.parse(widget.snapshot.page);
    super.initState();
  }

  @override
  void dispose() {
    scrollController.dispose();
    if (productOperation != null) productOperation.cancel();
    super.dispose();
  }

  @override
  // ignore: missing_return
  Widget build(BuildContext context) {
    if (admin == false)
      return NotificationListener(
        onNotification: onNotification,
        child: GridView.builder(
          shrinkWrap: true,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10.0,
            mainAxisSpacing: 5.0,
            childAspectRatio: 1,
          ),
          padding: EdgeInsets.all(5.0),
          controller: scrollController,
          itemCount: widget.snapshot.products.length,
          // ignore: missing_return
          itemBuilder: (BuildContext context, int index) {
            return ProductCard(
                widget.userId,
                widget.snapshot.products[index].sId,
                widget.snapshot.products[index].name,
                widget.snapshot.products[index].img,
                widget.snapshot.products[index].details,
                widget.snapshot.products[index].price,
                widget.snapshot.products[index].rent,
                widget.snapshot.products[index].deposit,
                widget.snapshot.products[index].duration,
                widget.snapshot.products[index].itemsid,
                widget.snapshot.products[index].stock,
                widget.snapshot.products[index].locationid);
          },
        ),
      );
    else if(admin==true){
      void refresh(int index) {
        setState(() {
          widget.snapshot.products.removeAt(index);
        });
      }

      return NotificationListener(
        onNotification: onNotification,
        child: GridView.builder(
          shrinkWrap: true,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 1,
            crossAxisSpacing: 5.0,
            mainAxisSpacing: 5.0,
            childAspectRatio: 2.3,
          ),
          padding: EdgeInsets.all(5.0),
          controller: scrollController,
          itemCount: widget.snapshot.products.length,
          // ignore: missing_return
          itemBuilder: (BuildContext context, int index) {
            return AdminProductCard(
                widget.snapshot.products[index].sId,
                widget.snapshot.products[index].name,
                widget.snapshot.products[index].img,
                widget.snapshot.products[index].details,
                widget.snapshot.products[index].price,
                widget.snapshot.products[index].rent,
                widget.snapshot.products[index].deposit,
                widget.snapshot.products[index].duration,
                widget.snapshot.products[index].itemsid,
                widget.snapshot.products[index].locationid,
                index,
                refresh);
          },
        ),
      );
    }
  }
}
