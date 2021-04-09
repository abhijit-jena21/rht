import 'package:flutter/material.dart';
import 'package:rht/models/currentorders.dart';
import 'package:rht/widgets/admin/currentusercard.dart';

class CurrentOrderBuilder extends StatefulWidget {
  final List<CurrentOrders> snapshot;
  final String from;
  CurrentOrderBuilder({this.snapshot, this.from});
  @override
  _CurrentOrderBuilderState createState() => _CurrentOrderBuilderState();
}

class _CurrentOrderBuilderState extends State<CurrentOrderBuilder> {
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
            childAspectRatio: 2.5,
          ),
          padding: EdgeInsets.all(2.0),
          itemCount: widget.snapshot.length,
          // ignore: missing_return
          itemBuilder: (BuildContext context, int index) {
            return CurrentUserCard(index: index, snapshot: widget.snapshot[index], from: widget.from);
          });
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
              "No orders here...",
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
