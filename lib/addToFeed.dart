import 'package:cloud_firestore/cloud_firestore.dart';
import "package:flutter/material.dart";

 addToFeed(adderName,scheme,propertyType,propertySize,listingId,province)async{

  DocumentSnapshot feed= await FirebaseFirestore
      .instance
      .collection("feed")
      .doc("feed")
      .get();

  var data=feed.data();
  print(data);

  if(data==null){
   FirebaseFirestore
       .instance
       .collection("feed")
       .doc("feed")
       .set(
       {
        "feed":[{
         "user":adderName,
         "scheme":scheme,
         "type":propertyType,
         "size":propertySize,
         "listing":listingId,
          "province":province,
        }]
       }
       );

  }
  else{
   DocumentSnapshot doc= await FirebaseFirestore.instance.collection("feed").doc("feed").get();
   var data=doc.data();
   data["feed"].add(
       {
        "user":adderName,
        "scheme":scheme,
        "type":propertyType,
        "size":propertySize,
        "listing":listingId,
         "province":province,
       }
   );
   FirebaseFirestore.instance.collection("feed").doc("feed").set(data);

  }

 }