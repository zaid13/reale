import 'dart:async';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'file:///C:/Users/Zaid/Desktop/reale/lib/Auth/login.dart';
import 'package:reale/mainPage.dart';

import 'dart:io';
import 'package:flutter/material.dart';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


void main() {
  runApp(MaterialApp(home: MyApp()));
}


class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void initState() {


  }
  @override
  Widget build(BuildContext context) {

   checkLog()async{
     FirebaseApp defaultApp = await Firebase.initializeApp();

    // FirebaseAuth.instance.setPersistence(Persistence.LOCAL);

     FirebaseAuth auth= FirebaseAuth.instance;


     User user=auth.currentUser;



     if(user!=null){

       Navigator.pushReplacement(
           context,
           MaterialPageRoute(
               builder: (context){
                 return SafeArea(child: Scaffold(body: mainPage()));
               }
           )
       );

     }

     else{
       Navigator.pushReplacement(
           context,
           MaterialPageRoute(
               builder: (context){
                 return SafeArea(child: Scaffold(body: login()));
               }
           )
       );
     }
   }


    Timer(Duration(seconds: 2), (){checkLog();});
    return MaterialApp(
      home:SafeArea(
        child: Scaffold(
          body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                Image(
                  fit: BoxFit.cover,
                    image: AssetImage(
                        'assets/images/pm.png',
                    ),
                ),
                  Container(
                    margin: EdgeInsets.only(right:20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                            "PM App",
                          style: TextStyle(
                            fontFamily: "Times New Roman",
                            fontWeight: FontWeight.w700,
                            fontSize: 25
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              )
          ),
        ),
      )
    );

  }
}
