import 'package:flutter/material.dart';
import '../../widgets/admin/detailsform.dart';

class AddProduct extends StatefulWidget {
  final void Function(int, int, String) onButtonTapped;
  AddProduct(this.onButtonTapped);
  @override
  _AddProductState createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
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
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            color: Colors.black,
            onPressed: ()=>Navigator.pop(context),
          ),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
        ),
        body: SingleChildScrollView(
          child: DetailsForm(widget.onButtonTapped),
        ));
  }
}
