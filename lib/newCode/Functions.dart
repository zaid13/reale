


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dash_chat/dash_chat.dart';
import 'package:flutter/material.dart';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'dart:io';



getTimeEvent(var ds){

  String status="";
  DateTime date;

  if(ds.runtimeType == Timestamp){
    date =  ds.toDate();
  }
  else{
    date = ds;
  }
  DateTime curr = DateTime.now();

  Duration diff = curr.difference( date);



    if(diff.inSeconds<60){
      status="Just Now";
    }
    else if(diff.inMinutes<60){
      status="${diff.inMinutes.floor()} minutes ago ";
    }
    else if(diff.inMinutes>60 && diff.inHours<24){
      status="${(diff.inMinutes/60).floor()} hours ago";
    }
    else {
      status= DateFormat('h:mm a').format(date);
    }



  return status;
}


getDateEvent(var ds){

  String status="";
  DateTime date;

  if(ds.runtimeType == Timestamp){
    date =  ds.toDate();
  }
  else{
    date = ds;
  }
  DateTime curr = DateTime.now();

  Duration diff = curr.difference( date);


print(diff.inDays);
    if(diff.inDays<1){
      status="TODAY";
    }
    else if(diff.inDays<2){
      status="YESTERDAY";
    }
    else {
      status=DateFormat('MMM dd, yyyy').format(date);
    }


print(status);

  return status;
}

removeFCMTok(uid) async {
  final  _db = FirebaseFirestore.instance;
  final FirebaseMessaging _fcm = FirebaseMessaging();

  var fcmToken =await _fcm.getToken();

      await _db
        .collection('users')
        .doc(uid)
        .collection('tokens')
        .doc(fcmToken).delete();

    // await tokens.set({
    //   'token': fcmToken,
    //   'createdAt': FieldValue.serverTimestamp(), // optional
    //   'platform': Platform.operatingSystem // optional
    // });
    //



}