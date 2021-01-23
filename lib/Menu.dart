import "package:flutter/material.dart";
import 'package:google_fonts/google_fonts.dart';
import 'package:reale/about.dart';
import 'package:reale/policy.dart';
import 'package:reale/propertyManagement.dart';

class Menu extends StatefulWidget {
  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                RaisedButton(
                  padding: EdgeInsets.all(20),
                  elevation: 5,
                  color: Colors.pinkAccent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    side: BorderSide(color: Colors.black)
                        ),
                    onPressed: ()
                    {
                    Navigator.push(context,MaterialPageRoute(builder:(context)
                      {
                        return propertyManagement();
                      }));
                    },
                  child: Text(
                  "Property Management",
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
                          "About",
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
                          "Policies",
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
              ],
            ),
          ),

      ),
    );
  }
}
