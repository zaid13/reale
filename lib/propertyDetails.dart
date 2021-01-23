import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:reale/chat.dart';



fetchUserInfo(id)async{
  FirebaseAuth auth=FirebaseAuth.instance;
  var userInfo = await FirebaseFirestore.instance.collection('users').doc("${id}").get();
  return userInfo;
}


class propertyDetails extends StatefulWidget {
  final data;
  propertyDetails(this.data);

  @override
  _propertyDetailsState createState() => _propertyDetailsState();
}

class _propertyDetailsState extends State<propertyDetails> {
  @override
  Widget build(BuildContext context) {
    Timestamp posted=widget.data["time"];
    DateTime time=widget.data["time"].toDate();
    var timeHours=time.hour;
    var timeMinutes=time.minute;
    var timeCode="am";
    if(timeHours>=12)
    {
      timeHours=timeHours-12;
      timeCode="pm";
    }

    var timeFormat= "${time.year}-${time.month}-${time.day} $timeHours:$timeMinutes $timeCode ";


    return SafeArea(
      child: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('users').doc("${widget.data["seller"]}").snapshots(),
        builder: (context, snapshot) {
          DocumentSnapshot doc=snapshot.data;
          var data=doc.data();

          return SafeArea(
            child: Scaffold(
              backgroundColor: widget.data["sold"]=="yes"?Colors.grey:Colors.white,
              body: ListView(
                shrinkWrap: true,
                children: [

                  Row(
                    children: [
                      Text(
                          "  Posted: $timeFormat",
                        style: TextStyle(
                            color: Colors.purple,
                            fontFamily: "Times New Roman",
                            fontWeight: FontWeight.w700,
                            fontSize: 20
                        ),)
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        "  Details:",
                        style: TextStyle(
                            color: Colors.green,
                            fontFamily: "Times New Roman",
                            fontWeight: FontWeight.w700,
                            fontSize: 20
                        ),
                      )
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.only(top:20,bottom: 20),
                    child: Text(
                      "${widget.data["scheme"]}",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.black,
                          fontFamily: "Times New Roman",
                          fontWeight: FontWeight.w700,
                          fontSize: 30
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          RaisedButton(
                            onPressed: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context){
                                return Container(
                                  height: 400,
                                  child: GoogleMap(
                                    mapType: MapType.normal,
                                    markers: Set.from([
                                      Marker(markerId: MarkerId("main"),position: LatLng(
                                          double.parse(widget.data["marker_x"]),
                                          double.parse(widget.data["marker_y"])
                                      ))
                                    ]),
                                    initialCameraPosition:  CameraPosition(
                                        zoom:9,
                                        target: LatLng(
                                            double.parse(widget.data["marker_x"]),
                                            double.parse(widget.data["marker_y"])
                                        ) ),
                                  ),
                                );
                              }));
                            },
                            child: Text(
                                "View Location",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: "Times New Roman",
                                  fontWeight: FontWeight.w700,
                                  fontSize: 20
                              ),                        ),
                          ),
                        ],
                      ),
                      Container(
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: Colors.blueAccent,
                                width: 2
                            )
                        ),
                        child: Column(
                          children: [
                            Text(
                              "Demand:",
                              style: TextStyle(
                                  color: Colors.green,
                                  fontFamily: "Times New Roman",
                                  fontWeight: FontWeight.w700,
                                  fontSize: 20
                              ),                        ),
                            Text(
                              "${widget.data["demand"]}",
                              style: TextStyle(
                                  color: Colors.purple,
                                  fontFamily: "Times New Roman",
                                  fontWeight: FontWeight.w700,
                                  fontSize: 20
                              ),                        ),
                          ],
                        ),
                      ),

                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          Container(
                              padding: EdgeInsets.all(10),
                              color: widget.data["sold"]=="yes"?Colors.grey:Colors.white,
                              child: Column(
                                children: [
                                  Text(
                                    "Sold: ${widget.data["sold"]}",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontFamily: "Times New Roman",
                                        fontWeight: FontWeight.w700,
                                        fontSize: 20
                                    ),
                                  ),
                                  Icon(Icons.person),
                                ],
                              )
                          ),
                        ],
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                              "Posted By:",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                color: Colors.black,
                                fontFamily: "Times New Roman",
                                fontWeight: FontWeight.w700,
                                fontSize: 16
                            ),
                          ),
                          Text(
                            "${data["businessName"]}",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                color: Colors.orangeAccent,
                                fontFamily: "Times New Roman",
                                fontWeight: FontWeight.w700,
                                fontSize: 20
                            ),
                          ),
                          Text(
                            "Owner:",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                color: Colors.black,
                                fontFamily: "Times New Roman",
                                fontWeight: FontWeight.w700,
                                fontSize: 16
                            ),
                          ),
                          Text(
                            "${data["businessOwner"]}",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                color: Colors.blueAccent,
                                fontFamily: "Times New Roman",
                                fontWeight: FontWeight.w700,
                                fontSize: 20
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 10,),
                  Container(
                    margin: EdgeInsets.only(left:20,right:20),
                    child: RaisedButton(
                      shape:RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                          side: BorderSide(color: Colors.white)
                      ),
                      color: Colors.blueAccent,
                      elevation: 10,
                      padding: EdgeInsets.all(15),
                      onPressed: (){
                        Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context){
                              return chatScreen(widget.data["seller"]);
                            })
                        );
                      },
                      child: Text(
                        "Contact:\n ${data["name"]}",
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: "Times New Roman",
                            fontWeight: FontWeight.w700,
                            fontSize: 20
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 40,),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        " Property Type: ${widget.data["type"]}",
                        style: TextStyle(
                            color: Colors.black,
                            fontFamily: "Times New Roman",
                            fontWeight: FontWeight.w700,
                            fontSize: 20
                        ),
                      ),
                      Text(
                        " Listing For: ${widget.data["sale"]}",
                        style: TextStyle(
                            color: Colors.black,
                            fontFamily: "Times New Roman",
                            fontWeight: FontWeight.w700,
                            fontSize: 20
                        ),
                      ),
                      Text(
                        " Province: ${widget.data["province"]}",
                        style: TextStyle(
                            color: Colors.black,
                            fontFamily: "Times New Roman",
                            fontWeight: FontWeight.w700,
                            fontSize: 20
                        ),
                      ),
                      Text(
                        " District: ${widget.data["district"]}",
                        style: TextStyle(
                            color: Colors.black,
                            fontFamily: "Times New Roman",
                            fontWeight: FontWeight.w700,
                            fontSize: 20
                        ),
                      ),
                      Text(
                        " Total Area: ${widget.data["area"]}",
                        style: TextStyle(
                            color: Colors.black,
                            fontFamily: "Times New Roman",
                            fontWeight: FontWeight.w700,
                            fontSize: 20
                        ),
                      ),
                      Text(
                        " Floors: ${widget.data["floors"]}",
                        style: TextStyle(
                            color: Colors.black,
                            fontFamily: "Times New Roman",
                            fontWeight: FontWeight.w700,
                            fontSize: 20
                        ),
                      ),
                      Text(
                        " Rooms: ${widget.data["rooms"]}",
                        style: TextStyle(
                            color: Colors.black,
                            fontFamily: "Times New Roman",
                            fontWeight: FontWeight.w700,
                            fontSize: 20
                        ),
                      ),
                      Text(
                        " Kitchens: ${widget.data["kitchens"]}",
                        style: TextStyle(
                            color: Colors.black,
                            fontFamily: "Times New Roman",
                            fontWeight: FontWeight.w700,
                            fontSize: 20
                        ),
                      ),
                      Text(
                        " Washrooms: ${widget.data["washroom"]}",
                        style: TextStyle(
                            color: Colors.black,
                            fontFamily: "Times New Roman",
                            fontWeight: FontWeight.w700,
                            fontSize: 20
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20,),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Address / Other Details :",
                        style: TextStyle(
                            color: Colors.black,
                            fontFamily: "Times New Roman",
                            fontWeight: FontWeight.w700,
                            fontSize: 20
                        ),
                      ),
                    ],
                  ),
                  //                  "${widget.data["description"]}",
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "${widget.data["description"]}",
                        style: TextStyle(
                            color: Colors.black,
                            fontFamily: "Times New Roman",
                            fontWeight: FontWeight.w400,
                            fontSize: 20
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        }
      ),
    );
  }
}
