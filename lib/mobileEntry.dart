import 'package:country_code_picker/country_code.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/Material.dart';
import "package:flutter/cupertino.dart";
import "package:pin_code_text_field/pin_code_text_field.dart";
import "package:google_fonts/google_fonts.dart";
import 'package:reale/codeEntry.dart';
import 'package:reale/mainPage.dart';
import 'package:reale/setUserDetails.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:flutter/Material.dart';
import "package:flutter/cupertino.dart";
import "package:google_fonts/google_fonts.dart";
import "package:flutter_signin_button/flutter_signin_button.dart";
import "package:firebase_auth/firebase_auth.dart";
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:reale/Auth/signup.dart';
import 'package:reale/mainPage.dart';
import 'package:reale/mobileEntry.dart';
import 'package:reale/newCode/Notification/notifications.dart';
import 'package:reale/setUserDetails.dart';
import "package:firebase_dynamic_links/firebase_dynamic_links.dart";
import "package:flutter_facebook_auth/flutter_facebook_auth.dart";
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:url_launcher/url_launcher.dart';



import 'dart:io';
import 'package:flutter/material.dart';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

var countryCode=CountryCode(dialCode: "+92",code: "PK");

TextEditingController phoneField= TextEditingController();

class mobileEntry extends StatefulWidget {

  @override
  _mobileEntryState createState() => _mobileEntryState();
}

class _mobileEntryState extends State<mobileEntry> {
  @override

  final  _db = FirebaseFirestore.instance;
  final FirebaseMessaging _fcm = FirebaseMessaging();


  setUPNotifications(){

    if (Platform.isIOS) {
      var  iosSubscription = _fcm.onIosSettingsRegistered.listen((data) {
        // save the token  OR subscribe to a topic here
      });

      _fcm.requestNotificationPermissions(IosNotificationSettings());
    }



    // ...
    //
    // _fcm.configure(
    //   onMessage: (Map<String, dynamic> message) async {
    //     print("onMessage: $message");
    //     showDialog(
    //       context: context,
    //       builder: (context) => AlertDialog(
    //         content: ListTile(
    //           title: Text(message['notification']['title']),
    //           subtitle: Text(message['notification']['body']),
    //         ),
    //         actions: <Widget>[
    //           FlatButton(
    //             child: Text('Ok'),
    //             onPressed: () => Navigator.of(context).pop(),
    //           ),
    //         ],
    //       ),
    //     );
    //   },
    //   onLaunch: (Map<String, dynamic> message) async {
    //     print("onLaunch: $message");
    //     // TODO optional
    //   },
    //   onResume: (Map<String, dynamic> message) async {
    //     print("onResume: $message");
    //     // TODO optional
    //   },
    // );

    // ...

    _fcm.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage: $message");
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            content: ListTile(
              title: Text(message['notification']['title']),
              subtitle: Text(message['notification']['body']),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text('Ok'),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          ),
        );
      },
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");
        // TODO optional
      },
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");
        // TODO optional
      },
    );

  }
  checkLoggedIn()async{
    FirebaseApp defaultApp = await Firebase.initializeApp();
    FirebaseAuth auth = FirebaseAuth.instance;
  }

  void initState() {
    // TODO: implement initState
    checkLoggedIn();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Container(
            margin: EdgeInsets.only(top:40),
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Enter your Mobile Number",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.getFont('Montserrat',fontWeight: FontWeight.w500,fontSize: 30),

                  ),
                  SizedBox(height: 20,),
                  CountryCodePicker(

                    onChanged: (code){
                      setState(() {
                        countryCode=code;
                      });
                    },
                    initialSelection: 'PK',
                    onInit: (CountryCode d){
// print(d.code);
// print(countryCode. dialCode);
// countryCode=d;
                       // countryCode=;

                    },
                    favorite: ['+92','PK'],
                    showCountryOnly: false,
                    showOnlyCountryWhenClosed: false,
                    alignLeft: false,
                  ),
                  Container(
                    padding: EdgeInsets.only(left:20,right: 20),
                    child: TextField(
                      keyboardType: TextInputType.number,
                      controller: phoneField,
                      style:GoogleFonts.getFont('Montserrat',fontWeight: FontWeight.w400,fontSize: 15),
                      decoration: InputDecoration(
                        prefix: Text("${countryCode.dialCode}   "),
                        hintText: " 317 463 1188",
                        hintStyle: GoogleFonts.getFont('Montserrat',fontWeight: FontWeight.w400,fontSize: 15),
                      ),
                    ),
                  ),
                  SizedBox(height: 20,),
                  Container(
                      child:Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Didn't receive the code?",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.getFont('Montserrat',fontWeight: FontWeight.w500,fontSize: 16),

                          ),
                          FlatButton(
                            onPressed: ()async{

                            },
                            child: Text("Resend",style: GoogleFonts.getFont('Montserrat',color: Colors.blueAccent,fontWeight: FontWeight.w500,fontSize: 16)),

                          )
                        ],
                      )
                  ),
                  SizedBox(height: 20,),
                  Container(
                    decoration: new BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Color.fromRGBO(249, 214, 148, 0.5),
                          blurRadius: 5, // soften the shadow
                          spreadRadius: 0.1, //extend the shadow
                          offset: Offset(
                            0.0, // Move to right 10  horizontally
                            5.0, // Move to bottom 10 Vertically
                          ),
                        )
                      ],
                    ),
                    child: ButtonTheme(
                      minWidth: 240,
                      height: 70,
                      child: RaisedButton(
                        color: Colors.pinkAccent,
                        child: Icon(Icons.arrow_forward,color: Colors.white,),
                        onPressed: ()async{
                          FirebaseApp defaultApp = await Firebase.initializeApp();
                          print('${countryCode.dialCode}${phoneField.value.text}');
                          FirebaseAuth auth = FirebaseAuth.instance;
                          await auth.verifyPhoneNumber(
                            phoneNumber: '${countryCode.dialCode}${phoneField.value.text}',
                            verificationFailed: (FirebaseAuthException e) {
                              FirebaseAuthException p =e;

                              Alert(

                                context: context,
                                title: p.code,
                                desc:p.message,
                              ).show();




                            },
                            codeSent: (String verificationId, int resendToken) {
                              print("CODE SENT");
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context){
                                      return codeEntry(verificationId);
                                    })
                                );

                            },
                            codeAutoRetrievalTimeout: (String verificationId) {},
                            verificationCompleted: (PhoneAuthCredential credential) async {
                              PhoneAuthCredential d;


                              // credential.
                              await auth.signInWithCredential(credential);
                              print("LOGGED IN** *");
                              print(auth.currentUser.phoneNumber);

                              await saveDeviceToken(auth.currentUser.uid.toString());
                              setUPNotifications();

                              setUserDetails(auth.currentUser.uid.toString(),phone: phoneField.value.text);


                              Navigator.push(context, MaterialPageRoute(builder: (context){
                                return mainPage();
                              }));

                            },
                          );
                        },
                        shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(10.0),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
      ),
    );
  }
}
