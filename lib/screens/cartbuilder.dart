import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import '../models/cartproduct.dart';
import '../screens/cartproductcard.dart';
import '../screens/splash_screen.dart';

typedef void IntCallback(int cartsum);

class CartBuilder extends StatefulWidget {
  final List<CartProduct> snapshot;
  final String userId;
  final IntCallback notifyParent;
  // final Function refresh;
  CartBuilder(this.snapshot, this.userId, this.notifyParent);
  @override
  _CartBuilderState createState() => _CartBuilderState();
}

class _CartBuilderState extends State<CartBuilder> {
  var cartsum = 0;

  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      setState(() {
        widget.notifyParent(cartsum);
        cartsum = 0;
      });
      
    });
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
          childAspectRatio: 2.5,
        ),
        padding: EdgeInsets.all(2.0),
        itemCount: widget.snapshot.length,
        // ignore: missing_return
        itemBuilder: (BuildContext context, int index) {
          void refresh(int index) {
            setState(() {
              cartsum -=
              widget.snapshot[index].iRent * widget.snapshot[index].count;
              widget.snapshot.removeAt(index);
            });
          }

          if (finalLocationId == widget.snapshot[index].locationid) {
            cartsum +=
                widget.snapshot[index].iRent * widget.snapshot[index].count;
            print(cartsum);
            return CartProductCard(
                widget.userId,
                index,
                refresh,
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
