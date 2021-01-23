import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import "package:flutter/material.dart";
import "package:google_fonts/google_fonts.dart";
import 'package:reale/Auth/login.dart';
import 'package:reale/chat.dart';
import 'package:reale/mainPage.dart';
import 'package:reale/setUserDetails.dart';
import "package:dash_chat/dash_chat.dart";
import 'package:firebase_storage/firebase_storage.dart';
import "package:flutter/material.dart";
import "package:firebase_auth/firebase_auth.dart";
import "package:firebase_core/firebase_core.dart";
import "package:cloud_firestore/cloud_firestore.dart";
import "dart:io";

import 'package:image_picker/image_picker.dart';
import 'package:reale/newCode/Functions.dart';

File _image;
final picker = ImagePicker();


TextEditingController profileName= TextEditingController();
TextEditingController email= TextEditingController();
TextEditingController phone= TextEditingController();
TextEditingController officeAddress= TextEditingController();
TextEditingController businessName= TextEditingController();
TextEditingController businessOwner= TextEditingController();
TextEditingController idCard= TextEditingController();
TextEditingController idCardBackPic= TextEditingController();
TextEditingController idCardFrontPic= TextEditingController();
TextEditingController registrationDocumentBackPic= TextEditingController();
TextEditingController registrationDocumentFrontPic= TextEditingController();
TextEditingController registrationNumber= TextEditingController();




class profile extends StatefulWidget {
  @override
  _profileState createState() => _profileState();
}


class _profileState extends State<profile> {

  sendImage(link)async{

    FirebaseAuth auth= FirebaseAuth.instance;
    DocumentSnapshot user= await FirebaseFirestore.instance.collection("users").doc(auth.currentUser.uid).get();
    var userData= await user.data();
    userData["profile"]= link.toString();

    await FirebaseFirestore.instance.collection("users").doc(auth.currentUser.uid).set(userData);
    auth.currentUser.updateProfile(photoURL: link.toString(),displayName: auth.currentUser.displayName);
  }

  Future getImage() async {

    final pickedFile = await picker.getImage(source: ImageSource.camera);

    if (pickedFile != null) {
      _image = File(pickedFile.path);

      FirebaseStorage _storage = FirebaseStorage.instance;

      String fileName = _image.path;
      StorageReference firebaseStorageRef =
      FirebaseStorage.instance.ref().child('uploads/$fileName');
      StorageUploadTask uploadTask = firebaseStorageRef.putFile(_image);
      StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;
      taskSnapshot.ref.getDownloadURL().then(
            (value)async{
          await sendImage(value);
        },

      );
    }
    else {
      print('No image selected.');
    }

  }


  initializeValues()async{
    FirebaseAuth _auth= FirebaseAuth.instance;
    var tempUser= await _auth.currentUser;

    setState(() {
      currentUser=tempUser;
    });

    var userCol= await FirebaseFirestore.instance.collection("users").doc(_auth.currentUser.uid).get();
    var userData= await userCol.data();

    var nameTemp=tempUser.displayName==null?"":tempUser.displayName;
    var tempIdCard=userData["idCard"]==null?"":userData["idCard"];
    var tempBusinessName=userData["businessName"]==null?"":userData["businessName"];
    var tempRegistrationNumber=userData["registrationNumber"]==null?"":userData["registrationNumber"];
    var tempBusinessOwner=userData["businessOwner"]==null?"":userData["businessOwner"];


    profileName.value= TextEditingValue(text:nameTemp );
    idCard.value=TextEditingValue(text: tempIdCard );
    businessName.value=TextEditingValue(text: tempBusinessName);
    registrationNumber.value=TextEditingValue(text: tempRegistrationNumber);
    businessOwner.value=TextEditingValue(text: tempBusinessOwner);

  }

  @override
  void initState() {
    initializeValues();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    FirebaseAuth auth= FirebaseAuth.instance;
    var photo=currentUser.photoURL==null?"none":currentUser.photoURL;

    return SafeArea(
      child: StreamBuilder(
        stream: FirebaseFirestore.instance.collection("users").doc("${auth.currentUser.uid}").snapshots(),
        builder: (context, snapshot) {
          return Container(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Text(
                    "Change Your Details",
                    style: GoogleFonts.getFont('Montserrat',fontWeight: FontWeight.w500,fontSize: 20),
                  ),
                  Center(
                    child: CircleAvatar(
                      radius: 100,
                      backgroundImage:NetworkImage(photo),
                    ),
                  ),
                  Center(
                    child: RaisedButton(
                      onPressed: ()async{
                        await getImage();
                      },
                      child: Icon(Icons.add_a_photo),
                    ),
                  ),
                  Container(
                      width: MediaQuery.of(context).size.width*0.8,
                      child: TextField(
                        textAlign: TextAlign.center,
                        controller: profileName,
                        style:GoogleFonts.getFont('Montserrat',fontWeight: FontWeight.w400,fontSize: 15),
                        decoration: InputDecoration(
                          hintText: "Name",
                          hintStyle: GoogleFonts.getFont('Montserrat',fontWeight: FontWeight.w400,fontSize: 15),
                        ),
                      )
                  ),
                  Container(
                      width: MediaQuery.of(context).size.width*0.8,
                      child: TextField(
                        textAlign: TextAlign.center,
                        controller: idCard ,
                        style:GoogleFonts.getFont('Montserrat',fontWeight: FontWeight.w400,fontSize: 15),
                        decoration: InputDecoration(
                          hintText: "Id Card Number",
                          hintStyle: GoogleFonts.getFont('Montserrat',fontWeight: FontWeight.w400,fontSize: 15),
                        ),
                      )
                  ),
                  Container(
                      width: MediaQuery.of(context).size.width*0.8,
                      child: TextField(
                        textAlign: TextAlign.center,
                        controller: businessName ,
                        style:GoogleFonts.getFont('Montserrat',fontWeight: FontWeight.w400,fontSize: 15),
                        decoration: InputDecoration(
                          hintText: "Business Name",
                          hintStyle: GoogleFonts.getFont('Montserrat',fontWeight: FontWeight.w400,fontSize: 15),
                        ),
                      )
                  ),
                  Container(
                      width: MediaQuery.of(context).size.width*0.8,
                      child: TextField(
                        textAlign: TextAlign.center,
                        controller: registrationNumber ,
                        style:GoogleFonts.getFont('Montserrat',fontWeight: FontWeight.w400,fontSize: 15),
                        decoration: InputDecoration(
                          hintText: "Registration Number",
                          hintStyle: GoogleFonts.getFont('Montserrat',fontWeight: FontWeight.w400,fontSize: 15),
                        ),
                      )
                  ),
                  Container(
                      width: MediaQuery.of(context).size.width*0.8,
                      child: TextField(
                        textAlign: TextAlign.center,
                        controller: businessOwner ,
                        style:GoogleFonts.getFont('Montserrat',fontWeight: FontWeight.w400,fontSize: 15),
                        decoration: InputDecoration(
                          hintText: "Business Owner Name",
                          hintStyle: GoogleFonts.getFont('Montserrat',fontWeight: FontWeight.w400,fontSize: 15),
                        ),
                      )
                  ),
                  Container(
                    padding: EdgeInsets.only(top:50),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        RaisedButton(
                          color: Colors.white,
                          onPressed: ()async{
                            FirebaseAuth _auth= FirebaseAuth.instance;
                            await _auth.currentUser.updateProfile(displayName:profileName.value.text );
                            CollectionReference users = await FirebaseFirestore.instance.collection('users');
                            DocumentSnapshot ourUser=await users.doc(currentUser.uid).get();
                            var userData=ourUser.data();
                            userData["name"]=profileName.value.text;
                            userData["idCard"]=idCard.value.text;
                            userData["businessName"]=businessName.value.text;
                            userData["registrationNumber"]=registrationNumber.value.text;
                            userData["businessOwner"]=businessOwner.value.text;
                            users.doc(currentUser.uid).set(userData);
                            },
                          elevation: 0,
                          child: Container(
                              decoration: BoxDecoration(
                                  color:Colors.pinkAccent,
                                  border: Border.all(
                                      color: Colors.white
                                  ),
                                  borderRadius: BorderRadius.all(Radius.circular(20))
                              ),
                              padding: EdgeInsets.all(25),
                              child: Icon(Icons.arrow_forward,color: Colors.white,)
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        RaisedButton(
                          color: Colors.white,
                          onPressed: ()async{
                            FirebaseAuth auth=FirebaseAuth.instance;
                            await removeFCMTok(auth.currentUser.uid );
                            await auth.signOut();


                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context){
                                  return SafeArea(child: Scaffold(body: login()));
                                }
                              )
                            );
                          },
                          elevation: 0,
                          child: Container(
                              decoration: BoxDecoration(
                                  color:Colors.pinkAccent,
                                  border: Border.all(
                                      color: Colors.white
                                  ),
                                  borderRadius: BorderRadius.all(Radius.circular(20))
                              ),
                              padding: EdgeInsets.all(25),
                              child: Text(
                                "Log Out",
                                style: TextStyle(color: Colors.white),
                              )
                          ),
                        )
                      ],
                    ),
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
