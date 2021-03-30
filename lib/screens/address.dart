import 'package:flutter/material.dart';
import 'package:rht/models/pincode.dart';
import 'package:rht/screens/splash_screen.dart';
import 'package:rht/services/postalservice.dart';

class AddressForm extends StatefulWidget {
  final GlobalKey<FormState> _formKey;
  // final Function notifyParent;
  AddressForm(this._formKey);
  @override
  _AddressFormState createState() => _AddressFormState();
}

class _AddressFormState extends State<AddressForm> {
  String _address;
  Pincode pin;
  PostService postService = PostService();

  String _validateText(String value) {
    if (value.isEmpty) return 'Required Field.';
    final RegExp nameExp = RegExp(r' ._-,^[A-Za-z0-9 ]+$');
    if (!nameExp.hasMatch(value)) {
      return 'Please enter only alphanumeric characters.';
    }
    return null;
  }

  String validatePin(String value) {
    if (value.isEmpty)
      return 'Required Field';
    else if (value.length == 6) {
      receivePin(value);

      if (pin.status == "Error") return "Enter valid pincode";
      if (pin.status == "Success") {
        if (finalLocation != pin.postOffice[0].district) {
          return 'Not deliverable in your area';
        }
      }
      return null;
    }
  }

  receivePin(pincode) async {
    pin = await postService.getPin(pincode);
  }

  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget._formKey,
      child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            const SizedBox(height: 10.0),

            // "Product Name" form.
            TextFormField(
              initialValue: finalAddress,
              readOnly: true,
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
                hintText: 'Enter your address',
                labelText: 'Address *',
              ),
              onSaved: (String value) {
                this._address = value;
                // widget.notifyParent(this._address);
                print('name=$_address');
              },
              // validator: _validateText,
            ),

            const SizedBox(height: 10.0),

            // "product Details" form
            TextFormField(
              // initialValue: "Bangalore",
              // readOnly: true,
              keyboardType: TextInputType.number,
              maxLength: 6,
              maxLines: 1,
              textCapitalization: TextCapitalization.words,
              autovalidateMode: AutovalidateMode.disabled,
              style: Theme.of(context)
                  .textTheme
                  .bodyText1
                  .copyWith(color: Colors.black87),
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                // filled: true,
                hintText: 'Pincode',
                labelText: 'Enter pincode *',
              ),
              // onChanged: (String value) {
              //   validatePin(value);
              // },
              onSaved: (String value) {},
              validator: validatePin,
            ),
            const SizedBox(height: 10.0),
            TextFormField(
              initialValue: "Bangalore",
              readOnly: true,
              keyboardType: TextInputType.name,
              maxLines: 1,
              textCapitalization: TextCapitalization.words,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              style: Theme.of(context)
                  .textTheme
                  .bodyText1
                  .copyWith(color: Colors.black87),
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                // filled: true,
                hintText: 'City',
                labelText: 'City *',
              ),
            ),
            SizedBox(
              height: 10,
            )
          ]),
    );
  }
}
