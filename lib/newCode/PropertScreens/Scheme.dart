import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import "package:flutter/material.dart";
import 'package:google_fonts/google_fonts.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:reale/allProperties.dart';
import 'package:reale/getAllSchemes.dart';


class Schemes extends StatefulWidget {
  final city;


  Schemes(this.city);

  @override
  _getAllDistrictsState createState() => _getAllDistrictsState();
}

class _getAllDistrictsState extends State<Schemes> {
  @override
  Widget build(BuildContext context) {
    print(widget.city);
    return SafeArea(
      child: Scaffold(
        body: StreamBuilder(
            stream: FirebaseFirestore.instance.collection("Scheme").where('cityID',isEqualTo: widget.city ).snapshots(),
            builder: (context, snapshot) {

              if(!snapshot.hasData)
              {return ModalProgressHUD(inAsyncCall: true,child: Container(),);}
              List <DocumentSnapshot> ds =snapshot.data.docs;
              var districtList=ds;
              if(ds.length>0)
              return ListView.builder(
                itemCount: districtList.length ,
                itemBuilder: (context,index){
                  return Container(
                    decoration: BoxDecoration(
                        border: Border.all(width: 2)
                    ),
                    margin: EdgeInsets.only(bottom: 10),
                    child: RaisedButton(
                      color: Colors.white,
                      elevation: 20,
                      padding: EdgeInsets.only(top:20,bottom: 20),
                      onPressed: (){

                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context){

                              return allProperties(ds[index].id);



                                }
                            )
                        );
                      },
                      child: Text(
                        "${districtList[index].data()['name']}",
                        style:GoogleFonts.getFont('Montserrat',color: Colors.black,fontWeight: FontWeight.w400,fontSize: 25),
                      ),
                    ),
                  );
                },
              );

              return  Container(
                alignment: Alignment. center,
                child: Text(

                  "NO Schemes found",
                  style:GoogleFonts.getFont('Montserrat',color: Colors.black,fontWeight: FontWeight.w400,fontSize: 25),
                ),
              );
            }
        ) ,
      ),
    );
  }
}
