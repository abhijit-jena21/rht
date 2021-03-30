import 'package:flutter/material.dart';
import 'package:rht/models/product.dart';
import 'package:rht/screens/admin/imageedit.dart';
import 'package:rht/screens/splash_screen.dart';
import 'package:rht/services/uploadservice.dart';
import 'adminstarter.dart';

class EditDetailsForm extends StatefulWidget {
  // final void Function(int, int, String) onButtonTapped;
  // EditDetailsForm(this.onButtonTapped);
  final Product snapshot;
  EditDetailsForm({this.snapshot});
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
  String _stock;
  String _subcategoryid;
  String _category;
  String _subcategory;
  int tabIndex;
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
      indices=indices.replaceRange(index, index+1, "1");
      print("indices"+indices);
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
          .whenComplete(() {
        print("done");
        // widget.onButtonTapped(1, tabIndex, finalAdminLocationId);
        // Navigator.pop(context);
        AdminStarter.starterKey.currentState
            .onButtonTapped(1, 0, finalAdminLocationId);
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
                  validator: _validateText,
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
                    // FutureBuilder(
                    //     future: populateImages(),
                    //     // ignore: missing_return
                    //     builder: (context, AsyncSnapshot snapshot) {
                    //       print("_images222" + _images.toString());
                    //       if (snapshot.connectionState ==
                    //           ConnectionState.done) {
                    //         if (snapshot.data == null) {
                    //           return Container(
                    //             child: Center(
                    //                 child: Column(
                    //               mainAxisAlignment: MainAxisAlignment.center,
                    //               children: [
                    //                 Image.asset(
                    //                   "././assets/images/empty.png",
                    //                   height: 200,
                    //                   // scale: 0.5,
                    //                 ),
                    //                 Text(
                    //                   "Couldn't load details",
                    //                   style: Theme.of(context)
                    //                       .textTheme
                    //                       .headline6
                    //                       .copyWith(color: Colors.black87),
                    //                 ),
                    //               ],
                    //             )),
                    //           );
                    //         } else {
                    //           print(snapshot.data);
                    //           return SingleImageEdit(_getImages, snapshot.data);
                    //         }
                    //       } else if (snapshot.connectionState ==
                    //           ConnectionState.none) {
                    //         return Text(
                    //           'error',
                    //           style: Theme.of(context).textTheme.headline3,
                    //         );
                    //       } else {
                    //         return Container(
                    //           alignment: Alignment.center,
                    //           padding: EdgeInsets.symmetric(vertical: 30),
                    //           child: Center(
                    //             child: Container(
                    //               width: 50,
                    //               height: 50,
                    //               child: CircularProgressIndicator(),
                    //             ),
                    //           ),
                    //         );
                    //       }
                    //     }),
                  ],
                ),
                RaisedButton(
                  color: Theme.of(context).accentColor,
                  child: Text(
                    "Submit",
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
