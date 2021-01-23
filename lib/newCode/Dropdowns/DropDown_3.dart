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

import 'package:modal_progress_hud/modal_progress_hud.dart';

class DropDown_3{
  String id= "";
  String name = "0";
  List  <DropdownMenuItem<String>>ls =[];
  String hint = "Select Scheme Non Scheme ";
  String title = "Select Scheme";
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
                          title = 'Scheme';
                        }
                        else{
                          title = 'Non Scheme';
                        }
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
width: 50,
              height: 50,
              child: ModalProgressHUD(child: Container(),
                inAsyncCall: true,),
            );
          }
      ),
    );

  }

  Map datamap={};

  initDropDown(   ){

    ls.clear();
    ls.add( DropdownMenuItem(child: Text('Scheme') ,value: '0',));
    ls.add( DropdownMenuItem(child: Text('Non Scheme') ,value: '1',));
    datamap['0']= 'Scheme';
    datamap['1' ]= 'Non Scheme';

  }
  as()async{
    return await 3;
  }

}


