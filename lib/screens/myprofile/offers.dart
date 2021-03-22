/*import 'package:flutter/material.dart';


class OffersScreen extends StatelessWidget {
  

  @override
  Widget build(BuildContext context) {
   double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar:AppBar(
        centerTitle: true,
        title:Text("Offers & Promotions")
      , 
        leading:IconButton(icon: Icon(Icons.arrow_back_ios_rounded),
        onPressed: () {Navigator.of(context).pop();
                        },),
      
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        
        child: Container(
          width:width,
          height:height,
          child: Column(
            mainAxisAlignment:MainAxisAlignment.center ,
            crossAxisAlignment: CrossAxisAlignment.center,
             children: <Widget>[
              Image.asset('assets/images/stock.png',width: width*7,height: height*.4,),
              Text('Whoops!',style: TextStyle(color:Colors.black45,fontSize: 30,fontWeight: FontWeight.w500)),
              Text('Seems Like there is no Offer available current. \n Please check later..',
              style:TextStyle(fontSize: 13, color:Colors.black45,fontWeight:FontWeight.w400),
              textAlign: TextAlign.center,),
              
             ],)

        ) 
          ),
    );}}*/