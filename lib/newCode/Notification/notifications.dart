// import 'package:fcm_push/fcm_push.dart';
// import 'package:fcm_push/fcm_push.dart';
//
//
//
//
//   class Notifications{
//
// FCM(){
//
//
//   final String serverKey = "AAAA4QydxFc:APA91bEcGzeFcykjhXAdvDcpH8vFHSqZoTqdaag5YLVd4TMkcrXRvXgVp559A8XEPVZVXTQP1P3Cxz3JX2B9eZBj4H5FUUL19Nm0TbvSdCmRVgPOBiP9coa8GC7rGOoZxHX46J4mmX59";
//   final String token = "966579307607";
//
//   // Future<int> main() async {
//     // final FCM fcm = new FCM(serverKey);
//     //
//     // final Message fcmMessage = new Message()
//     //   ..to = token
//     //   ..title = _config.title
//     //   ..body = _config.body;
//
//
//   }
//
// }

import 'dart:io';
import 'package:flutter/material.dart';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


saveDeviceToken(uid) async {
  // Get the current user
  final  _db = FirebaseFirestore.instance;
  final FirebaseMessaging _fcm = FirebaseMessaging();

 // String uid = 'jeffd23';
  // FirebaseUser user = await _auth.currentUser();

  // Get the token for this device
  String fcmToken = await _fcm.getToken();
print(fcmToken);
print('/////////////////');
  // Save it to Firestore
  if (fcmToken != null) {
    var tokens = _db
        .collection('users')
        .doc(uid)
        .collection('tokens')
        .doc(fcmToken);

    await tokens.set({
      'token': fcmToken,
      'createdAt': FieldValue.serverTimestamp(), // optional
      'platform': Platform.operatingSystem // optional
    });
  }
}
