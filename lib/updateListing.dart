import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import "package:flutter/material.dart";
import 'package:flutter_dropdown/flutter_dropdown.dart';
import 'package:geolocator/geolocator.dart';
import "package:google_fonts/google_fonts.dart";
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_place_picker/google_maps_place_picker.dart';
import 'package:google_maps_place_picker/providers/place_provider.dart';
import 'package:reale/addToFeed.dart';
import "dart:async";
import 'package:reale/updateLocation.dart';

var location=LatLng(30,69);
var areaUnit="";
var docId="";
var soldValue="no";
var pattern = new RegExp(r'[a-zA-Z]');


TextEditingController province=TextEditingController();
TextEditingController district=TextEditingController();
TextEditingController scheme=TextEditingController();
TextEditingController area=TextEditingController();
TextEditingController demand=TextEditingController();
TextEditingController rooms=TextEditingController();
TextEditingController washrooms=TextEditingController();
TextEditingController kitchens=TextEditingController();
TextEditingController floors=TextEditingController();
TextEditingController sale=TextEditingController();
TextEditingController description=TextEditingController();



class updateListing extends StatefulWidget {
  final String docId;
  final String type;
  updateListing(this.type,this.docId);

  @override
  _updateListingState createState() => _updateListingState();
}

class _updateListingState extends State<updateListing> {


  initialize()async{
    var docData= await FirebaseFirestore.instance.collection("listings").doc("${widget.docId}").get();
    docId= docData.id;
    var listingData= docData.data();
    print(listingData);

    return listingData;

  }


  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {




    print(location);


    return FutureBuilder(
        future: initialize(),
        builder: (context, oneTimeData) {
          var provinceValue=oneTimeData.data["province"];

          updatedMarkersList[0]= Marker(
              position: LatLng(
                  double.parse(oneTimeData.data["marker_x"]) ,
                  double.parse(oneTimeData.data["marker_y"])
              ),
              markerId: MarkerId("main")
          );

          if(oneTimeData.hasData){
            province.value=TextEditingValue(text: oneTimeData.data["province"]);
            district.value=TextEditingValue(text: oneTimeData.data["district"]);
            area.value=TextEditingValue(
            text: oneTimeData.data["area"].toString().replaceAll(pattern, "")
            );
            demand.value=TextEditingValue(
              text: oneTimeData.data["demand"]
            );
            rooms.value=TextEditingValue(
              text: oneTimeData.data["rooms"]
            );
            washrooms.value=TextEditingValue(
              text: oneTimeData.data["washroom"]
            );
            kitchens.value=TextEditingValue(
                text: oneTimeData.data["kitchens"]
            );
            floors.value=TextEditingValue(
              text: oneTimeData.data["floors"]
            );
            description.value=TextEditingValue(
              text: oneTimeData.data["description"]
            );
            sale.value=TextEditingValue(
              text: oneTimeData.data["sale"]
            );
            areaUnit=oneTimeData.data["areaUnit"];




            return StreamBuilder(
                stream: FirebaseFirestore.instance.collection("info").doc("areaSizes").snapshots(),
                builder: (context, snapshot) {
                  DocumentSnapshot data=snapshot.data;
                  var areaSizes=data.data()["sizes"];

                  return StreamBuilder(
                      stream: FirebaseFirestore.instance.collection("info").doc("districts").snapshots(),
                      builder: (context, snapshot) {
                        DocumentSnapshot data=snapshot.data;


                        return StreamBuilder(
                            stream:  FirebaseFirestore.instance.collection("info").doc("schemes").snapshots(),
                            builder: (context, snapshot) {
                              DocumentSnapshot data=snapshot.data;
                              //var schemes=data.data()[provinceValue]["scheme"];
                              var schemes=[];
                              var districts=[];


                              for( var el in data.data()[provinceValue])
                              {
                                schemes.add(
                                  el["scheme"]
                                );
                                if(districts.contains(el["district"])){}
                                else{
                                  districts.add(el["district"]);
                                }
                              }

                              return SafeArea(
                                child: Scaffold(
                                  body: Center(
                                    child: SingleChildScrollView(
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Container(
                                              width: MediaQuery.of(context).size.width*0.8,
                                              child: Text(
                                                "Property Type: ${widget.type}",
                                                style:GoogleFonts.getFont('Montserrat',fontWeight: FontWeight.w400,fontSize: 15),
                                              )
                                          ),
                                          Container(
                                              width: MediaQuery.of(context).size.width*0.8,
                                              child: DropDown(
                                                initialValue: oneTimeData.data["province"],
                                                hint: Text("Select Province"),
                                                // initialValue: oneTimeData.data["province"],
                                                items: [
                                                  oneTimeData.data["province"]
                                                ],)
                                          ),
                                          Container(
                                            width: MediaQuery.of(context).size.width*0.8,
                                            child: DropDown(
                                              onChanged: (val){
                                                district.value=TextEditingValue(text: val);
                                              },
                                              initialValue: oneTimeData.data["district"],
                                              items: districts,
                                              hint: Text("District"),
                                            ),
                                          ),
                                          Container(
                                            width: MediaQuery.of(context).size.width*0.8,
                                            child: DropDown(
                                              onChanged: (val){
                                                scheme.value=TextEditingValue(text: val);
                                              },
                                              initialValue: oneTimeData.data["scheme"],
                                              items: schemes,
                                              hint: Text("Scheme"),
                                            ),
                                          ),
                                          Container(
                                              width: MediaQuery.of(context).size.width*0.8,
                                              child: RaisedButton(
                                                onPressed: (){
                                                  showDialog(context: context,builder: (context){
                                                    return updateLocation(
                                                        oneTimeData.data["marker_x"],
                                                        oneTimeData.data["marker_y"]
                                                    );
                                                  });
                                                },
                                                child: Text("SELECT LOCATION"),

                                              )
                                          ),

                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Container(
                                                  width: MediaQuery.of(context).size.width*0.3,
                                                  child: TextField(
                                                    controller: area,
                                                    onChanged: (val){
                                                      print(area.value.text);
                                                    },
                                                    style:GoogleFonts.getFont('Montserrat',fontWeight: FontWeight.w400,fontSize: 15),
                                                    decoration: InputDecoration(
                                                      hintText: "Enter Area",
                                                      hintStyle: GoogleFonts.getFont('Montserrat',fontWeight: FontWeight.w400,fontSize: 15),
                                                    ),
                                                  )
                                              ),
                                              Container(
                                                width: MediaQuery.of(context).size.width*0.4,
                                                child: DropDown(
                                                  onChanged: (val){
                                                    setState(() {
                                                      areaUnit=val;
                                                    });
                                                  },
                                                  initialValue: oneTimeData.data["areaUnit"],
                                                  items: areaSizes,
                                                  hint: Text("Select Units"),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Container(
                                              width: MediaQuery.of(context).size.width*0.8,
                                              child: TextField(
                                                controller: demand,
                                                style:GoogleFonts.getFont('Montserrat',fontWeight: FontWeight.w400,fontSize: 15),
                                                decoration: InputDecoration(
                                                  hintText: "Demand",
                                                  hintStyle: GoogleFonts.getFont('Montserrat',fontWeight: FontWeight.w400,fontSize: 15),
                                                ),
                                              )
                                          ),
                                          Container(
                                              width: MediaQuery.of(context).size.width*0.8,
                                              child: TextField(
                                                enabled: widget.type=="PLOT"?false:true,
                                                controller: rooms,
                                                style:GoogleFonts.getFont('Montserrat',fontWeight: FontWeight.w400,fontSize: 15),
                                                decoration: InputDecoration(
                                                  hintText: widget.type=="PLOT"?"Rooms: 0":"No of Rooms",
                                                  hintStyle: GoogleFonts.getFont('Montserrat',fontWeight: FontWeight.w400,fontSize: 15),
                                                ),
                                              )
                                          ),
                                          Container(
                                              width: MediaQuery.of(context).size.width*0.8,
                                              child: TextField(
                                                enabled: widget.type=="PLOT"?false:true,
                                                controller: washrooms,
                                                style:GoogleFonts.getFont('Montserrat',fontWeight: FontWeight.w400,fontSize: 15),
                                                decoration: InputDecoration(
                                                  hintText: widget.type=="PLOT"?"Washrooms: 0":"No of Washrooms",
                                                  hintStyle: GoogleFonts.getFont('Montserrat',fontWeight: FontWeight.w400,fontSize: 15),
                                                ),
                                              )
                                          ),
                                          Container(
                                              width: MediaQuery.of(context).size.width*0.8,
                                              child: TextField(
                                                enabled: widget.type=="PLOT"?false:true,
                                                controller: kitchens,
                                                style:GoogleFonts.getFont('Montserrat',fontWeight: FontWeight.w400,fontSize: 15),
                                                decoration: InputDecoration(
                                                  hintText: widget.type=="PLOT"?"Kitchens: 0":"No of Kitchens",
                                                  hintStyle: GoogleFonts.getFont('Montserrat',fontWeight: FontWeight.w400,fontSize: 15),
                                                ),
                                              )
                                          ),
                                          Container(
                                              width: MediaQuery.of(context).size.width*0.8,
                                              child: TextField(
                                                enabled: widget.type=="PLOT"?false:true,
                                                controller: floors,
                                                style:GoogleFonts.getFont('Montserrat',fontWeight: FontWeight.w400,fontSize: 15),
                                                decoration: InputDecoration(
                                                  hintText: widget.type=="PLOT"?"Floors: 0":"No of Floors",
                                                  hintStyle: GoogleFonts.getFont('Montserrat',fontWeight: FontWeight.w400,fontSize: 15),
                                                ),
                                              )
                                          ),
                                          Container(
                                            width: MediaQuery.of(context).size.width*0.8,
                                            child: DropDown(
                                              initialValue: oneTimeData.data["sale"],
                                              onChanged: (val){
                                                sale.value=TextEditingValue(text: val);
                                              },
                                              items: ["Sale","Rent","Lease"],
                                              hint: Text("Sale/Rent/Lease"),
                                            ),
                                          ),
                                          Container(
                                              width: MediaQuery.of(context).size.width*0.8,
                                              child: TextField(
                                                controller: description,
                                                style:GoogleFonts.getFont('Montserrat',fontWeight: FontWeight.w400,fontSize: 15),
                                                decoration: InputDecoration(
                                                  hintText: "Other Details/ Description",
                                                  hintStyle: GoogleFonts.getFont('Montserrat',fontWeight: FontWeight.w400,fontSize: 15),
                                                ),
                                              )
                                          ),
                                          Container(
                                              width: MediaQuery.of(context).size.width*0.8,
                                              child: DropDown(
                                                onChanged: (val){
                                                  setState(() {
                                                    soldValue=val;
                                                  });
                                                },
                                                hint: Text("Sold Status"),
                                                initialValue: oneTimeData.data["sold"],
                                                items: [
                                                  "yes",
                                                  "no",
                                                ],)
                                          ),
                                          Container(
                                              width: MediaQuery.of(context).size.width*0.8,
                                              child: RaisedButton(
                                                onPressed: ()async{

                                                  print(district.value.text);
                                                  print(scheme.value.text);
                                                  print(area.value.text);
                                                  print(areaUnit);
                                                  print(demand.value.text);
                                                  print(sale.value.text);
                                                  print(soldValue);

                                                  if(
                                                  district.value.text!=""
                                                      &&
                                                      scheme.value.text!=""
                                                      &&
                                                      area.value.text!=""
                                                      &&
                                                      areaUnit!=""
                                                      &&
                                                      demand.value.text!=""
                                                      &&
                                                      sale.value.text!=""
                                                      &&
                                                      soldValue!=""
                                                  ){
                                                    FirebaseFirestore firestore = FirebaseFirestore.instance;
                                                    CollectionReference listings =
                                                    FirebaseFirestore.instance.collection('listings');
                                                    FirebaseAuth _auth= await FirebaseAuth.instance;



                                                    await listings.doc(docId).set(
                                                        {
                                                          "type":widget.type,
                                                          "seller":_auth.currentUser.uid,
                                                          "province":provinceValue,
                                                          "district":district.value.text,
                                                          "scheme":scheme.value.text,
                                                          "area": "${area.value.text} $areaUnit",
                                                          "areaUnit": areaUnit,
                                                          "floors":floors.value.text,
                                                          "kitchens":kitchens.value.text,
                                                          "washroom":washrooms.value.text,
                                                          "demand":demand.value.text,
                                                          "rooms":rooms.value.text,
                                                          "sale":sale.value.text,
                                                          "sold":soldValue,
                                                          "time": DateTime.now(),
                                                          "description":description.value.text,
                                                          "marker_x":updatedMarkersList[0].position.latitude.toString(),
                                                          "marker_y":updatedMarkersList[0].position.longitude.toString(),
                                                        });


                                                    Navigator.pop(context);
                                                    FirebaseAuth auth=FirebaseAuth.instance;


                                                    addToFeed
                                                      (
                                                        auth.currentUser.uid,                                                    scheme.value.text,
                                                        widget.type,
                                                        "${area.value.text} $areaUnit",
                                                        docId,
                                                        provinceValue
                                                    );
                                                  }
                                                  else{
                                                    showDialog(
                                                        context: context,
                                                        builder: (context){
                                                          return SafeArea(
                                                            child: Scaffold(
                                                              floatingActionButton: FloatingActionButton(
                                                                onPressed: (){
                                                                  Navigator.pop(context);
                                                                },
                                                                child: Icon(Icons.close),
                                                              ),
                                                              floatingActionButtonLocation:FloatingActionButtonLocation
                                                                  .centerFloat,
                                                              backgroundColor: Colors.transparent,
                                                              body: Center(
                                                                child: Container(
                                                                    padding: EdgeInsets.all(50),
                                                                    color: Colors.white,
                                                                    child: Text(
                                                                      "Fill All Fields",
                                                                      style:GoogleFonts.getFont('Montserrat',fontWeight: FontWeight.w400,fontSize: 25),
                                                                    )
                                                                ),
                                                              ),
                                                            ),
                                                          );
                                                        }
                                                    );
                                                  }

                                                },

                                                child: Text("Update"),

                                              )
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            }
                        );
                      }
                  );
                }
            );


          }
          else{
            return SafeArea(child: Scaffold(body: Center(child: Text("LOADING"))));
          }



      }
    );
  }
}
