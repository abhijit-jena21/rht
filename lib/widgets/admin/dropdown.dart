import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:rht/models/categorylist.dart';
import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../screens/splash_screen.dart';
//import 'dart:io';

class DropDown extends StatefulWidget {
  final void Function(String, String, String, int) notifyParent;
  DropDown({this.notifyParent});
  @override
  createState() => _DropDownState();
}

class _DropDownState extends State<DropDown> {
  Dio dio = new Dio();
  Map<String, String> _subcategoryList = {};
  int tabIndex;
  final List<String> _categoryList = [];
  var result;
 
  // ignore: deprecated_member_use
  List tempList = List();
  String _selectedCategory;
  String _selectedSubcategory;

  category() async {
    var endpointUrl = '$serverLink/api/categorylist';
    try {
      return await dio.get(
        endpointUrl,
      );
    } catch (e) {
      Fluttertoast.showToast(
          msg: 'Something went wrong',
          toastLength: Toast.LENGTH_SHORT,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 15.0);
    }
  }

  Future<List<CategoryList>> _getCategory() async {
    Response response = await category();
    print(response.data);
    print(response.data.runtimeType);
    var str = response.data.toString();
    print(str);
    var parsed = json.decode(str);
    print(parsed.runtimeType);

    if (parsed != null)
      result =
          List<CategoryList>.from(parsed.map((x) => CategoryList.fromJson(x)));
    print(result);
    print(result.length);
    for (var i = 0; i < result.length; i++) {
      print(result[i].category);
      print(result[i].subcategory);
    }

    return result;
  }

  @override
  void initState() {
    super.initState();
    _getCategory().then((List<CategoryList> value) {
      setState(() {
        for (var i = 0; i < value.length; i++)
          _categoryList.add(value[i].category);
      });
    });
  }

  // ignore: missing_return
  String _validate(String value) {
    if (value?.isEmpty ?? true) return 'Required Field.';
  }

  void onCategoryChange(category) {
    setState(() {
      _selectedCategory = category;
      _subcategoryList = {};
      _selectedSubcategory = null;
    });
    _getCategory().then((List<CategoryList> value) {
      setState(() {
        for (var i = 0; i < value.length; i++)
          for (var j = 0; j < value[i].subcategory.length; j++)
            if (value[i].category == category)
              _subcategoryList[value[i].subcategory[j].name] =
                  value[i].subcategory[j].subid;
        print(_subcategoryList);
      });
    });
  }

  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Flexible(
          fit: FlexFit.loose,
          child: DropdownButtonFormField<String>(
            style: Theme.of(context)
                .textTheme
                .bodyText1
                .copyWith(color: Colors.black87),
            hint: Text('Category'),
            value: _selectedCategory,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            isExpanded: true,
            items: _categoryList.map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            onChanged: onCategoryChange,
            validator: _validate,
          ),
        ),
        
        SizedBox(
          height: MediaQuery.of(context).size.width * 0.05,
        ),
        
        Flexible(
          fit: FlexFit.loose,
          child: DropdownButtonFormField<String>(
            style: Theme.of(context)
                .textTheme
                .bodyText1
                .copyWith(color: Colors.black87),
            hint: Text('Subcategory'),
            value: _selectedSubcategory,
            autovalidateMode: AutovalidateMode.onUserInteraction,
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
                print(_selectedCategory);
                print(_selectedSubcategory);
                print(_subcategoryList[subcategory]);
                widget.notifyParent(_subcategoryList[subcategory],
                    _selectedCategory, _selectedSubcategory, tabIndex);
              });
            },
            validator: _validate,
          ),
        ),
      ],
    );
  }
}
