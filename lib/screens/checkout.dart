import 'package:flutter/material.dart';

class CheckOut extends StatefulWidget {
  @override
  _CheckOutState createState() => _CheckOutState();
}

class _CheckOutState extends State<CheckOut> {
  int _currentStep = 0;
  List<Step> _mySteps() {
    List<Step> _steps = [
      Step(
        title: Text(
          "Confirm Address",
          style: Theme.of(context)
              .textTheme
              .headline3
              .copyWith(fontWeight: FontWeight.bold),
        ),
        content: TextFormField(
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
                // this._details = value;
                // print('details=$_details');
              },
              // validator: _validateText,
            ),
        isActive: _currentStep >= 0,
      ),
      Step(
        title: Text(
          "Select Payment Method",
          style: Theme.of(context)
              .textTheme
              .headline3
              .copyWith(fontWeight: FontWeight.bold),
        ),
        content: TextField(),
        isActive: _currentStep >= 0,
      ),
      Step(
        title: Text(
          "Add Stock",
          style: Theme.of(context)
              .textTheme
              .headline3
              .copyWith(fontWeight: FontWeight.bold),
        ),
        content: TextField(),
        isActive: _currentStep >= 0,
      ),
    ];
    return _steps;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Checkout",
          style: Theme.of(context)
              .textTheme
              .headline2
              .copyWith(color: Theme.of(context).accentColor),
        ),
        leading: Icon(
          Icons.arrow_back,
          color: Colors.black,
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
      ),
      body: Stepper(
        steps: _mySteps(),
        currentStep: this._currentStep,
        onStepTapped: (step) {
          setState(() {
            this._currentStep = step;
          });
        },
        onStepContinue: () {
          setState(() {
            if (this._currentStep < this._mySteps().length - 1) {
              this._currentStep = this._currentStep + 1;
            } else {}
          });
        },
        onStepCancel: () {
          setState(() {
            if (this._currentStep > 0) {
              this._currentStep = this._currentStep - 1;
            } else {
              this._currentStep = 0;
            }
          });
        },
      ),
    );
  }
}