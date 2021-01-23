import "package:flutter/material.dart";
import "package:cloud_firestore/cloud_firestore.dart";
FirebaseFirestore firestore = FirebaseFirestore.instance;
CollectionReference users = FirebaseFirestore.instance.collection('users');


setUserDetails(uid,{name="",profile="",email="",phone=""})async{


  name=name==null?"":name;
  profile=profile==null?"":profile;
  email=email==null?"":email;
  phone=phone==null?"":phone;


  DocumentSnapshot doc=await users.doc(uid).get();
  var existingData=doc.data();

  if(existingData!=null){
    existingData["id"]=existingData["id"]==null?uid:existingData["id"];
    existingData["approved"]=existingData["approved"]==null?false:existingData["approved"];
    existingData["name"]=name;
    existingData["profile"]=profile;
    existingData["phone"]=phone;
    existingData["email"]=email;
    existingData["officeAddress"]=existingData["officeAddress"]==null?"":existingData["officeAddress"];
    existingData["registrationDocumentBackPic"]==null?"":existingData["registrationDocumentBackPic"];
    existingData["registrationDocumentFrontPic"]==null?"":existingData["registrationDocumentFrontPic"];
    existingData["registrationNumber"]==null?"":existingData["registrationNumber"];
    existingData["businessName"]==null?"":existingData["businessName"];
    existingData["businessOwner"]==null?"":existingData["businessOwner"];
    existingData["idCardFrontPic"]==null?"":existingData["idCardFrontPic"];
    existingData["idCardBackPic"]==null?"":existingData["idCardBackPic"];
  }
  else{
    existingData={};
    existingData["id"]=uid;
    existingData["approved"]=false;
    existingData["name"]=name;
    existingData["profile"]=profile;
    existingData["phone"]=phone;
    existingData["email"]=email;
    existingData["officeAddress"]="";
    existingData["registrationDocumentBackPic"]="";
    existingData["registrationDocumentFrontPic"]="";
    existingData["registrationNumber"]="";
    existingData["businessName"]="";
    existingData["businessOwner"]="";
    existingData["idCardFrontPic"]="";
    existingData["idCardBackPic"]="";
  }






  await users.doc(uid).set(existingData);
  return null;

}