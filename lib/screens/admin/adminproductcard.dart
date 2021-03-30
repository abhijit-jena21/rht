import "package:flutter/material.dart";
import 'package:dio/dio.dart';
import 'package:rht/screens/admin/editdetailsbuilder.dart';
import 'package:rht/screens/cart.dart';
import 'package:rht/services/cartservice.dart';
import 'package:rht/services/uploadservice.dart';
import 'editproduct.dart';

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
  final int index;
  final Function(int) notifyParent;
  // final void Function(int, int, String) onButtonTapped;
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
      this.locationId,
      this.index,
      this.notifyParent,);
  @override
  _AdminProductCardState createState() => _AdminProductCardState();
}

enum ButtonAction {
  cancel,
  Logout,
}

class _AdminProductCardState extends State<AdminProductCard> {
  bool isFavourite;
  bool isFav = false;
  String response;
  Dio dio = new Dio();
  int stock;
  UploadService _uploadService = UploadService();
  CartService cartService = CartService();
  String quantity;
  // int cast(x) => x is int ? x : null;

  void initState() {
    super.initState();
    checkStock().then((result) {
      // print(result);
      // print(result.runtimeType);
      if (mounted)
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
      } else if (stock <= 0)
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
  static const menuItems = <String>['Edit', 'Update Stock', 'Delete'];
  String _selectedVal;

  void showMaterialDialog<T>({BuildContext context, Widget child}) {
    showDialog<T>(
      context: context,
      builder: (BuildContext context) => child,
    );
  }

  String _validateNumber(String value) {
    if (value.isEmpty) return 'Required Field.';
    final RegExp nameExp = RegExp(r'^[0-9 ]+$');
    if (!nameExp.hasMatch(value)) {
      return 'Please enter only numbers.';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
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
                      crossAxisAlignment: CrossAxisAlignment.start,
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
                                      horizontal: 10, vertical: 0),
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
                                  child: Text("${widget.deposit}",
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
                                // color: Colors.white,
                                alignment: Alignment.topCenter,
                                child: PopupMenuButton<String>(
                                  elevation: 2,
                                  // shape: RoundedRectangleBorder(
                                  //     borderRadius: BorderRadius.circular(5)),
                                  padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                  onSelected: (String newValue) async {
                                    _selectedVal = newValue;
                                    if (_selectedVal == "Edit") {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => EditDetailsBuilder(
                                                productId: widget.productId
                                                  )));
                                    } else if (_selectedVal == "Delete") {
                                      showMaterialDialog<ButtonAction>(
                                        context: context,
                                        child: AlertDialog(
                                          title: const Text(
                                            'Do you really want to delete this product?',
                                            style: TextStyle(
                                                color: Colors.black45,
                                                fontSize: 16),
                                          ),
                                          actions: <Widget>[
                                            FlatButton(
                                              child: const Text(
                                                'Cancel',
                                                style: TextStyle(
                                                    color: Color(0xFF2873f0)),
                                              ),
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                            ),
                                            FlatButton(
                                              child: const Text(
                                                'Delete',
                                                style:
                                                    TextStyle(color: Colors.red),
                                              ),
                                              onPressed: () async {
                                                await _uploadService
                                                    .delete(
                                                  widget.productId,
                                                )
                                                    .whenComplete(() {
                                                  Navigator.pop(context);
                                                  widget
                                                      .notifyParent(widget.index);
                                                });
                                              },
                                            ),
                                          ],
                                        ),
                                      );
                                    } else if (_selectedVal == "Update Stock") {
                                      showMaterialDialog<ButtonAction>(
                                        context: context,
                                        child: AlertDialog(
                                          title: const Text(
                                            'Enter Stock',
                                            style: TextStyle(
                                                color: Colors.black45,
                                                fontSize: 16),
                                          ),
                                          content: Form(
                                            key: _formKey,
                                            child: TextFormField(
                                              keyboardType: TextInputType.number,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyText1
                                                  .copyWith(
                                                      color: Colors.black87),
                                              initialValue: stock.toString(),
                                              onSaved: (value) {
                                                quantity = value;
                                              },
                                              validator: _validateNumber,
                                            ),
                                          ),
                                          actions: <Widget>[
                                            FlatButton(
                                              child: const Text(
                                                'Cancel',
                                                style: TextStyle(
                                                    color: Colors.black45),
                                              ),
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                            ),
                                            FlatButton(
                                              child: const Text(
                                                'Confirm',
                                                style: TextStyle(
                                                    color: Color(0xFF2873f0)),
                                              ),
                                              onPressed: () async {
                                                var form = _formKey.currentState;

                                                form.save();
                                                await _uploadService
                                                    .updateStock(widget.productId,
                                                        quantity)
                                                    .whenComplete(() {
                                                  checkStock().then((result) {
                                                    if (mounted)
                                                      setState(() {
                                                        stock = result;
                                                        print(stock);
                                                      });
                                                  });
                                                  Navigator.pop(context);
                                                });
                                              },
                                            ),
                                          ],
                                        ),
                                      );
                                    }
                                  },
                                  itemBuilder: (BuildContext context) =>
                                      _popUpMenuItems,
                                ),
                              )
                            ],
                          ),
                        ),
                      ]),
                ))));
  }
}
