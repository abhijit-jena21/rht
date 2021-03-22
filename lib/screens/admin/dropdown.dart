import 'package:flutter/material.dart';
//import 'dart:io';

class DropDown extends StatefulWidget {
  final void Function(String) notifyParent;
  DropDown({this.notifyParent});
  @override
  createState() => _DropDownState();
}

class _DropDownState extends State<DropDown> {
  Map<String, String> _subcategoryList = {};

  final List<String> _categoryList = [
    "Appliances",
    "Electronics",
    "Furniture",
    "Fitness",
    "Space Saver",
    "Kitchen"
  ];
  final _appliances = {
    "TV": "603cc4bfba5cf916fc193c79",
    "Washing Machine": "603cc513ba5cf916fc193c7a",
    "Refrigerator": "603cc56aba5cf916fc193c7c",
    "AC": "603cc5b7ba5cf916fc193c7d"
  };
  final _electronics = {
    "Console": "603cc66274b118cbd7c8c4e7",
    "Printer": "603cc69a74b118cbd7c8c4e8",
    "Camera": "603cc6ad74b118cbd7c8c4e9",
    "Monitor": "603cc6ba74b118cbd7c8c4ea"
  };
  final _furniture = {
    "Bed": "603cc69395ca98caec8d12bb",
    "Sofa": "603cc6f8d525bf1c04b4b470",
    "Mattress": "603cc86bd525bf1c04b4b474",
    "Wardrobe": "603cc896d525bf1c04b4b475",
    "Dressing Table": "603cc964d525bf1c04b4b476",
    "Chair": "603cc76ad525bf1c04b4b471",
    "Table": "603cc7f7d525bf1c04b4b472",
  };
  final _fitness = {
    "Gym Essentials": "603cc7c9bafedb7aabe4c785",
    "Treadmill": "603cc812bafedb7aabe4c787",
    "Exercise Bike": "603cc77dbafedb7aabe4c784",
    "Fitness Bench": "603cc7f2bafedb7aabe4c786",
  };
  final _spacesaver = {
    "Bean Bag": "603cc73d74b118cbd7c8c4ed",
    "Collapsible Wardrobe": "603cc71474b118cbd7c8c4ec",
    "Cabinet": "603cc6f874b118cbd7c8c4eb",
    "Bookshelf": "603cc75374b118cbd7c8c4ee",
  };
  final _kitchen = {
    "Gas Stove": "603cc862bafedb7aabe4c78a",
    "Kitchen Rack": "603cc891bafedb7aabe4c78c",
    "Microwave": "603cc87abafedb7aabe4c78b",
  };
  // List provincesList = List();
  List tempList = List();
  String _selectedCategory;
  String _selectedSubcategory;

  // Future<String> loadStatesProvincesFromFile() async {
  //   return await rootBundle.loadString('json/states.json');
  // }

  // Future<String> _populateDropdown() async {
  //   String getPlaces = await loadStatesProvincesFromFile();
  //   final jsonResponse = json.decode(getPlaces);

  //   Localization places = new Localization.fromJson(jsonResponse);

  //   setState(() {
  //     statesList = places.states;
  //     provincesList = places.provinces;
  //   });
  // }

  @override
  void initState() {
    super.initState();
    // this._populateDropdown();
  }

  Widget build(BuildContext context) {
    // TODO: implement build

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Flexible(
          fit: FlexFit.loose,
          child: DropdownButton<String>(
            style: Theme.of(context)
                .textTheme
                .bodyText1
                .copyWith(color: Colors.black87),
            hint: Text('Category'),
            value: _selectedCategory,
            isExpanded: true,
            items: _categoryList.map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            onChanged: (category) {
              if (category == 'Appliances') {
                _subcategoryList = _appliances;
              } else if (category == 'Electronics') {
                _subcategoryList = _electronics;
              } else if (category == 'Furniture') {
                _subcategoryList = _furniture;
              } else if (category == 'Fitness') {
                _subcategoryList = _fitness;
              } else if (category == 'Space Saver') {
                _subcategoryList = _spacesaver;
              } else if (category == 'Kitchen') {
                _subcategoryList = _kitchen;
              }
              setState(() {
                _selectedSubcategory = null;
                _selectedCategory = category;
              });
            },
          ),
        ),
        // Country Dropdown Ends here
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.1,
        ),
        // Province Dropdown
        Flexible(
          fit: FlexFit.loose,
          child: DropdownButton<String>(
            style: Theme.of(context)
                .textTheme
                .bodyText1
                .copyWith(color: Colors.black87),
            hint: Text('Subcategory'),
            value: _selectedSubcategory,
            isExpanded: true,
            items: _subcategoryList.keys.toList().map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            onChanged: (subcategory) {
              setState(() {
                _selectedSubcategory = subcategory;
                widget.notifyParent(_subcategoryList[subcategory]);
              });
            },
          ),
        ),
      ],
    );
  }
}
