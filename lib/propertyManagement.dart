import "package:flutter/material.dart";
import 'package:google_fonts/google_fonts.dart';
import 'package:reale/Entries.dart';
import 'package:reale/about.dart';
import 'package:reale/dealers.dart';
import 'package:reale/help.dart';
import 'package:reale/policy.dart';
import 'package:reale/reports.dart';
import 'package:reale/sold.dart';
import 'package:reale/addListing.dart';

class propertyManagement extends StatefulWidget {
  @override
  _propertyManagementState createState() => _propertyManagementState();
}

class _propertyManagementState extends State<propertyManagement> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  RaisedButton(
                      padding: EdgeInsets.all(20),
                      elevation: 5,
                    color: Colors.pinkAccent,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          side: BorderSide(color: Colors.black)
                      ),
                    onPressed: (){
                      Navigator.push(context,MaterialPageRoute(builder:(context){
                        return  addListing();/*Entries();*/
                      }));
                    },
                      child: Text(
                          "ENTRIES",
                          style: TextStyle(
                              fontFamily: "Times New Roman",
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                              fontSize: 20
                          )
                      )
                  ),
                  RaisedButton(
                      padding: EdgeInsets.all(20),
                      elevation: 5,
                      color: Colors.pinkAccent,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          side: BorderSide(color: Colors.black)
                      ),
                      onPressed: (){
                        Navigator.push(context,MaterialPageRoute(builder:(context){
                          return reports();
                        }));
                      },
                      child: Text(
                        "REPORTS",
                          style: TextStyle(
                              fontFamily: "Times New Roman",
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                              fontSize: 20
                          )
                      )
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  RaisedButton(
                      padding: EdgeInsets.all(20),
                      elevation: 5,
                      color: Colors.pinkAccent,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          side: BorderSide(color: Colors.black)
                      ),
                      onPressed: (){
                        Navigator.push(context,MaterialPageRoute(builder:(context){
                          return help();
                        }));
                      },
                      child: Text(
                        "HELP",
                          style: TextStyle(
                              fontFamily: "Times New Roman",
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                              fontSize: 20
                          )
                      )
                  ),
                  RaisedButton(
                      padding: EdgeInsets.all(20),
                      elevation: 5,
                      color: Colors.pinkAccent,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          side: BorderSide(color: Colors.black)
                      ),
                      onPressed: (){
                        Navigator.push(context,MaterialPageRoute(builder:(context){
                          return dealers();
                        }));
                      },
                      child: Text(
                        "DEALERS",
                          style: TextStyle(
                              fontFamily: "Times New Roman",
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                              fontSize: 20
                          )
                      )
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  RaisedButton(
                      padding: EdgeInsets.all(20),
                      elevation: 5,
                      color: Colors.pinkAccent,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          side: BorderSide(color: Colors.black)
                      ),
                      onPressed: (){
                        Navigator.push(context,MaterialPageRoute(builder:(context){
                          return about();
                        }));
                      },
                      child: Text(
                        "ABOUT PM",
                          style: TextStyle(
                              fontFamily: "Times New Roman",
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                              fontSize: 20
                          )
                      )
                  ),
                  RaisedButton(
                      padding: EdgeInsets.all(20),
                      elevation: 5,
                      color: Colors.pinkAccent,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          side: BorderSide(color: Colors.black)
                      ),
                      onPressed: (){
                        Navigator.push(context,MaterialPageRoute(builder:(context){
                          return policy();
                        }));
                      },
                      child: Text(
                        "POLICIES",
                          style: TextStyle(
                              fontFamily: "Times New Roman",
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                              fontSize: 20
                          )
                      )
                  ),
                ],
              ),
              RaisedButton(
                  padding: EdgeInsets.all(20),
                  elevation: 5,
                  color: Colors.pinkAccent,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      side: BorderSide(color: Colors.black)
                  ),
                  onPressed: (){
                    Navigator.push(context,MaterialPageRoute(builder:(context){
                      return sold();
                    }));
                  },
                  child: Text(
                    "SOLD/UNSOLD",
                      style: TextStyle(
                          fontFamily: "Times New Roman",
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                          fontSize: 20
                      )
                  )
              ),
            ],
          ),
        ),
      ),
    );
  }
}
