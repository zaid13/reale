
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import "package:flutter/material.dart";
import 'package:flutter_dropdown/flutter_dropdown.dart';
import "package:google_fonts/google_fonts.dart";
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_place_picker/google_maps_place_picker.dart';
import 'package:google_maps_place_picker/providers/place_provider.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:reale/addToFeed.dart';
import 'package:reale/newCode/Dropdowns/MainDropdDown.dart';
import 'package:reale/newCode/Dropdowns/Modal/EntryModal;.dart';
import "dart:async";

import 'package:reale/selectLocation.dart';


import 'package:flutter/material.dart';
import 'package:reale/newCode/Dropdowns/MainDropdDown.dart';


class EntryModal{

  EntryModal({this.mainDropDown,
  this.description,
  this.cars,
  this.washrooms,
  this.basement,
  this.kitchens,
  this.area,
    this.demand,
    this.floors,
    this.otherdetail,
    this.property_number,
    this.rooms,
    this.sale


  });
  MainDropDown mainDropDown;


  String description;
  String   cars;
  String   washrooms;
  String   basement;
  String   kitchens;
  String   rooms;
  String   property_number;
  String   floors;
  String sale;
  String  area;
  String  demand;
  String  otherdetail;


  bool isfilled(){

    postData();
    if(! mainDropDown.isFilled()){
      print('mainDropDown is Empty');
      return false;
    }
    if(description == ''){
      print('description is Empty');
      return false;}
    if(cars == ''){
      print('cars is Empty');
      return false;}
    if(washrooms == ''){
      print('washrooms is Empty');
      return false;}
    if(basement == ''){
      print('basement is Empty');
      return false;}
    if(kitchens == ''){
      print('kitchens is Empty');
      return false;}
    if(rooms == ''){
      print('rooms is Empty');
      return false;}
    if(property_number == ''){
      print('property_number is Empty');
      return false;}
    if(floors == ''){
      print('floors is Empty');
      return false;}
    if(sale == ''){
      print('sale is Empty');
      return false;}
    if(area == ''){
      print('area is Empty');
      return false;}
    if(demand == ''){
      print('demand is Empty');
      return false;}
    if(otherdetail == ''){
      print('otherdetail is Empty');
      return false;}
    return true;





  }

  Future postData() async {

print(mainDropDown.toString());


print('description'+ '  -   '+description );
print('cars'+ '  -   '+cars );
print('washrooms'+ '  -   '+washrooms );
print('basement'+ '  -   '+basement );
print('kitchens'+ '  -   '+kitchens );
print('rooms'+ '  -   '+rooms );
print('property_number'+ '  -   '+property_number );
print('floors'+ '  -   '+floors );
print('sale'+ '  -   '+sale );
print('area'+ '  -   '+area );
print('demand'+ '  -   '+demand );
print('otherdetail'+ '  -   '+otherdetail );




    CollectionReference listings =
    FirebaseFirestore.instance.collection(
        'listings');
    FirebaseAuth _auth = await FirebaseAuth
        .instance;

print(listings.path);
print('3333333333333');

    DocumentReference docRef = await listings
        .add(
        {
          "type": '',
          "seller": _auth.currentUser.uid,
          "province": mainDropDown.d1.id,
          "district": mainDropDown.d2.id,
          "scheme": mainDropDown.d3.id,
          "phase":mainDropDown.d5.id,
          "block":mainDropDown.d6.id,
          "subblock":mainDropDown.d7.id,
          "area": "${area} ${mainDropDown.ds4.id}",
          "areaUnit": mainDropDown.ds4.id,
          "floors": floors,
          "kitchens": kitchens,
          "washroom": washrooms,
          "demand": demand,
          "rooms": rooms,
          "sale": sale,
          "sold": "no",
          "time": DateTime.now(),
          "description": description,
          "marker_x": markersList[0].position
              .latitude.toString(),
          "marker_y": markersList[0].position
              .longitude.toString(),
        });

// docRef.id
    print(docRef.documentID);

CollectionReference addListing =await
    FirebaseFirestore.instance.collection(
        'Scheme').doc(mainDropDown.d4.name).collection('listings');
addListing.add({'add_id':docRef.id});



return addListing.path;
}
}