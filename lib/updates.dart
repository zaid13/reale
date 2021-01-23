import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";
import "package:cloud_firestore/cloud_firestore.dart";
import 'package:flutter_dropdown/flutter_dropdown.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:reale/addListing.dart';
import 'package:reale/getAllDistricts.dart';
import 'package:reale/propertyDetails.dart';

var currentFilter;
TextEditingController currentSearch= TextEditingController();



class updates extends StatefulWidget {


  @override
  _updatesState createState() => _updatesState();
}

class _updatesState extends State<updates> {
  var getfuture;


  @override
  void initState() {
    // TODO: implement initState
    getfuture = getProvince();

  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future:getfuture ,
        builder: (context, snapshot) {
          if(snapshot.hasData)
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (context, index) {
                return  GetButton(snapshot.data[index]['name'],(){
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context){
                            return getAllDistricts("Punjab",snapshot.data[index]['cities']);
                          }
                      )
                  );
                });
              },


            );
          else{
            return ModalProgressHUD(child: Container(),
              inAsyncCall: true,
            );
          }
        }
    );
  }
  getProvince()async{
    final  _db = FirebaseFirestore.instance;
    var t =     await  _db.collection('province').where( "name", isNotEqualTo:' Select Province').get();

    print(t.docs);
    return t.docs;

  }
}

GetButton(String name , Function fun){
  final  _db = FirebaseFirestore.instance;
  return   Padding(
    padding: const EdgeInsets.only(bottom: 10,top: 10,left: 5,right: 5),
    child: RaisedButton(
      padding: EdgeInsets.all(10),
      color: Colors.pinkAccent,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
          side: BorderSide(color: Colors.black)
      ),
      child: Text(
        name,
        style: TextStyle(
            color: Colors.white,
            fontFamily: "Times New Roman",
            fontWeight: FontWeight.w700,
            fontSize: 20
        ),
      ),
      onPressed: fun,
    ),
  );

}