import 'package:flutter/material.dart';

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
  String _subcategory;

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

  @override
  Widget build(BuildContext context) {
    return Form(
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
              style: Theme.of(context).textTheme.headline3,
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                // filled: true,
                hintText: 'Enter product name',
                labelText: 'Name *',
              ),
              onSaved: (String value) {
                this._name = value;
                print('name=$_name');
              },
              validator: _validateText,
            ),

            const SizedBox(height: 10.0),

            // "Price" form.
            TextFormField(
              keyboardType: TextInputType.number,
              textCapitalization: TextCapitalization.words,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              style: Theme.of(context).textTheme.headline3,
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                // filled: true,
                hintText: 'Enter price',
                labelText: 'Price *',
              ),
              onSaved: (String value) {
                this._name = value;
                print('Price=$_price');
              },
              validator: _validateText,
            ),

            const SizedBox(height: 10.0),

            // "product Details" form
            TextFormField(
              keyboardType: TextInputType.name,
              maxLines: 5,
              textCapitalization: TextCapitalization.words,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              style: Theme.of(context).textTheme.headline3,
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
          ]),
    );
  }
}
