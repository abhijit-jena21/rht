import 'package:flutter/material.dart';
import 'package:rht/models/currentorders.dart';
import '../screens/splash_screen.dart';
import '../widgets/currentorderscard.dart';

class CurrentOrdersBuilder extends StatefulWidget {
  final List<Currentorder> snapshot;
  // final Function refresh;
  CurrentOrdersBuilder(this.snapshot);
  @override
  _CurrentOrdersBuilderState createState() => _CurrentOrdersBuilderState();
}

class _CurrentOrdersBuilderState extends State<CurrentOrdersBuilder> {
  void initState() {
    super.initState();
  }

  @override
  // ignore: missing_return
  Widget build(BuildContext context) {
    print(widget.snapshot);
    if (widget.snapshot.length > 0)
      return ListView.builder( 
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        physics: ScrollPhysics(),
        padding: EdgeInsets.all(2.0),
        itemCount: widget.snapshot.length,
        // ignore: missing_return
        itemBuilder: (BuildContext context, int index) {
          void refresh(int index) {
            setState(() {
              widget.snapshot.removeAt(index);
            });
          }

          // if (finalLocationId == widget.snapshot[index].locationid) {
            return CurrentOrdersCard(
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
                refresh);
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
              "You haven't ordered anything",
              style: Theme.of(context).textTheme.headline6.copyWith(color: Colors.black87),
            ),
          ],
        )),
      );
  }
}