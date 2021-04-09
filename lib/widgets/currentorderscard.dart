import "package:flutter/material.dart";
import "package:dio/dio.dart";
import "package:intl/intl.dart";
import 'package:rht/utils/stackbuilder.dart';
import 'package:rht/services/uploadservice.dart';

class CurrentOrdersCard extends StatefulWidget {
  final int index;
  final int count;
  final int duration;
  final int rent;
  final String img;
  final int deposit;
  final String locationId;
  final String name;
  final String productId;
  final String checkoutDate;
  final Function(int) notifyParent;

  // final String locationId;
  // String imgPath,
  // final List<String> items;
  CurrentOrdersCard(
    this.index,
    this.count,
    this.duration,
    this.rent,
    this.img,
    this.deposit,
    this.locationId,
    this.name,
    this.productId,
    this.checkoutDate,
    this.notifyParent
  );
  @override
  _CurrentOrdersCardState createState() => _CurrentOrdersCardState();
}

enum ButtonAction {
  Cancel,
  Continue,
}

class _CurrentOrdersCardState extends State<CurrentOrdersCard> {
  bool isFavourite = false;
  bool isFav = false;
  String response;
  int stock;
  DateTime deliveryDate;
  String month;
  int date;
  Dio dio = new Dio();
  UploadService cartService = new UploadService();

  // int cast(x) => x is int ? x : null;

  void initState() {
    super.initState();
    // print("result"+result.toString());
    parseDate();
  }

  void showMaterialDialog<T>({BuildContext context, Widget child}) {
    showDialog<T>(
      context: context,
      builder: (BuildContext context) => child,
    );
  }

  void parseDate() {
    DateTime tempDate = new DateFormat("yyyy-MM-dd").parse(widget.checkoutDate);
    deliveryDate = tempDate.add(Duration(days: 30));
    print(widget.checkoutDate);

    // print(DateTime.now());
    print(deliveryDate.month);
    List months = [
      "Jan",
      "Feb",
      "Mar",
      "Apr",
      "May",
      "Jun",
      "Jul",
      "Aug",
      "Sep",
      "Oct",
      "Nov",
      "Dec"
    ];
    month = months[deliveryDate.month - 1];
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(top: 5.0, bottom: 5.0, left: 5.0, right: 5.0),
        child: InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => BarBuild(
                          widget.index,
                          widget.count,
                          widget.duration,
                          widget.rent,
                          widget.img,
                          widget.deposit,
                          widget.locationId,
                          widget.name,
                          widget.productId,
                          widget.checkoutDate,
                          widget.notifyParent)));
            },
            child: Container(
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade200, width: 2),
                    borderRadius: BorderRadius.circular(15.0),
                    color: Colors.white),
                child: IntrinsicHeight(
                  child: Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        IntrinsicHeight(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 15,
                              ),
                              Container(
                                  // constraints: BoxConstraints.loose(Size.fromHeight(100)),
                                  height:
                                      MediaQuery.of(context).size.width * 0.25,
                                  width:
                                      MediaQuery.of(context).size.width * 0.25,
                                  margin: EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 0),
                                  // padding: EdgeInsets.symmetric(
                                  //     horizontal: 20, vertical: 10),
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: NetworkImage(widget.img ??
                                              "https://4.bp.blogspot.com/-1f1SDFIx3dY/Uh92eZAQ90I/AAAAAAAAHM4/5oiB4zC_tQ4/s1600/Photo-Background-White4.jpg"),
                                          fit: BoxFit.cover))),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    "Qty: ${widget.count}",
                                    style: Theme.of(context)
                                        .textTheme
                                        .caption
                                        .copyWith(color: Colors.black87),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              )
                            ],
                          ),
                        ),
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
                                  height: 20,
                                ),
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.47,
                                  child: Text(
                                    "${widget.name}",
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
                                      child: Text("Rent:",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText2
                                              .copyWith(color: Colors.black54)),
                                    ),
                                    Container(
                                      child: Text(" ₹${widget.rent}/month",
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
                                      child: Text("Deposit:",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText2
                                              .copyWith(color: Colors.black54)),
                                    ),
                                    Container(
                                      child: Text(" ₹${widget.deposit}",
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
                                  child: Text(
                                      "Rented for ${widget.duration} months",
                                      style: Theme.of(context)
                                          .textTheme
                                          .caption
                                          .copyWith(
                                              fontWeight: FontWeight.normal,
                                              color: Colors.black54)),
                                ),
                                SizedBox(
                                  height: 5,
                                ), // stockWidget()
                              ],
                            ),
                          ],
                        ),
                        Flexible(
                            fit: FlexFit.loose,
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        color: Colors.white),
                                    alignment: Alignment.topCenter,
                                    child: IconButton(
                                      icon: Icon(
                                        Icons.arrow_forward_ios,
                                        color: Colors.black54,
                                      ),
                                      iconSize: 20,
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (BuildContext
                                                        context) =>
                                                    BarBuild(
                                                        widget.index,
                                                        widget.count,
                                                        widget.duration,
                                                        widget.rent,
                                                        widget.img,
                                                        widget.deposit,
                                                        widget.locationId,
                                                        widget.name,
                                                        widget.productId,
                                                        widget.checkoutDate,
                                                        widget.notifyParent)));
                                      },
                                    )),
                              ],
                            ))
                        // Flexible(
                        //   fit: FlexFit.loose,
                        //   child: Row(
                        //     mainAxisSize: MainAxisSize.min,
                        //     mainAxisAlignment: MainAxisAlignment.start,
                        //     crossAxisAlignment: CrossAxisAlignment.start,
                        //     children: [
                        //       Container(
                        //         decoration: BoxDecoration(
                        //             borderRadius: BorderRadius.circular(5),
                        //             color: Colors.white),
                        //         // color: Colors.white,
                        //         alignment: Alignment.topCenter,
                        //         child: PopupMenuButton<String>(
                        //           elevation: 2,
                        //           shape: RoundedRectangleBorder(
                        //               borderRadius: BorderRadius.circular(5)),
                        //           padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                        //           onSelected: (String newValue) async {
                        //             _selectedVal = newValue;
                        //             if (_selectedVal == "Cancel Order") {
                        //               showMaterialDialog<ButtonAction>(
                        //                 context: context,
                        //                 child: AlertDialog(
                        //                   title: const Text(
                        //                     'Do you really want to cancel this order?',
                        //                     style: TextStyle(
                        //                         color: Colors.black45,
                        //                         fontSize: 16),
                        //                   ),
                        //                   actions: <Widget>[
                        //                     FlatButton(
                        //                       child: const Text(
                        //                         'Back',
                        //                         style: TextStyle(
                        //                             color: Color(0xFF2873f0)),
                        //                       ),
                        //                       onPressed: () {
                        //                         Navigator.of(context).pop();
                        //                       },
                        //                     ),
                        //                     FlatButton(
                        //                       child: const Text(
                        //                         'Cancel Order',
                        //                         style: TextStyle(
                        //                             color: Colors.red),
                        //                       ),
                        //                       onPressed: () async {
                        //                         // await _uploadService
                        //                         //     .delete(
                        //                         //   widget.productId,
                        //                         // )
                        //                         //     .whenComplete(() {
                        //                         //   Navigator.pop(context);
                        //                         //   widget
                        //                         //       .notifyParent(widget.index);
                        //                         // });
                        //                       },
                        //                     ),
                        //                   ],
                        //                 ),
                        //               );
                        //             } else if (_selectedVal ==
                        //                 "Savings Report") {
                        //               Navigator.push(
                        //                   context,
                        //                   MaterialPageRoute(
                        //                       builder: (BuildContext context) =>
                        //                           BarBuild(
                        //                             widget.index,
                        //                             widget.count,
                        //                             widget.duration,
                        //                             widget.rent,
                        //                             widget.img,
                        //                             widget.deposit,
                        //                             widget.locationId,
                        //                             widget.name,
                        //                             widget.productId,
                        //                             widget.checkoutDate)));
                        //             }
                        //           },
                        //           itemBuilder: (BuildContext context) =>
                        //               _popUpMenuItems,
                        //         ),
                        //       )
                        //     ],
                        //   ),
                        // ),
                      ]),
                ))));
  }
}
