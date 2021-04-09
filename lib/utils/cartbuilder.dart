import 'dart:async';

import 'package:flutter/material.dart';
import '../models/cartproduct.dart';
import '../widgets/cartproductcard.dart';
import '../screens/splash_screen.dart';

class CartBuilder extends StatefulWidget {
  final List<CartProduct> snapshot;
  final String userId;
  final StreamController streamController;
  final StreamController streamController2;
  final StreamController streamController3;
  CartBuilder(this.snapshot, this.userId, this.streamController,
      this.streamController2, this.streamController3);
  @override
  CartBuilderState createState() => CartBuilderState();
}

class CartBuilderState extends State<CartBuilder> {
  var cartsum = 0;
  var depositSum = 0;
  var empty = true;
  var count = 0;
  List<CartProduct> snapshot = [];
  cartProducts() {
    for (var i = 0; i < widget.snapshot.length; i++) {
      if (finalLocationId == widget.snapshot[i].locationid) {
        snapshot.add(widget.snapshot[i]);
      }
    }
  }

  cartSum({int index}) {
    for (var i = 0; i < widget.snapshot.length; i++) {
      if (finalLocationId == widget.snapshot[i].locationid) {
        cartsum += widget.snapshot[i].iRent * widget.snapshot[i].count;
        depositSum += widget.snapshot[i].deposit;
      }
    }
    if (index != null)
      cartsum -= widget.snapshot[index].iRent * widget.snapshot[index].count;
    print(cartsum);
    widget.streamController.sink.add(cartsum);
    widget.streamController2.sink.add(depositSum);
  }

  cartMinus({int index}) {
    if (index != null) {
      cartsum -= widget.snapshot[index].iRent * widget.snapshot[index].count;
      depositSum -= widget.snapshot[index].deposit;
    }

    print(cartsum);
    widget.streamController.sink.add(cartsum);
    widget.streamController2.sink.add(depositSum);
  }

  cartUpdateAdd({int index, int count}) {
    if (index != null) {
      cartsum += widget.snapshot[index].iRent * count;
      depositSum += widget.snapshot[index].deposit;
    }

    print(cartsum);
    widget.streamController.sink.add(cartsum);
    widget.streamController2.sink.add(depositSum);
  }

  cartUpdateMinus({int index, int count}) {
    if (index != null) {
      cartsum -= widget.snapshot[index].iRent * count;
      depositSum -= widget.snapshot[index].deposit;
    }
    print(cartsum);
    widget.streamController.sink.add(cartsum);
    widget.streamController2.sink.add(depositSum);
  }

  void initState() {
    super.initState();
    cartSum();
    cartProducts();
  }

  @override
  // ignore: missing_return
  Widget build(BuildContext context) {
    print(widget.snapshot);
    if (snapshot.length > 0)
      return ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        physics: ScrollPhysics(),
        padding: EdgeInsets.all(2.0),
        itemCount: snapshot.length,
        // ignore: missing_return
        itemBuilder: (BuildContext context, int index) {
          // print("fina" + finalLocationId);
          // print("ida" + widget.snapshot[index].locationid);
          // print("name" + widget.snapshot[index].name);
          // print("index" + index.toString());
          void refresh(int index) {
            setState(() {
              cartMinus(index: index);
              snapshot.removeAt(index);
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

          if (finalLocationId == snapshot[index].locationid) {
            print("fin" + finalLocationId);
            // print("id" + widget.snapshot[index].locationid);

            count = count + 1;
            print("count" + count.toString());
            return CartProductCard(
                widget.userId,
                index,
                refresh,
                quantityIncrease,
                quantityDecrease,
                snapshot[index].count,
                snapshot[index].duration,
                snapshot[index].iRent,
                snapshot[index].img,
                snapshot[index].deposit,
                snapshot[index].locationid,
                snapshot[index].name,
                snapshot[index].pId);
          } else {}
          ;
          // if (count == 0) widget.streamController3.sink.add(empty);
        },
      );
    else if (snapshot.length == 0) {
      widget.streamController3.sink.add(empty);
      return Container(
        child: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "././assets/images/empty.png",
              height: 200,
            ),
            Text(
              "Your cart is empty",
              style: Theme.of(context)
                  .textTheme
                  .headline6
                  .copyWith(color: Colors.black87),
            ),
          ],
        )),
      );
    }
  }
}
