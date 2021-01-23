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
import 'package:reale/newCode/data.dart';
import "dart:async";



class DescDropDown1{
  String id= "";
  String name = "0";
  List  <DropdownMenuItem<String>>ls =[];
  String hint = "Select Purpose";
  String title = "Residential";


  Widget getDropDown(context,parent){
    print(ls.length);
    return Container(
 height: 50,
      child: FutureBuilder(
          future:  as(),
          builder: (context, snapshot) {

            if(snapshot.hasData)
            {
              initDropDown();
              return Container(
                  width: MediaQuery
                      .of(context)
                      .size
                      .width * 0.9,
                  child: DropdownButton(
                    onChanged: (val) {
                      parent. setState(() {
                        if(val=='0'){
                          title = 'Residential';
                        }
                        else if(val=='1'){
                          title = 'Commercial';
                        }
                        else{
                          title = 'Plot';
                        }
                        print(val);
                        name = val;

                      });
                    },
                    hint: Text(hint),
                    value: name,
                    items: ls,)
              );}
            else return Container(
              height: 50,
              width: 50,
              child: ModalProgressHUD(child: Container(),
                inAsyncCall: true,),
            );
          }
      ),
    );

  }


  initDropDown(   ){

    ls.clear();


    for( int i =0 ; i <propertyType['name'].length ; i++   )
    ls.add( DropdownMenuItem(child: Text(propertyType['name'][i]) ,value: propertyType['id'][i],));



  }
  as()async{
    return await 3;
  }

bool isplot(){
    if(title == 'Plot'){
      print(true);
      return true;
    }
    print(false);

    return false;
}

  bool isCommercial(){
    if(title == 'Commercial'){
      print(true);
      return true;
    }
    print(false);

    return false;
  }

  bool isResidential(){
    if(title == 'Residential'){
      print(true);
      return true;
    }
    print(false);

    return false;
  }
}