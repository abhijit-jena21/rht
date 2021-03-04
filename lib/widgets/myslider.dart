import 'package:flutter/material.dart';

import '../utils/sliderutil.dart';

// ignore: must_be_immutable
class MySlider extends StatefulWidget {
  final int rent;
  int calculatedRent;
  MySlider(this.rent);
  @override
  _MySliderState createState() => _MySliderState();
}

class _MySliderState extends State<MySlider> {
  
  var indexTop = 0;
  int calculatedRent=300;
  @override
  Widget build(BuildContext context) {
    final labels = ['3+', '6+', '12+', '24+'];
    final double min = 0;
    final double max = labels.length - 1.0;
    final divisions = labels.length - 1;

    Widget buildLabel({
      String label,
      // double width,
      // Color color,
    }) =>
        Container(
          margin: EdgeInsets.symmetric(horizontal: 20),
          // width: width,
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headline3,
          ),
        );

    return Column(
      children: [
        Container(
          // margin: EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: SliderUtil.modelBuilder(
                // ignore: missing_return
                labels, (index, label) {
              // final isSelected = index <= indexTop;
              return buildLabel(label: label);
            }),
          ),
        ),
        Slider(
            value: indexTop.toDouble(),
            min: min,
            max: max,
            divisions: divisions,
            activeColor: Theme.of(context).accentColor,
            inactiveColor: Theme.of(context).primaryColor,
            onChanged: (newRent) {
              print(newRent);
              setState(
                () {
                  this.indexTop = newRent.toInt();

                  if (indexTop == 0) {
                    widget.calculatedRent = 500;
                  } else if (indexTop == 1) {
                    widget.calculatedRent = 400;
                  } else if (indexTop == 2) {
                    widget.calculatedRent = 350;
                  }
                },
              );
            } // label: labels[indexTop],
            ),
      ],
    );
  }
}
