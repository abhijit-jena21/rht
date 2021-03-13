import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../screens/starter.dart';
import '../screens/splash_screen.dart';
import 'admin/adminstarter.dart';

class Location extends StatelessWidget {
  final String userId;
  Location({this.userId});
  @override
  Widget build(BuildContext context) {
    Container myItems(
        AssetImage assetImage, String location, String locationId) {
      Image image = Image(
        image: assetImage,
        // width: 50.0,
        height: 60.0,
        // color: Theme.of(context).primaryColor,
        fit: BoxFit.cover,
      );
      return Container(
        // height: 20,
        child: InkWell(
          child: Card(
            elevation: 3,
            child: Column(
              children: [
                image,
                SizedBox(
                  height: 10,
                ),
                Text(
                  location,
                  style: Theme.of(context).textTheme.headline4,
                )
              ],
            ),
          ),
          onTap: () async {
            finalAdminLocation = location;
            finalAdminLocationId = locationId;
            final SharedPreferences sharedPreferences =
                await SharedPreferences.getInstance();
            sharedPreferences.setString('locationId', locationId);
            sharedPreferences.setString('location', location);
            sharedPreferences.setString('adminLocationId', locationId);
            sharedPreferences.setString('adminLocation', location);
            if (admin == false)
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Starter(
                            location: location,
                            locationId: locationId,
                            userId: userId,
                          )),
                  (_) => false);
            else
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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Choose your city",
            style: Theme.of(context).textTheme.headline1,
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
              myItems(AssetImage('././assets/images/location/chennai.jpeg'),
                  'Chennai', '6035f85e87e39d26742469fl'),
              myItems(AssetImage('././assets/images/location/hyderabad.jpg'),
                  'Hyderabad', '6035f85e87e39d26742469fa'),
              myItems(AssetImage('././assets/images/location/mumbai.jpg'),
                  'Mumbai', '6035f85e87e39d26742469ff'), //true
              myItems(AssetImage('././assets/images/location/ahmedabad.jpg'),
                  'Ahmedabad', '6035f85e87e39d26742469fc'),
              myItems(AssetImage('././assets/images/location/new delhi.jpg'),
                  'New Delhi', '6035f85e87e39d26742469fz'),
              myItems(AssetImage('././assets/images/location/kolkata.jpg'),
                  'Kolkata', '6035f85e87e39d26742469fd'), //true
              myItems(AssetImage('././assets/images/location/bhubaneswar.jpg'),
                  'Bhubaneswar', '6035f85e87e39d26742469ff'),
              myItems(AssetImage('././assets/images/location/lucknow.jpg'),
                  'Lucknow', '6035f85e87e39d26742469fe'), //true
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
