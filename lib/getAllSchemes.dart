import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import "package:flutter/material.dart";
import 'package:google_fonts/google_fonts.dart';
import 'package:reale/allProperties.dart';
import 'package:reale/newCode/PropertScreens/NonScheme.dart';
import 'package:reale/newCode/PropertScreens/Scheme.dart';

class getAllSchemes extends StatefulWidget {
  final cityId;

  getAllSchemes(this.cityId);

  @override
  _getAllSchemesState createState() => _getAllSchemesState();
}

class _getAllSchemesState extends State<getAllSchemes> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body:    ListView(
       children: [
         Container(
         decoration: BoxDecoration(
             border: Border.all(width: 2)
         ),
         margin: EdgeInsets.only(bottom: 10),
         child: RaisedButton(
           color: Colors.white,
           elevation: 20,
           padding: EdgeInsets.only(top:20,bottom: 20),
           onPressed: (){
             Navigator.push(
                 context,
                 MaterialPageRoute(
                     builder: (context){
                            return Schemes(widget.cityId);
                     }
                 )
             );
           },
           child: Text(
             "Scheme",
             style:GoogleFonts.getFont('Montserrat',color: Colors.black,fontWeight: FontWeight.w400,fontSize: 25),
           ),
         ),
       ),
         Container(
           decoration: BoxDecoration(
               border: Border.all(width: 2)
           ),
           margin: EdgeInsets.only(bottom: 10),
           child: RaisedButton(
             color: Colors.white,
             elevation: 20,
             padding: EdgeInsets.only(top:20,bottom: 20),
             onPressed: (){
               Navigator.push(
                   context,
                   MaterialPageRoute(
                       builder: (context){
                              return NonSchemes(widget.cityId);
                       }
                   )
               );
             },
             child: Text(
               "Non Scheme",
               style:GoogleFonts.getFont('Montserrat',color: Colors.black,fontWeight: FontWeight.w400,fontSize: 25),
             ),
           ),
         )

       ],
      ),
      ),
    );
  }
}
