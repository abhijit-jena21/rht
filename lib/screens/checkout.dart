import 'package:flutter/material.dart';
import 'package:rht/screens/address.dart';
import 'package:rht/screens/splash_screen.dart';
import 'package:rht/screens/success.dart';
import 'package:rht/services/checkoutservice.dart';

import 'cart.dart';

class CheckOut extends StatefulWidget {
  @override
  _CheckOutState createState() => _CheckOutState();
}

enum PaymentMethod { COD }

class _CheckOutState extends State<CheckOut> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  PaymentMethod _method = PaymentMethod.COD;
  CheckoutService _checkoutService = CheckoutService();
  int _currentStep = 0;
  final _formKey = GlobalKey<FormState>();
  final _formKey2 = GlobalKey<FormState>();

  void initState() {
    super.initState();
  }

  List<Step> _mySteps() {
    List<Step> _steps = [
      Step(
        title: Text("Confirm Address",
            style: Theme.of(context)
                .textTheme
                .bodyText1
                .copyWith(color: Theme.of(context).accentColor)),
        content: AddressForm(_formKey2),
        isActive: _currentStep >= 0,
      ),
      Step(
        title: Text(
          "Select Payment Method",
          style: Theme.of(context)
              .textTheme
              .bodyText1
              .copyWith(color: Theme.of(context).accentColor),
        ),
        content: ListTile(
          title: Text(
            "Cash on Delivery",
            style: Theme.of(context)
                .textTheme
                .bodyText2
                .copyWith(color: Colors.black87),
          ),
          leading: Radio(
            value: PaymentMethod.COD,
            groupValue: _method,
            onChanged: (PaymentMethod value) {
              setState(() {
                _method = value;
              });
            },
          ),
        ),
        isActive: _currentStep >= 0,
      ),
    ];
    return _steps;
  }

  @override
  Widget build(BuildContext context) {
    void _submitDetails() async {
      final FormState formState = _formKey2.currentState;

      void showSnackBarMessage(String message,
          [MaterialColor color = Colors.red]) {
        _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text(message)));
      }

      if (!formState.validate()) {
        showSnackBarMessage('Please enter correct data');
      } else {
        formState.save();
        await CheckoutService().checkOut(finalId).whenComplete(() {
          Navigator.pushAndRemoveUntil(context,
              MaterialPageRoute(builder: (context) => Success()), (_) => false);
        });
      }
    }

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(
          "Checkout",
          style: Theme.of(context)
              .textTheme
              .headline6
              .copyWith(color: Theme.of(context).accentColor),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                    builder: (context) => Cart(
                          userId: finalId,
                        )),
                (_) => false);
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
      ),
      body: Container(
        child: Form(
          key: _formKey,
          child: ListView(children: [
            Stepper(
              controlsBuilder:
                  // ignore: missing_return
                  (BuildContext context,
                      {VoidCallback onStepContinue,
                      VoidCallback onStepCancel}) {
                if (this._currentStep < this._mySteps().length - 1)
                  return Row(
                    children: <Widget>[
                      RaisedButton(
                        elevation: 0,
                        color: Theme.of(context).primaryColor,
                        onPressed: onStepContinue,
                        child: Text(
                          'NEXT',
                          style: Theme.of(context).textTheme.bodyText2.copyWith(
                              letterSpacing: 1.2,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      TextButton(
                        onPressed: onStepCancel,
                        child: const Text('CANCEL'),
                      ),
                    ],
                  );
                else
                  return Row(
                    children: [
                      Container(
                        child: null,
                      ),
                      Container(
                        child: null,
                      )
                    ],
                  );
              },
              steps: _mySteps(),
              currentStep: this._currentStep,
              onStepTapped: (step) {
                setState(() {
                  this._currentStep = step;
                });
              },
              onStepContinue: () {
                setState(() {
                  if (_formKey2.currentState.validate()) {
                    if (this._currentStep < this._mySteps().length - 1) {
                      this._currentStep = this._currentStep + 1;
                    } else {}
                  }
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
          ]),
        ),
      ),
      bottomSheet: Container(
        color: Color(0Xfff2f2f2),
        width: double.infinity,
        height: 50,
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        child: FlatButton(
          child: Text(
            'CONFIRM ORDER',
            style: Theme.of(context).textTheme.button,
          ),
          onPressed: _submitDetails,
          color: Theme.of(context).buttonColor,
        ),
      ),
    );
  }
}
