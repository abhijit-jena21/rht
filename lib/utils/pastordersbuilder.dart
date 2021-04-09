import 'package:flutter/material.dart';
import 'package:rht/models/currentorders.dart';
import 'package:rht/widgets/pastorderscard.dart';

import '../screens/splash_screen.dart';

class PastOrdersBuilder extends StatefulWidget {
  final List<Currentorder> snapshot;
  // final Function refresh;
  PastOrdersBuilder(this.snapshot);
  @override
  _PastOrdersBuilderState createState() => _PastOrdersBuilderState();
}

class _PastOrdersBuilderState extends State<PastOrdersBuilder> {
  void initState() {
    super.initState();
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
          childAspectRatio: 2.2,
        ),
        padding: EdgeInsets.all(2.0),
        itemCount: widget.snapshot.length,
        // ignore: missing_return
        itemBuilder: (BuildContext context, int index) {
          // if (finalLocationId == widget.snapshot[index].locationid) {
            return PastOrdersCard(
                index,
                widget.snapshot[index].count,
                widget.snapshot[index].duration,
                widget.snapshot[index].iRent,
                widget.snapshot[index].img,
                widget.snapshot[index].deposit,
                widget.snapshot[index].locationid,
                widget.snapshot[index].name,
                widget.snapshot[index].pId,
                widget.snapshot[index].checkoutdate,
                widget.snapshot[index].iscancelled
                );
          // }
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
              "No orders in this section",
              style: Theme.of(context).textTheme.headline6.copyWith(color: Colors.black87),
            ),
          ],
        )),
      );
  }
}