import "package:flutter/material.dart";
import "package:dio/dio.dart";
import 'package:rht/utils/productdetailbuilder.dart';
import '../screens/splash_screen.dart';
import '../services/cartservice.dart';
import '../my_navigator.dart';

MyNavigator myNavigator;

class CartProductCard extends StatefulWidget {
  final String userId;
  final int index;
  final Function(int) notifyParent;
  final Function(int, int) notifyParent2;
  final Function(int, int) notifyParent3;
  final int count;
  final int duration;
  final int rent;
  final String img;
  final int deposit;
  final String locationId;
  final String name;
  final String productId;

  // final String locationId;
  // String imgPath,
  // final List<String> items;
  CartProductCard(
    this.userId,
    this.index,
    this.notifyParent,
    this.notifyParent2,
    this.notifyParent3,
    this.count,
    this.duration,
    this.rent,
    this.img,
    this.deposit,
    this.locationId,
    this.name,
    this.productId,
  );
  @override
  _CartProductCardState createState() => _CartProductCardState(count);
}

class _CartProductCardState extends State<CartProductCard> {
  bool isFavourite = false;
  bool isFav = false;
  String response;
  int stock;
  int _count;
  _CartProductCardState(this._count);
  Dio dio = new Dio();
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

  // ignore: missing_return
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
      if (stock >= _count) {
        print(_count);
        print("in if");
        return Container(
          child: Text("In stock",
              style: Theme.of(context).textTheme.bodyText1.copyWith(
                  fontWeight: FontWeight.normal,
                  color: Colors.green,
                  fontSize: 12)),
        );
      } else if (stock < _count) {
        return Container(
          child: Text("Only $stock left",
              style: Theme.of(context).textTheme.bodyText1.copyWith(
                  fontWeight: FontWeight.normal,
                  color: Colors.red,
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
                          ProductDetailBuilder(productId:widget.productId)));
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
                                      horizontal: 20, vertical: 5),
                                  // padding: EdgeInsets.symmetric(
                                  //     horizontal: 20, vertical: 10),
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: NetworkImage(widget.img ??
                                              "https://4.bp.blogspot.com/-1f1SDFIx3dY/Uh92eZAQ90I/AAAAAAAAHM4/5oiB4zC_tQ4/s1600/Photo-Background-White4.jpg"),
                                          fit: BoxFit.cover))),
                              // SizedBox(height: 10,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  RawMaterialButton(
                                    // materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                    // padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                                      constraints: BoxConstraints.tightFor(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.05,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.05),
                                      elevation: 0.0,
                                      onPressed: _count == 1
                                          ? null
                                          : () async {
                                              var result =
                                                  await cartService.countChange(
                                                      widget.userId,
                                                      1,
                                                      false,
                                                      widget.productId,
                                                      widget.duration,
                                                      _count,
                                                      widget.rent,
                                                      widget.deposit);
                                              print(result);
                                              setState(() {
                                                _count -= 1;
                                                widget.notifyParent3(
                                                    widget.index, 1);
                                              });
                                            },
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      fillColor: Color(0xFFFFFFFF),
                                      child: Icon(
                                        Icons.remove,
                                        color: Theme.of(context).accentColor,
                                        size: 20,
                                      )),
                                  SizedBox(width: 10,),
                                  Text(
                                    "$_count",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText1
                                        .copyWith(color: Colors.black87),
                                  ),
                                  SizedBox(width: 10,),
                                  RawMaterialButton(
                                    // materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                    // padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                                      constraints: BoxConstraints.tightFor(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.05,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.05),
                                      elevation: 0.0,
                                      onPressed: () async {
                                        var result =
                                            await cartService.countChange(
                                                widget.userId,
                                                1,
                                                true,
                                                widget.productId,
                                                widget.duration,
                                                _count,
                                                widget.rent,
                                                widget.deposit);
                                        print(result);
                                        setState(() {
                                          _count += 1;
                                          widget.notifyParent2(widget.index, 1);
                                        });
                                      },
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      fillColor: Color(0xFFFFFFFF),
                                      child: Icon(
                                        Icons.add,
                                        color: Theme.of(context).accentColor,
                                        size: 20,
                                      ))
                                ],
                              ),
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
                              height: 10,
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.45,
                              child: Text(
                                "${widget.name}",
                                // maxLines: 2,
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
                                  "${widget.duration} months",
                                  
                                  style: Theme.of(context)
                                      .textTheme
                                      .caption
                                      .copyWith(
                                          fontWeight: FontWeight.normal,
                                          color: Colors.black54)),
                            ),
                            SizedBox(height: 5,),
                            Container(
                              child: Text(
                                  "3 day delivery",
                                  
                                  style: Theme.of(context)
                                      .textTheme
                                      .caption
                                      .copyWith(
                                          fontWeight: FontWeight.normal,
                                          color: Colors.black54)),
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
                            IconButton(
                              color: Colors.black45,
                              icon: Icon(Icons.delete_forever),
                              onPressed: () async {
                                await cartService
                                    .deleteFromCart(finalId, widget.productId,
                                        widget.count, widget.duration)
                                    .whenComplete(() {
                                  widget.notifyParent(widget.index);
                                });
                              },
                            )
                          ],
                        ),
                      ]),
                ))));
  }
}
