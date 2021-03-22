import 'package:flutter/material.dart';
import 'package:rht/screens/admin/dropdown.dart';
import 'package:rht/screens/admin/imageupload.dart';
import 'package:rht/services/uploadservice.dart';

class DetailsForm extends StatefulWidget {
  @override
  _DetailsFormState createState() => _DetailsFormState();
}

class _DetailsFormState extends State<DetailsForm> {
  final _formKey = GlobalKey<FormState>();
  String _name;
  String _details;
  String _price;
  String _rent;
  String _deposit;
  String _stock;
  String _subcategory;
  List<Object> _images;
  UploadService _uploadService = UploadService();

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
      return 'Please enter only numbers.';
    }
    return null;
  }

  void _getSubcategoryId(String val) {
    setState(() {
      _subcategory = val;
    });
  }

  void _getImages(List<Object> val) {
    setState(() {
      _images = val;
    });
  }

  void _formSubmit() async {
    var form = _formKey.currentState;
    print(_subcategory);
    print(_images);
    if (form.validate()) {
      form.save();
      await _uploadService
          .addProduct(_name, _subcategory, _price, _rent, _deposit, _stock,
              _details, _images)
          .whenComplete(() {
        print("done");
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
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
              textCapitalization: TextCapitalization.words,
              autovalidateMode: AutovalidateMode.onUserInteraction,
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

            const SizedBox(height: 15.0),
            DropDown(
              notifyParent: _getSubcategoryId,
            ),

            // "Price" form.
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.4,
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    textCapitalization: TextCapitalization.words,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
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
                    validator: _validateText,
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.4,
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    textCapitalization: TextCapitalization.words,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
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
                    validator: _validateText,
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
                    textCapitalization: TextCapitalization.words,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
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
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.4,
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    textCapitalization: TextCapitalization.words,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1
                        .copyWith(color: Colors.black87),
                    decoration: const InputDecoration(
                      border: UnderlineInputBorder(),
                      // filled: true,
                      hintText: 'Enter quantity',
                      labelText: 'Quantity *',
                    ),
                    onSaved: (String value) {
                      this._stock = value;
                      print('Quanity=$_stock');
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
              maxLines: 5,
              textCapitalization: TextCapitalization.words,
              autovalidateMode: AutovalidateMode.onUserInteraction,
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
                SingleImageUpload(_getImages),
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
    );
  }
}
