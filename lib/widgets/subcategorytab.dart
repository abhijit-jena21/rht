import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class SubCategoryTab extends StatelessWidget {
  final String img;
  final String name;
  SubCategoryTab(this.img, this.name);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.zero,
      // constraints: BoxConstraints.,
      height: 90,
      width: 100.0,
      child: Tab(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                child: Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: Container(
                    width: 60,
                    height: 40,
                    decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        image: DecorationImage(
                          scale: 0.6,
                          image: CachedNetworkImageProvider(img),
                          // fit: BoxFit.scaleDown)
                        )),
                  ),
                ),
              ),
              SizedBox(
                height: 8,
              ),
              SizedBox(
                width: 100,
                child: Center(
                  child: Text(
                    name,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontFamily: "Montserrat",
                        // color: Colors.black,
                        fontSize: 12),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
