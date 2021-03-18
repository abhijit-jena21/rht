import 'package:flutter/material.dart';
import './detailsform.dart';

class AddProduct extends StatefulWidget {
  @override
  _AddProductState createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  int _currentStep = 0;
  List<Step> _mySteps() {
    List<Step> _steps = [
      Step(
        title: Text(
          "Add Product Details",
          style: Theme.of(context)
              .textTheme
              .headline3
              .copyWith(fontWeight: FontWeight.bold),
        ),
        content: DetailsForm(),
        isActive: _currentStep >= 0,
      ),
      Step(
        title: Text(
          "Add Images",
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
          "Add Product",
          style: Theme.of(context)
              .textTheme
              .bodyText1
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
