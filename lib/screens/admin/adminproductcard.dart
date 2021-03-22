import "package:flutter/material.dart";
import 'package:dio/dio.dart';
import 'package:rht/services/cartservice.dart';

import "../../my_navigator.dart";

MyNavigator myNavigator;

class AdminProductCard extends StatefulWidget {
  final String productId;
  final String name;
  final List<String> img;
  final String details;
  final int price;
  final int rent;
  final int deposit;
  final int duration;
  final String locationId;
  final List<String> items;
  AdminProductCard(
      this.productId,
      this.name,
      this.img,
      this.details,
      this.price,
      this.rent,
      this.deposit,
      this.duration,
      this.items,
      this.locationId);
  @override
  _AdminProductCardState createState() => _AdminProductCardState();
}

class _AdminProductCardState extends State<AdminProductCard> {
  bool isFavourite;
  bool isFav = false;
  String response;
  Dio dio = new Dio();
  int stock;
  CartService cartService = new CartService();

  // int cast(x) => x is int ? x : null;

  void initState() {
    super.initState();
    checkStock().then((result) {
      // print(result);
      // print(result.runtimeType);
      setState(() {
        stock = result;
        print(stock);
      });
    });
    // print("result"+result.toString());
  }

  Future<int> checkStock() async {
    Response response = await cartService.getStock(widget.productId);
    print(response.data);
    // print("responseData" + responseData.toString());
    return response.data;
  }

  Widget stockWidget() {
    if (stock == null) {
      return Container(
        child: Text("",
            style: Theme.of(context)
                .textTheme
                .bodyText1
                .copyWith(fontWeight: FontWeight.normal, color: Colors.green)),
      );
    } else {
       if (stock > 0) {
        return Container(
          child: Text("$stock left",
              style: Theme.of(context).textTheme.bodyText1.copyWith(
                  fontWeight: FontWeight.normal,
                  color: Colors.green,
                  fontSize: 12)),
        );
      } else if (stock == 0)
        return Container(
          child: Text("Out of stock",
              style: Theme.of(context).textTheme.bodyText1.copyWith(
                  fontWeight: FontWeight.normal,
                  color: Colors.red,
                  fontSize: 12)),
        );
    }
  }

  // foobar() async {
  //   await _getWishlistedProducts();
  // }
  static const menuItems = <String>['Edit', 'Delete'];
  String _selectedVal;

  @override
  Widget build(BuildContext context) {
    List<PopupMenuItem<String>> _popUpMenuItems = menuItems
        .map(
          (String value) => PopupMenuItem<String>(
            value: value,
            child: Text(
              value,
              style: Theme.of(context)
                  .textTheme
                  .bodyText2
                  .copyWith(color: Colors.black87),
            ),
          ),
        )
        .toList();
    return Padding(
        padding: EdgeInsets.only(top: 5.0, bottom: 5.0, left: 5.0, right: 5.0),
        child: InkWell(
            onTap: () {
              // Navigator.push(
              //     context,
              //     MaterialPageRoute(
              //         builder: (BuildContext context) =>
              //             ProductDetailBuilder(widget.productId)));
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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IntrinsicHeight(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 10,
                              ),
                              Container(
                                  // constraints: BoxConstraints.loose(Size.fromHeight(100)),
                                  height:
                                      MediaQuery.of(context).size.width * 0.25,
                                  width:
                                      MediaQuery.of(context).size.width * 0.25,
                                  margin: EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 0),
                                  // padding: EdgeInsets.symmetric(
                                  //     horizontal: 20, vertical: 10),
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: NetworkImage(widget.img[0] ??
                                              "https://4.bp.blogspot.com/-1f1SDFIx3dY/Uh92eZAQ90I/AAAAAAAAHM4/5oiB4zC_tQ4/s1600/Photo-Background-White4.jpg"),
                                          fit: BoxFit.contain))),

                              // SizedBox(
                              //   height: 10,
                              // )
                            ],
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,

                          // mainAxisSize: MainAxisSize.min,
                          children: [
                            SizedBox(
                              height: 20,
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.45,
                              child: Text(
                                "${widget.name}",
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context)
                                    .textTheme
                                    .headline3
                                    .copyWith(
                                        color: Theme.of(context).accentColor,
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
                                  child: Text(" ₹1500",
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
                            SizedBox(
                              height: 5,
                            ),
                            stockWidget()
                          ],
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: Colors.white),
                                // color: Colors.white,
                                alignment: Alignment.topCenter,
                                child: PopupMenuButton<String>(
                                  elevation: 2,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5)),
                                  padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                  onSelected: (String newValue) {
                                    _selectedVal = newValue;
                                  },
                                  itemBuilder: (BuildContext context) =>
                                      _popUpMenuItems,
                                ),
                              )
                          ],
                        ),
                      ]),
                ))));
    // print("hereiam" + wishlistedProducts[0].sId);
    // return Padding(
    //     padding: EdgeInsets.only(top: 5.0, bottom: 5.0, left: 5.0, right: 5.0),
    //     child: InkWell(
    //         onTap: () {},
    //         child: Container(
    //             decoration: BoxDecoration(
    //                 borderRadius: BorderRadius.circular(15.0),
    //                 // boxShadow: [
    //                 //   BoxShadow(
    //                 //       color: Colors.grey.withOpacity(0.2),
    //                 //       spreadRadius: 3.0,
    //                 //       blurRadius: 5.0)
    //                 // ],
    //                 color: Colors.white),
    //             child: Column(mainAxisSize: MainAxisSize.min, children: [
    //               SizedBox(
    //                 height: 110,
    //                 // width: 110,
    //                 child: Stack(
    //                   alignment: AlignmentDirectional.center,
    //                   // overflow: Overflow.clip,
    //                   fit: StackFit.loose,
    //                   children: [
    //                     // Hero(
    //                     //     tag: imgPath,
    //                     Container(
    //                         // alignment: Alignment.center,
    //                         constraints:
    //                             BoxConstraints.loose(Size.fromHeight(100)),
    //                         height: 110,
    //                         width: double.infinity,
    //                         padding: EdgeInsets.symmetric(
    //                             horizontal: 10, vertical: 10),
    //                         decoration: BoxDecoration(
    //                             image: DecorationImage(
    //                                 image: NetworkImage(widget.img[0]),
    //                                 fit: BoxFit.contain))),
    //                     Positioned(
    //                       top: 5,
    //                       right: 10,
    //                       child: SizedBox(
    //                           height: 25,
    //                           width: 20,
    //                           child: Container(
    //                             decoration: BoxDecoration(
    //                                 borderRadius: BorderRadius.circular(5),
    //                                 color: Colors.white),
    //                             // color: Colors.white,
    //                             alignment: Alignment.center,
    //                             child: PopupMenuButton<String>(
    //                               elevation: 2,
    //                               shape: RoundedRectangleBorder(
    //                                   borderRadius: BorderRadius.circular(5)),
    //                               padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
    //                               onSelected: (String newValue) {
    //                                 _selectedVal = newValue;
    //                               },
    //                               itemBuilder: (BuildContext context) =>
    //                                   _popUpMenuItems,
    //                             ),
    //                           )),
    //                     ),
    //                     if (widget.items.length == 0)
    //                       Positioned(
    //                         bottom: 5,
    //                         // right: 10,
    //                         child: SizedBox(
    //                             height: 25,
    //                             width: 75,
    //                             child: Container(
    //                               alignment: Alignment.center,
    //                               color: Colors.redAccent,
    //                               child: Text(
    //                                 "Out of stock",
    //                                 style: TextStyle(
    //                                     color: Colors.white, fontSize: 10),
    //                               ),
    //                             )),
    //                       ),
    //                   ],
    //                 ),
    //               ),
    //               SizedBox(height: 7.0),
    //               Container(
    //                 alignment: Alignment.centerLeft,
    //                 padding: EdgeInsets.only(left: 10),
    //                 height: 40,
    //                 child: Text(widget.name,
    //                     textAlign: TextAlign.left,
    //                     style: TextStyle(
    //                         color: Color(0xFF575E67),
    //                         // fontFamily: 'Varela',
    //                         fontSize: 12.0)),
    //               ),
    //               Container(
    //                 alignment: Alignment.centerLeft,
    //                 padding: EdgeInsets.only(left: 10),
    //                 height: 20,
    //                 child: Text("₹ " + widget.rent.toString() + '/month',
    //                     textAlign: TextAlign.left,
    //                     style: TextStyle(
    //                         color: Color(0xFFCC8053),
    //                         // fontFamily: 'Varela',
    //                         fontSize: 12.0)),
    //               ),
    //             ]))));
  }
}
