import 'package:flutter/material.dart';

class Success extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text("Thanks for shopping with RHT",
            style: Theme.of(context)
                .textTheme
                .bodyText1
                .copyWith(color: Colors.black87)),
      ],
    ));
  }
}
