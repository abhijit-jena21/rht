import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import '../models/cartproduct.dart';
import '../screens/cartproductcard.dart';
import '../screens/splash_screen.dart';

typedef void IntCallback(int cartsum);

class CartBuilder extends StatefulWidget {
  final List<CartProduct> snapshot;
  final String userId;
  // final IntCallback notifyParent;
  final StreamController streamController;
  // final Function refresh;
  CartBuilder(this.snapshot, this.userId, this.streamController);
  @override
  CartBuilderState createState() => CartBuilderState();
}

class CartBuilderState extends State<CartBuilder> {
  var cartsum = 0;
  // final StreamController streamController = StreamController();

  cartSum({int index}) {
    for (var i = 0; i < widget.snapshot.length; i++) {
      if (finalLocationId == widget.snapshot[i].locationid) {
        cartsum += widget.snapshot[i].iRent * widget.snapshot[i].count;
      }
    }
    if (index != null)
      cartsum -= widget.snapshot[index].iRent * widget.snapshot[index].count;
    print(cartsum);
    widget.streamController.sink.add(cartsum);
  }

  cartMinus({int index}) {
    if (index != null)
      cartsum -= widget.snapshot[index].iRent * widget.snapshot[index].count;
    print(cartsum);
    widget.streamController.sink.add(cartsum);
  }

  cartUpdateAdd({int index, int count}) {
    if (index != null) cartsum += widget.snapshot[index].iRent * count;
    print(cartsum);
    widget.streamController.sink.add(cartsum);
  }

  cartUpdateMinus({int index, int count}) {
    if (index != null) cartsum -= widget.snapshot[index].iRent * count;
    print(cartsum);
    widget.streamController.sink.add(cartsum);
  }

  void initState() {
    super.initState();
    cartSum();
    // SchedulerBinding.instance.addPostFrameCallback((_) {
    //   setState(() {
    //     // widget.notifyParent(cartsum);
    //   });
    // });
  }

  @override
  // ignore: missing_return
  Widget build(BuildContext context) {
    print(widget.snapshot);

    if (widget.snapshot.length > 0)
      return GridView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        physics: ScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 1,
          crossAxisSpacing: 10.0,
          mainAxisSpacing: 5.0,
          childAspectRatio: 1.9,
        ),
        padding: EdgeInsets.all(2.0),
        itemCount: widget.snapshot.length,
        // ignore: missing_return
        itemBuilder: (BuildContext context, int index) {
          void refresh(int index) {
            setState(() {
              cartMinus(index: index);
              widget.snapshot.removeAt(index);
            });
          }

          void quantityDecrease(int index, int count) {
            setState(() {
              cartUpdateMinus(index: index, count: count);
            });
          }

          void quantityIncrease(int index, int count) {
            setState(() {
              cartUpdateAdd(index: index, count: count);
            });
          }

          if (finalLocationId == widget.snapshot[index].locationid) {
            // cartsum +=
            //     widget.snapshot[index].iRent * widget.snapshot[index].count;
            // print(cartsum);
            return CartProductCard(
                widget.userId,
                index,
                refresh,
                quantityIncrease,
                quantityDecrease,
                widget.snapshot[index].count,
                widget.snapshot[index].duration,
                widget.snapshot[index].iRent,
                widget.snapshot[index].img,
                widget.snapshot[index].locationid,
                widget.snapshot[index].name,
                widget.snapshot[index].pId);
          }
        },
      );
    else if (widget.snapshot.length == 0)
      return Container(
        child: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "././assets/images/empty.png",
              height: 200,
              // scale: 0.5,
            ),
            Text(
              "Your cart is empty",
              style: Theme.of(context).textTheme.headline3,
            ),
          ],
        )),
      );
  }
}
