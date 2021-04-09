import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../screens/starter.dart';
import '../screens/splash_screen.dart';
import 'admin/adminstarter.dart';

class Location extends StatefulWidget {
  final String userId;
  Location({this.userId});

  @override
  _LocationState createState() => _LocationState();
}

class _LocationState extends State<Location> {
  @override
  Widget build(BuildContext context) {
    Container myItems(
        AssetImage assetImage, String location, String locationId) {
      Image image = Image(
        image: assetImage,
        width: 160.0,
        height: 60.0,
        fit: BoxFit.cover,
      );
      return Container(
        child: InkWell(
          child: Card(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(5)),
                side: BorderSide(
                    width: 0.5, color: Theme.of(context).accentColor)),
            elevation: 0,
            child: Column(
              children: [
                image,
                SizedBox(
                  height: 8,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 5),
                  child: Text(
                    location,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context)
                        .textTheme
                        .subtitle2
                        .copyWith(color: Colors.black54),
                  ),
                )
              ],
            ),
          ),
          onTap: () async {
            setState(() {
              finalAdminLocation = location;
            finalAdminLocationId = locationId;
            finalLocation = location;
            finalLocationId = locationId;
            });
            
            final SharedPreferences sharedPreferences =
                await SharedPreferences.getInstance();
            sharedPreferences.setString('locationId', locationId);
            sharedPreferences.setString('location', location);
            sharedPreferences.setString('adminLocationId', locationId);
            sharedPreferences.setString('adminLocation', location);
            print("finalAdmin" + admin.toString());
            print("LOCATION:" + finalAdminLocation);
            print("lOCATION-" + finalLocation);
            if (admin == false)
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Starter(
                            location: finalLocation,
                            locationId: finalLocationId,
                            userId: widget.userId,
                          )),
                  (_) => false);
            else if (admin == true)
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                      builder: (context) => AdminStarter(
                            adminLocation: finalAdminLocation,
                            adminLocationId: finalAdminLocationId,
                          )),
                  (_) => false);
          },
        ),
      );
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        actions: [
          IconButton(
            icon: Icon(
              Icons.close,
              color:
                  finalLocation == null ? Colors.transparent : Colors.black87,
            ),
            onPressed:
                finalLocation == null ? null : () => Navigator.pop(context),
          )
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Choose your city",
            style: Theme.of(context)
                .textTheme
                .headline5
                .copyWith(color: Theme.of(context).primaryColor),
          ),
          SizedBox(
            height: 20,
          ),
          StaggeredGridView.count(
            shrinkWrap: true,
            crossAxisCount: 3,
            crossAxisSpacing: 12.0,
            mainAxisSpacing: 20.0,
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            children: [
              myItems(AssetImage('././assets/images/location/bangalore.jpg'),
                  'Bangalore', '6035f6e437bb23b5e8310b41'), //true
              myItems(AssetImage('././assets/images/location/chennai.jpg'),
                  'Chennai', '603c993d9771946c30491115'),
              myItems(AssetImage('././assets/images/location/hyderabad.jpg'),
                  'Hyderabad', '603c9c3ea47826b7384d922a'),
              myItems(AssetImage('././assets/images/location/mumbai.jpg'),
                  'Mumbai', '6035f85e87e39d26742469ff'), //true
              myItems(AssetImage('././assets/images/location/ahmedabad.jpg'),
                  'Ahmedabad', '6035f85e87e39d26742469fc'),
              myItems(AssetImage('././assets/images/location/new delhi.jpg'),
                  'New Delhi', '603c9ba17aae8d2028471137'),
              myItems(AssetImage('././assets/images/location/kolkata.jpg'),
                  'Kolkata', '6035f85e87e39d26742469fd'), //true
              myItems(AssetImage('././assets/images/location/bhubaneswar.jpg'),
                  'Bhubaneswar', '603c9ba17aae8d2028471136'),
              myItems(AssetImage('././assets/images/location/shimla.jpg'),
                  'Shimla', '6035f85e87e39d26742469fe'), //true
            ],
            staggeredTiles: [
              StaggeredTile.extent(1, 100.0),
              StaggeredTile.extent(1, 100.0),
              StaggeredTile.extent(1, 100.0),
              StaggeredTile.extent(1, 100.0),
              StaggeredTile.extent(1, 100.0),
              StaggeredTile.extent(1, 100.0),
              StaggeredTile.extent(1, 100.0),
              StaggeredTile.extent(1, 100.0),
              StaggeredTile.extent(1, 100.0),
            ],
          ),
        ],
      ),
    );
  }
}
