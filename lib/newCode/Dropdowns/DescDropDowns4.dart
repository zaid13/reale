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
import "dart:async";



class DescDropDown4{
  String id= "";
  String name = "0";
  List  <DropdownMenuItem<String>>ls =[];
  String hint = "Select Area";

  Widget getDropDown(context,parent){
    print(ls.length);
    print(parent.mainDropDown.d7.name );

    return Container(
      height: 50,
      child: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('info' ).doc('areaSizes').snapshots(),
          builder: (context, snapshot) {

            if(snapshot.hasData)
            {
              initDropDown(snapshot.data);
              return Container(
                  width: MediaQuery
                      .of(context)
                      .size
                      .width * 0.9,
                  child: DropdownButton(
                    onChanged: (val) {
                      parent. setState(() {
                        print(val);
                        name = val;
                        id  = datamap[name];
                      });
                    },
                    hint: Text(hint),
                    value: name,
                    items: ls,)
              );}
            else return Container(
              child: ModalProgressHUD(child: Container(),
                inAsyncCall: true,),
            );
          }
      ),
    );

  }


  Map datamap={};

  initDropDown( DocumentSnapshot data  ){
  List dataLs = data.data()['sizes'];
    ls.clear();
int  ctr = 1;

    dataLs.forEach((element) {
      datamap[ctr.toString()]= element;
      ls.add( DropdownMenuItem(child: Text(element),value:ctr.toString(),));
ctr++;

    });


    ls.add( DropdownMenuItem(child: Text(hint) ,value: '0',));

  }

}