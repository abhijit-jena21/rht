// import 'package:flutter/material.dart';
// import './detailsform.dart';
// import 'editdetailsform.dart';

// class EditProduct extends StatefulWidget {
//   // final void Function(int, int, String) onButtonTapped;
//   // EditProduct(this.onButtonTapped);
//   @override
//   _EditProductState createState() => _EditProductState();
// }

// class _EditProductState extends State<EditProduct> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: Text(
//             "Edit Product Details",
//             style: Theme.of(context)
//                 .textTheme
//                 .bodyText1
//                 .copyWith(color: Theme.of(context).accentColor),
//           ),
//           leading: Icon(
//             Icons.arrow_back,
//             color: Colors.black,
//           ),
//           centerTitle: true,
//           backgroundColor: Colors.transparent,
//           shadowColor: Colors.transparent,
//         ),
//         body: SingleChildScrollView(
//           child: EditDetailsForm(),
//         ));
//   }
// }