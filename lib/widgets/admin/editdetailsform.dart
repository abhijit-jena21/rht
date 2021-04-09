import 'dart:async';

import 'package:flutter/material.dart';
import 'package:rht/models/product.dart';
import 'package:rht/utils/admin/imageedit.dart';
import 'package:rht/screens/splash_screen.dart';
import 'package:rht/services/uploadservice.dart';
import '../../screens/admin/adminstarter.dart';
import 'package:fluttertoast/fluttertoast.dart';

class EditDetailsForm extends StatefulWidget {
  // final void Function(int, int, String) onButtonTapped;
  // EditDetailsForm(this.onButtonTapped);
  final StreamController streamController;
  final Product snapshot;
  EditDetailsForm({this.streamController, this.snapshot});
  @override
  _EditDetailsFormState createState() => _EditDetailsFormState();
}

class _EditDetailsFormState extends State<EditDetailsForm> {
  final _formKey = GlobalKey<FormState>();
  String _name;
  String _details;
  String _price;
  String _rent;
  String _deposit;
  // String _stock;
  String _subcategoryid;
  String _category;
  String _subcategory;
  int tabIndex;
  // ignore: deprecated_member_use
  List<Object> _images = List<Object>();
  String indices = "000";
  // AdminStarter _adminStarter = AdminStarter();
  UploadService _uploadService = UploadService();

  void initState() {
    super.initState();
    setState(() {});
  }

  String _validateText(String value) {
    if (value.isEmpty) return 'Required Field.';
    final RegExp nameExp = RegExp(r'^[A-Za-z0-9 ]+$');
    if (!nameExp.hasMatch(value)) {
      return 'Please enter only alphanumeric characters.';
    }
    return null;
  }

  String _validateEmpty(String value) {
    if (value.isEmpty) return 'Required Field.';
    return null;
  }

  String _validateNumber(String value) {
    if (value.isEmpty) return 'Required Field.';
    final RegExp nameExp = RegExp(r'^[0-9 ]+$');
    if (!nameExp.hasMatch(value)) {
      return 'Please enter numbers.';
    }
    return null;
  }

  void _getImages(int index, Object val) {
    print("called once");
    print(val.toString());
    setState(() {
      _images.add(val);
      indices = indices.replaceRange(index, index + 1, "1");
      print("indices" + indices);
      // _images.join(',');
      // _images.add(val);
    });
  }

  void _formSubmit() async {
    var form = _formKey.currentState;
    print(_subcategoryid);
    print(_category);
    print(_subcategory);
    print(_images);
    print(indices);
    if (form.validate()) {
      form.save();
      await _uploadService
          .editProduct(widget.snapshot.sId, _name, _details, _price, _rent,
              _deposit, _images, indices)
          .then((val) {
        print("val" + val.toString());
        if (val.toString() == "Not Authorized" ||
            val.toString() == "Token is expired")
          Fluttertoast.showToast(
              msg: "Please login again",
              toastLength: Toast.LENGTH_SHORT,
              backgroundColor: Colors.black87,
              textColor: Colors.white,
              fontSize: 15.0);
        else {
          print("done");
          var streamlist = [_name, _rent, _deposit];
          widget.streamController.sink.add(streamlist);
          // widget.streamController.sink.add(_rent);
          // widget.streamController.sink.add(_deposit);
          // Navigator.pop(context);
          AdminStarter.starterKey.currentState
              .onButtonTapped(1, 0, finalAdminLocationId);
        }
        print("valagain" + val.toString());
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Edit Product",
          style: Theme.of(context)
              .textTheme
              .bodyText1
              .copyWith(color: Theme.of(context).accentColor),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Colors.black,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                const SizedBox(height: 10.0),

                // "Product Name" form.
                TextFormField(
                  keyboardType: TextInputType.name,
                  initialValue: widget.snapshot.name,
                  textCapitalization: TextCapitalization.words,
                  autovalidateMode: AutovalidateMode.always,
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1
                      .copyWith(color: Colors.black87),
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    // filled: true,
                    hintText: 'Enter product name',
                    labelText: 'Product Name *',
                  ),
                  onSaved: (String value) {
                    this._name = value;
                    print('name=$_name');
                  },
                  validator: _validateText,
                ),

                const SizedBox(height: 10.0),

                // const SizedBox(height: 15.0),
                // DropDown(
                //   notifyParent: _getSubcategoryId,
                // ),

                // "Price" form.
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.4,
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        initialValue: widget.snapshot.price.toString(),
                        textCapitalization: TextCapitalization.words,
                        autovalidateMode: AutovalidateMode.always,
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1
                            .copyWith(color: Colors.black87),
                        decoration: const InputDecoration(
                          border: UnderlineInputBorder(),
                          // filled: true,
                          hintText: 'Enter price',
                          labelText: 'Price *',
                        ),
                        onSaved: (String value) {
                          this._price = value;
                          print('Price=$_price');
                        },
                        validator: _validateNumber,
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.4,
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        initialValue: widget.snapshot.rent.toString(),
                        textCapitalization: TextCapitalization.words,
                        autovalidateMode: AutovalidateMode.always,
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1
                            .copyWith(color: Colors.black87),
                        decoration: const InputDecoration(
                          border: UnderlineInputBorder(),
                          // filled: true,
                          hintText: 'Enter minimum rent',
                          labelText: 'Minimum Rent *',
                        ),
                        onSaved: (String value) {
                          this._rent = value;
                          print('Rent=$_rent');
                        },
                        validator: _validateNumber,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 15.0),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.4,
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        initialValue: widget.snapshot.deposit.toString(),
                        textCapitalization: TextCapitalization.words,
                        autovalidateMode: AutovalidateMode.always,
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1
                            .copyWith(color: Colors.black87),
                        decoration: const InputDecoration(
                          border: UnderlineInputBorder(),
                          // filled: true,
                          hintText: 'Enter deposit amount',
                          labelText: 'Deposit *',
                        ),
                        onSaved: (String value) {
                          this._deposit = value;
                          print('Deposit=$_deposit');
                        },
                        validator: _validateText,
                      ),
                    ),
                  ],
                ),

                SizedBox(
                  height: 10,
                ),

                // "product Details" form
                TextFormField(
                  keyboardType: TextInputType.name,
                  initialValue: widget.snapshot.details,
                  maxLines: 5,
                  textCapitalization: TextCapitalization.words,
                  autovalidateMode: AutovalidateMode.always,
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1
                      .copyWith(color: Colors.black87),
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    // filled: true,
                    hintText: 'Enter product details',
                    labelText: 'Details *',
                  ),
                  onSaved: (String value) {
                    this._details = value;
                    print('details=$_details');
                  },
                  validator: _validateEmpty,
                ),
                SizedBox(
                  height: 20,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Upload images *",
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1
                          .copyWith(color: Colors.black87),
                    ),
                    SingleImageEdit(_getImages, widget.snapshot.img)
                  ],
                ),
                // ignore: deprecated_member_use
                RaisedButton(
                  color: Theme.of(context).accentColor,
                  child: Text(
                    "Edit Product",
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1
                        .copyWith(color: Colors.white),
                  ),
                  onPressed: () {
                    _formSubmit();
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
