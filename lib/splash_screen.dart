import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'main.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SplashScreenState();
  }
}


class SplashScreenState extends State<SplashScreen>{

void initState(){
  super.initState();

Timer(Duration(seconds: 2),(){
Navigator.pushReplacement(context,
MaterialPageRoute(builder: (context)=>homeScreen()));
  });
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Color(0xFFA7B49E),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
      Container(height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
      gradient: LinearGradient(
          colors: [
          Color(0xFF5C7285), // Start color
      Color(0xFFA7B49E), // End color
      ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    ),
    ),
    child:
          Column(mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(child: Icon(Icons.list_alt,size: 170,)),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("ToDo",style: TextStyle(
                    color: Colors.black38,
                    fontSize: 50,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Satisfy-Regular",
                  ),),
                  Container(
                    width: 150,
                    height: 70,
                    decoration: BoxDecoration(
                        color:Color(0xFF5C7285),
                        borderRadius: BorderRadius.circular(50)
                    ),
                    child:
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                        child: Text("List  ",style: TextStyle(
                            fontFamily: "Rockybilly",
                            fontSize: 23,
                            color: Colors.white
                        ),),
                      ),
                    ),)
                ],
              )
            ],
          )),


        ],
      )
    );
  }

}