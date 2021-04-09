import 'package:flutter/material.dart';
import 'package:rht/models/currentorders.dart';
import 'package:rht/screens/admin/usercarddetails.dart';

class CurrentUserCard extends StatefulWidget {
  final int index;
  final CurrentOrders snapshot;
  final String from;
  CurrentUserCard({this.index, this.snapshot, this.from});
  @override
  _CurrentUserCardState createState() => _CurrentUserCardState();
}

class _CurrentUserCardState extends State<CurrentUserCard> {

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(top: 5.0, bottom: 5.0, left: 5.0, right: 5.0),
        child: InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) =>
                          UserCardDetails(
                            widget.snapshot
             )));
            },
            child: Container(
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade200, width: 2),
                    borderRadius: BorderRadius.circular(5.0),
                    color: Colors.white),
                child: IntrinsicHeight(
                  child: Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 10,
                        ),
                        Column(
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,

                              // mainAxisSize: MainAxisSize.min,
                              children: [
                                SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  // width: MediaQuery.of(context).size.width * 0.55,
                                  child: Text(
                                    "${widget.snapshot.name}",
                                    // maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline3
                                        .copyWith(
                                            color:
                                                Theme.of(context).accentColor,
                                            // fontWeight: FontWeight.bold,
                                            fontSize: 16),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    Container(
                                      child: Text("Address:",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText2
                                              .copyWith(color: Colors.black54)),
                                    ),
                                    Container(
                                      child: Text(" ${widget.snapshot.address}",
                                          overflow: TextOverflow.ellipsis,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText2
                                              .copyWith(
                                                // fontWeight: FontWeight.w800,
                                                color: Colors.black87,
                                              )),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  children: [
                                    Container(
                                      child: Text("Phone:",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText2
                                              .copyWith(color: Colors.black54)),
                                    ),
                                    Container(
                                      child: Text(" ${widget.snapshot.phone}",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText2
                                              .copyWith(
                                                  // fontWeight: FontWeight.w800,
                                                  color: Colors.black87)),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  child: Text("${widget.snapshot.currentorder.length} products",
                                  style: Theme.of(context)
                                    .textTheme
                                    .bodyText2
                                    .copyWith(color: Colors.black54)),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ]),
                ))));
  }
}
