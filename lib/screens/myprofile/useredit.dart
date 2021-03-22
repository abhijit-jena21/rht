import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rht/services/authservice.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../splash_screen.dart';

class Res {
  String error;
  String result;

  Res({this.error, this.result});

  factory Res.fromJson(Map<String, dynamic> json) {
    return Res(error: json['error'], result: json['result']);
  }
}

class CreatProfile extends StatefulWidget {
  CreatProfile({Key key}) : super(key: key);

  @override
  _CreatProfileState createState() => _CreatProfileState();
}

class _CreatProfileState extends State<CreatProfile> {
  bool circular = false;
  PickedFile _imageFile;
  String _name;
  String _address;
  String _email;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final ImagePicker _picker = ImagePicker();

  void formSubmit() async {
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      // print(_phno);
      await AuthService()
          .useredit(
        finalId,
        _name,
        _address,
        _email,
      )
          .then(
        (val) async {
          print(val);
          final Map parsed = json.decode(val.toString());
          final res = Res.fromJson(parsed);
          print(res.result);

          if (res.result == 'Details successfully updated!') {
            // myNavigator = MyNavigator(_phno, _from);
            final SharedPreferences sharedPreferences =
                await SharedPreferences.getInstance();
            setState(() {
              sharedPreferences.setString('address', _address);
              finalAddress = _address;
              sharedPreferences.setString('name', _name);
              finalName = _name;
              sharedPreferences.setString('email', _email);
              finalEmail = _email;
            });

            Navigator.pushNamedAndRemoveUntil(
                context, '/profile', (_) => false);
          }
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Theme.of(context).primaryColor,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Container(
            child: Center(child: Icon(Icons.arrow_back_rounded)),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              border: Border.all(
                color: Theme.of(context).accentColor,
              ),
            ),
          ),
        ),
        centerTitle: true,
        title: Text(
          'Edit Profile',
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          children: <Widget>[
            /* imageProfile(),
            SizedBox(
              height: 20,
            ),*/
            nameTextField(),
            SizedBox(
              height: 20,
            ),
            addressTextField(),
            SizedBox(
              height: 20,
            ),
            emailField(),
            SizedBox(
              height: 20,
            ),
            InkWell(
              onTap: () {
                formSubmit();
              },
              child: Center(
                child: Container(
                  width: 200,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Theme.of(context).accentColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: circular
                        ? CircularProgressIndicator()
                        : Text(
                            "Submit",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /*Widget imageProfile() {
    return Center(
      child: Stack(children: <Widget>[
        CircleAvatar(
          radius: 80.0,
          backgroundImage: _imageFile == null
              ? AssetImage("assets/images/img.png")
              : FileImage(File(_imageFile.path)),
        ),
        Positioned(
          bottom: 10.0,
          right: 10.0,
          child: InkWell(
            onTap: () {
              showModalBottomSheet(
                context: context,
                builder: ((builder) => bottomSheet()),
              );
            },
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.grey.shade200),
                padding: EdgeInsets.all(5),
              child: Icon(
                Icons.camera_alt,
                color: Colors.black,
                size: 28.0,
              ),
            ),
          ),
        ),
      ]),
    );
  }

  Widget bottomSheet() {
    return Container(
      height: 100.0,
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20,
      ),
      child: Column(
        children: <Widget>[
          Text(
            "Choose Profile photo",
            style: TextStyle(
              fontSize: 20.0,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
            FlatButton.icon(
              icon: Icon(Icons.camera),
              onPressed: () {
               takePhoto(ImageSource.camera);
              },
              label: Text("Camera"),
            ),
            FlatButton.icon(
              icon: Icon(Icons.image),
              onPressed: () {
                takePhoto(ImageSource.gallery);
              },
              label: Text("Gallery"),
            ),
          ])
        ],
      ),
    );
  }

  void takePhoto(ImageSource source) async {
    final pickedFile = await _picker.getImage(
      source: source,
    );
    setState(() {
      _imageFile = pickedFile;
    });
  }
*/
  Widget nameTextField() {
    return TextFormField(
      // controller: _name,
      initialValue: finalName,
      style:
          Theme.of(context).textTheme.bodyText1.copyWith(color: Colors.black87),
      validator: (value) {
        if (value.isEmpty) return "Name can't be empty";

        return null;
      },
      decoration: InputDecoration(
        border: OutlineInputBorder(
            borderSide: BorderSide(
          color: Colors.black26,
        )),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
          color: Colors.blue,
          width: 2,
        )),
        prefixIcon: Icon(
          Icons.person,
          color: Theme.of(context).accentColor,
        ),
        labelText: "Name",
        // helperText: "Name can't be empty",
        // hintText: "Enter your name",
      ),
      onSaved: (value) {
        _name = value;
      },
    );
  }

  Widget addressTextField() {
    return TextFormField(
      //controller: _profession,
      initialValue: finalAddress,
      style:
          Theme.of(context).textTheme.bodyText1.copyWith(color: Colors.black87),
      validator: (value) {
        if (value.isEmpty) return "Address can't be empty";

        return null;
      },
      decoration: InputDecoration(
        border: OutlineInputBorder(
            borderSide: BorderSide(
          color: Colors.black26,
        )),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
          color: Colors.blue,
          width: 2,
        )),
        prefixIcon: Icon(
          Icons.house,
          color: Theme.of(context).accentColor,
        ),
        labelText: "Address",
        // helperText: "Address can't be empty",
        // hintText: "Enter your house Address",
      ),
      onSaved: (value) {
        _address = value;
      },
    );
  }

  Widget emailField() {
    return TextFormField(
      //controller: _dob,
      initialValue: finalEmail,
      style:
          Theme.of(context).textTheme.bodyText1.copyWith(color: Colors.black87),
      validator: (value) {
        if (value.isEmpty) return "Email can't be empty";

        return null;
      },
      decoration: InputDecoration(
        border: OutlineInputBorder(
            borderSide: BorderSide(
          color: Colors.black26,
        )),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
          color: Colors.blue,
          width: 2,
        )),
        prefixIcon: Icon(
          Icons.mail,
          color: Theme.of(context).accentColor,
        ),
        labelText: "Email",
        // helperText: "Provide DOB on dd/mm/yyyy",
        // hintText: "01/01/2020",
      ),
      onSaved: (value) {
        _email = value;
      },
    );
  }

}
