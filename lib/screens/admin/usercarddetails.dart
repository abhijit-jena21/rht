import 'package:flutter/material.dart';
import 'package:rht/models/currentorders.dart';
// ignore: unused_import
import 'package:rht/models/intransitorders.dart';

import '../../widgets/admin/currentordercard.dart';

class UserCardDetails extends StatefulWidget {
  final CurrentOrders snapshot;
  UserCardDetails(this.snapshot);
  @override
  _UserCardDetailsState createState() => _UserCardDetailsState();
}

class _UserCardDetailsState extends State<UserCardDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shadowColor: Colors.transparent,
        foregroundColor: Colors.transparent,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black87,),
          onPressed: ()=> Navigator.pop(context),),),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(10),
        scrollDirection: Axis.vertical,
        physics: ScrollPhysics(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: 5),
                                  // width: MediaQuery.of(context).size.width * 0.55,
                                  child: Text(
                                    "${widget.snapshot.name}",
                                    // maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline3
                                        .copyWith(
                                            color:
                                                Theme.of(context).accentColor,
                                            // fontWeight: FontWeight.bold,
                                            fontSize: 16),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  
                                  children: [
                                    Container(
                                      padding: EdgeInsets.symmetric(horizontal: 5),
                                      child: Text("Address:",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText2
                                              .copyWith(color: Colors.black54)),
                                    ),
                                    Container(
                                      child: Text(" ${widget.snapshot.address}",
                                          overflow: TextOverflow.ellipsis,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText2
                                              .copyWith(
                                                // fontWeight: FontWeight.w800,
                                                color: Colors.black87,
                                              )),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  children: [
                                    Container(
                                      padding: EdgeInsets.symmetric(horizontal: 5),
                                      child: Text("Phone:",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText2
                                              .copyWith(color: Colors.black54)),
                                    ),
                                    Container(
                                      child: Text(" ${widget.snapshot.phone}",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText2
                                              .copyWith(
                                                  // fontWeight: FontWeight.w800,
                                                  color: Colors.black87)),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 10,),
                    ListView.builder(
                      // scrollDirection: Axis.vertical,
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
            itemCount: widget.snapshot.currentorder.length,
            itemBuilder: (BuildContext context, int index) {
                    print("listview" + index.toString());
                    return CurrentOrderCard(
                      index,
                      widget.snapshot.sId,
                      widget.snapshot.currentorder[index],
                    );
            }),
                  ],
                ),
              
      ),
    );
  }
}
