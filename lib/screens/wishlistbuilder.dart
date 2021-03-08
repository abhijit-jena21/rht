import 'package:flutter/material.dart';
import '../models/product.dart';
import '../screens/wishlistedproductcard.dart';

class WishlistBuilder extends StatefulWidget {
  final List<Product> snapshot;
  final String userId;
  void Function(int) onButtonTapped;
  // final Function refresh;
  WishlistBuilder(
      this.snapshot, this.userId, this.onButtonTapped);
  @override
  _WishlistBuilderState createState() => _WishlistBuilderState();
}

class _WishlistBuilderState extends State<WishlistBuilder> {
  

  @override
  Widget build(BuildContext context) {
    if(widget.snapshot.length>0)
    return GridView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      physics: ScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10.0,
        mainAxisSpacing: 5.0,
        childAspectRatio: 1.1,
      ),
      padding: EdgeInsets.all(2.0),
      itemCount: widget.snapshot.length,
      itemBuilder: (BuildContext context, int index) {
        void refresh(int index) {
    setState(() {
      widget.snapshot.removeAt(index);
    });
  }
        return WishlistedProductCard(
          widget.userId,
          widget.onButtonTapped,
          index,
          refresh,
          widget.snapshot[index].sId,
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
    else if(widget.snapshot.length==0)
    return Container(
                        child: Center(
                            child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              "././assets/images/stock.png",
                              height: 200,
                              // scale: 0.5,
                            ),
                            Text(
                              "Your wishlist is empty",
                              style: Theme.of(context).textTheme.headline3,
                            ),
                          ],
                        )),
                      );
  }
  
}
