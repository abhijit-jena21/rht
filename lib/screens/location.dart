import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:rht/screens/landingpage/landingpage.dart';
// import 'package:rht/screens/landingpage/locationpicker.dart';
import 'package:rht/screens/starter.dart';

class Location extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Container myItems(AssetImage assetImage, String title, String locationId) {
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
                  title,
                  style: Theme.of(context).textTheme.headline4,
                )
              ],
            ),
          ),
          onTap: () async {
            final SharedPreferences sharedPreferences =
                await SharedPreferences.getInstance();
                sharedPreferences.setString('locationId', locationId);
                sharedPreferences.setString('location', title);
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        Starter(title: title, locationId: locationId)),
                (_) => false);
          },
        ),
        // color: Colors.white,
        // elevation: 2.0,
        // shadowColor: Theme.of(context).primaryColor,
        // borderRadius: BorderRadius.circular(15.0),
        // child: InkWell(
        //   onTap: () {
        //     // setState(() {
        //     //   tabIndex = ind;
        //     // });
        //     Navigator.push(
        //       context,
        //       MaterialPageRoute(
        //         // builder: (context) => Products(
        //         //           index: tabIndex,
        //         //         )
        //                 ));
        //     // print(":" + tabIndex.toString());
        //     // print(ind);

        //   },
        //   child: Center(
        //     child: Padding(
        //       padding: EdgeInsets.all(8.0),
        //       child: Row(
        //         mainAxisAlignment: MainAxisAlignment.center,
        //         children: [
        //           Column(
        //             mainAxisAlignment: MainAxisAlignment.center,
        //             children: [
        //               image,
        //               Container(
        //                 padding:
        //                     EdgeInsets.symmetric(vertical: 10, horizontal: 5),
        //                 child: Text(title,
        //                     style: Theme.of(context).textTheme.bodyText1),
        //               )
        //             ],
        //           )
        //         ],
        //       ),
        //     ),
        //   ),
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
