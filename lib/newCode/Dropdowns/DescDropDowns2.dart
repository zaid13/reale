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


import "package:flutter/material.dart";
import "package:cloud_firestore/cloud_firestore.dart";
import 'package:flutter_dropdown/flutter_dropdown.dart';
import 'package:grouped_buttons/grouped_buttons.dart';
import 'package:reale/propertyDetails.dart';
import 'package:reale/newCode/data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import "package:flutter/material.dart";
import 'package:google_fonts/google_fonts.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:reale/allProperties.dart';
import 'package:reale/getAllSchemes.dart';
import 'package:reale/newCode/searchdropdown/searchcontroller.dart';



class DescDropDown2{
  DescDropDown2(this.masterls);
  Map masterls ;
  String id= "";
  String name = "0";
  List  <DropdownMenuItem<String>>ls =[];
  String hint = "Select Type";
  String title = "House";
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
                        List lst =     masterls['name'];


                        title = lst[int.parse(val)];
                        name = val;

                      });
                    },
                    hint: Text(hint),
                    value: name,
                    items: ls,)
              );}
            else return ModalProgressHUD(child: Container(),
              inAsyncCall: true,);
          }
      ),
    );

  }


  initDropDown(   ){

    ls.clear();
List lst =     masterls['name'];

    lst.sort((a, b) => a.toString().compareTo(b.toString()));

int t = 0;
lst.forEach((element) {
  ls.add( DropdownMenuItem(child: Text(element) ,value: t.toString(),));
  t++;
  });




  }
  as()async{
    return await 3;
  }
  isflat(){
    if(title == 'PentHouse'  || title=='Flat')
      return true;

    return false;

  }

}