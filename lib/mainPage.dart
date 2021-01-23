import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import "package:flutter/material.dart";
import "package:google_fonts/google_fonts.dart";
import 'package:reale/Inbox.dart';
import 'package:reale/Menu.dart';
import 'package:reale/addListing.dart';
import 'package:reale/profile.dart';
import 'package:reale/updates.dart';
import 'package:scaffold_tab_bar/scaffold_tab_bar.dart';


User currentUser;
var currentItem=0;



class mainPage extends StatefulWidget {
  @override
  _mainPageState createState() => _mainPageState();
}

class _mainPageState extends State<mainPage> {
  FirebaseAuth auth= FirebaseAuth.instance;

  setUserOneTime()async{
    FirebaseAuth _auth= FirebaseAuth.instance;
    var tempUser= await _auth.currentUser;
    setState(() {
      currentUser= tempUser;
    });

    // if(tempUser.displayName==null){
    //   Navigator.pushReplacement(context, MaterialPageRoute(
    //       builder: (context){
    //         return  completeProfile();
    //       }
    //   ));
    // }

  }

  @override
  void initState() {

    setUserOneTime();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {


    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection("users").doc("${auth.currentUser.uid}").snapshots(),
      builder: (context, snapshot) {




        if(snapshot.hasData){
          var document= snapshot.data;
          var userData=document.data();
          bool isApproved=userData["approved"];

          if(isApproved==true){
            return DefaultTabController(
              initialIndex: 0,
              length: 3,
              child: Scaffold(
                backgroundColor: Colors.white,
                drawer: Drawer(
                  child: Scaffold(
                    body: Center(
                        child: profile()
                    ),
                  ),
                ),
                extendBodyBehindAppBar: false,
                appBar: AppBar(
                  toolbarHeight: 80,
                  backgroundColor: Colors.green,
                  bottom: TabBar(
                    indicatorColor: Colors.pinkAccent,
                    tabs: <Widget>[
                      Tab(
                        child: Container(
                            child: Text(
                              'Chats',
                                style: TextStyle(
                                    fontFamily: "Times New Roman",
                                    fontWeight: FontWeight.w700,
                                    color: Colors.black,
                                    fontSize: 16
                                )
                            )
                        ),
                      ),
                      Tab(
                        child: Text(
                          'Updates',
                            style: TextStyle(
                                fontFamily: "Times New Roman",
                                fontWeight: FontWeight.w700,
                                color: Colors.black,
                                fontSize: 16
                            )
                        ),
                      ),
                      Tab(
                        child: Text(
                          'Menu',
                            style: TextStyle(
                                fontFamily: "Times New Roman",
                                fontWeight: FontWeight.w700,
                                color: Colors.black,
                                fontSize: 16
                            )
                        ),
                      ),

                    ],
                  ),
                ),
                body: TabBarView(
                  children: <Widget>[
                    inbox(),
                    updates(),
                    Menu(),
                  ],
                ),
              ),
            );
          }
          else{
            return DefaultTabController(
              initialIndex: 0,
              length: 3,
              child: Scaffold(
                drawer: Drawer(
                  child: Scaffold(
                    body: Center(
                        child: profile()
                    ),
                  ),
                ),
                extendBodyBehindAppBar: false,
                appBar: AppBar(
                  toolbarHeight: 80,
                  backgroundColor: Colors.green,
                  bottom: TabBar(
                    tabs: <Widget>[
                      Tab(
                        child: Text(
                            'Chats',
                            style: TextStyle(
                                fontFamily: "Times New Roman",
                                fontWeight: FontWeight.w700,
                                color: Colors.black,
                                fontSize: 16
                            )
                        )),
                      Tab(
                        child: Text(
                          'Updates',
                            style: TextStyle(
                                fontFamily: "Times New Roman",
                                fontWeight: FontWeight.w700,
                                color: Colors.black,
                                fontSize: 16
                            )
                        ),
                      ),
                      Tab(
                        child: Text(
                            'Menu',
                            style: TextStyle(
                                fontFamily: "Times New Roman",
                                fontWeight: FontWeight.w700,
                                color: Colors.black,
                                fontSize: 16
                            )
                        ),
                      ),

                    ],
                  ),
                ),
                body: TabBarView(
                  children: <Widget>[
                    inbox(),
                    Scaffold(
                      body: Center(
                        child: Text(
                          "YOU ARE NOT APPROVED",
                            style: TextStyle(
                                fontFamily: "Times New Roman",
                                fontWeight: FontWeight.w700,
                                color: Colors.black,
                                fontSize: 16
                            )
                        ),
                      ),
                    ),
                    Scaffold(
                      body: Center(
                        child: Text(
                            "YOU ARE NOT APPROVED",
                            style: TextStyle(
                                fontFamily: "Times New Roman",
                                fontWeight: FontWeight.w700,
                                color: Colors.black,
                                fontSize: 16
                            )
                        ),
                      ),
                    )
                  ],
                ),
              ),
            );
          }

        }
        else{
          return Text("LOADING");
        }
      }
    );

  }
}
