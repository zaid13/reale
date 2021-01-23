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
import 'package:reale/newCode/Dropdowns/Modal/EntryModal;.dart';
import "dart:async";

import 'package:reale/selectLocation.dart';

var location=LatLng(30,69);
var value=0;
var areaUnit="";


TextEditingController province=TextEditingController();
TextEditingController district=TextEditingController();
TextEditingController scheme=TextEditingController();
TextEditingController area=TextEditingController();
TextEditingController demand=TextEditingController();
TextEditingController rooms=TextEditingController();
TextEditingController washrooms=TextEditingController();
TextEditingController kitchens=TextEditingController();
TextEditingController floors=TextEditingController();
TextEditingController sale=TextEditingController();
TextEditingController description=TextEditingController();
TextEditingController basement=TextEditingController();
TextEditingController cars=TextEditingController();
TextEditingController property_number=TextEditingController();
TextEditingController otherdetail=TextEditingController();


class addListing extends StatefulWidget {



  addListing(){
  }

  @override
  addListingState createState() => addListingState();
}

  class addListingState extends State<addListing> {

  MainDropDown mainDropDown = MainDropDown(

  );



  @override
  void initState() {
    // TODO: implement initState
    mainDropDown.init();


  }



  @override
  Widget build(BuildContext context) {

    return SafeArea(
 child:  StreamBuilder(
     stream: FirebaseFirestore.instance.collection("province").snapshots() ,
     builder: (context, snapshot) {


       if(snapshot.hasData) {

         initDropDowns(snapshot.data );
         return Scaffold(
           body:Container(
             height: MediaQuery.of(context).size.height,
             width: MediaQuery.of(context).size.width ,
             child:ListView(
               padding: EdgeInsets.only(left: 20,right: 20),
               // mainAxisAlignment: MainAxisAlignment.center,
               children: [

                 mainDropDown.d1.getDropDown(context, this),
                 mainDropDown.d2.getDropDown(context, this),
                 mainDropDown.d3.getDropDown(context, this),
                 mainDropDown.d4.getDropDown(context, this),
                 mainDropDown.d5.getDropDown(context, this),
                 mainDropDown.d6.getDropDown(context, this),
                 mainDropDown.d7.getDropDown(context, this),
                 Container(
                     width: MediaQuery
                         .of(context)
                         .size
                         .width * 0.9,
                     child: TextField(
                       controller: description,
                       style: GoogleFonts.getFont(
                           'Montserrat', fontWeight: FontWeight.w400,
                           fontSize: 15),
                       decoration: InputDecoration(
                         hintText: "Other Details/ Adress",
                         hintStyle: GoogleFonts.getFont('Montserrat',
                             fontWeight: FontWeight.w400,
                             fontSize: 15),
                       ),
                     )
                 ),
                 mainDropDown.ds1.getDropDown(context, this),




                 mainDropDown.ds1.isplot()?
                 mainDropDown.ds2_Land_dependent.getDropDown(context, this):Container(),
                 mainDropDown.ds1.isCommercial()?
                 mainDropDown.ds2_Commercial_dependent.getDropDown(context, this):Container(),
                 mainDropDown.ds1.isResidential()?
                 mainDropDown.ds2_Residential_dependent.getDropDown(context, this):Container(),



                 !mainDropDown.ds1.isplot() && mainDropDown.ds2_Residential_dependent.isflat() ?
                 mainDropDown.ds3.getDropDown(context, this):Container(),

                 // Container(
                 //     width: MediaQuery
                 //         .of(context)
                 //         .size
                 //         .width * 0.9,
                 //     child: DropdownButton(
                 //       onChanged: (val) {
                 //         setState(() {
                 //           dropDownListValue = val;
                 //           widget.type = widget.typeList[val];
                 //         });
                 //       },
                 //       hint: Text("Select Property Sub Type"),
                 //       value: dropDownListValue,
                 //       items: dropDownList,)
                 // ),
                 //
                 // Container(
                 //     width: MediaQuery
                 //         .of(context)
                 //         .size
                 //         .width * 0.9,
                 //     child: DropdownButton(
                 //       onChanged: (val) {
                 //         setState(() {
                 //           dropDownListValueSub = val;
                 //           // widget.type = widget.SubtypeList[val];
                 //
                 //         });
                 //       },
                 //       hint: Text("Select Property Type"),
                 //       value: dropDownListValueSub,
                 //       items: dropDownListSub,)
                 // ),
                 //

                 !mainDropDown.ds1.isplot()?
                 Container(
                     width: MediaQuery
                         .of(context)
                         .size
                         .width * 0.9,
                     child: TextField(
                       keyboardType:TextInputType.streetAddress ,
                       // enabled: widget.type == "PLOT" ? false : true,
                       controller: property_number,
                       style: GoogleFonts.getFont(
                           'Montserrat', fontWeight: FontWeight.w400,
                           fontSize: 15),
                       decoration: InputDecoration(
                         hintText:'Plot no / House no /Flat no /',
                             // : "No of Floors",
                         hintStyle: GoogleFonts.getFont('Montserrat',
                             fontWeight: FontWeight.w400,
                             fontSize: 15),
                       ),
                     )
                 ):Container(),
                 !mainDropDown.ds1.isplot()?
                 Container(
                     width: MediaQuery
                         .of(context)
                         .size
                         .width * 0.9,
                     child: TextField(

                       keyboardType:TextInputType.number ,
                       // enabled: widget.type == "PLOT" ? false : true,
                       controller: floors,
                       style: GoogleFonts.getFont(
                           'Montserrat', fontWeight: FontWeight.w400,
                           fontSize: 15),
                       decoration: InputDecoration(
                         hintText
                             : "No of Floors",
                         hintStyle: GoogleFonts.getFont('Montserrat',
                             fontWeight: FontWeight.w400,
                             fontSize: 15),
                       ),
                     )
                 ):Container(),
                 !mainDropDown.ds1.isplot()?
                 Container(
                     width: MediaQuery
                         .of(context)
                         .size
                         .width * 0.9,
                     child: TextField(
                       keyboardType:TextInputType.number ,

                       // enabled: widget.type == "PLOT" ? false : true,
                       controller: rooms,
                       style: GoogleFonts.getFont(
                           'Montserrat', fontWeight: FontWeight.w400,
                           fontSize: 15),
                       decoration: InputDecoration(
                         hintText
                             : "No of Rooms",
                         hintStyle: GoogleFonts.getFont('Montserrat',
                             fontWeight: FontWeight.w400,
                             fontSize: 15),
                       ),
                     )
                 ):Container(),
                 !mainDropDown.ds1.isplot()?
                 Container(
                     width: MediaQuery
                         .of(context)
                         .size
                         .width * 0.9,
                     child: TextField(
                       keyboardType:TextInputType.number ,

                       controller: kitchens,
                       style: GoogleFonts.getFont(
                           'Montserrat', fontWeight: FontWeight.w400,
                           fontSize: 15),
                       decoration: InputDecoration(
                         hintText:
                             "No of Kitchens",
                         hintStyle: GoogleFonts.getFont('Montserrat',
                             fontWeight: FontWeight.w400,
                             fontSize: 15),
                       ),
                     )
                 ):Container(),
                 !mainDropDown.ds1.isplot()?
                 Container(
                     width: MediaQuery
                         .of(context)
                         .size
                         .width * 0.9,
                     child: TextField(
                       keyboardType:TextInputType.number ,

                       controller: basement,
                       style: GoogleFonts.getFont(
                           'Montserrat', fontWeight: FontWeight.w400,
                           fontSize: 15),
                       decoration: InputDecoration(
                         hintText: "No of Basement  0",
                         hintStyle: GoogleFonts.getFont('Montserrat',
                             fontWeight: FontWeight.w400,
                             fontSize: 15),
                       ),
                     )
                 ):Container(),
                 !mainDropDown.ds1.isplot()?
                 Container(
                     width: MediaQuery
                         .of(context)
                         .size
                         .width * 0.9,
                     child: TextField(
                       keyboardType:TextInputType.number ,

                       controller: washrooms,
                       style: GoogleFonts.getFont(
                           'Montserrat', fontWeight: FontWeight.w400,
                           fontSize: 15),
                       decoration: InputDecoration(
                         hintText: !mainDropDown.ds1.isplot()
                             ? "Washrooms: 0"
                             : "No of Washrooms",
                         hintStyle: GoogleFonts.getFont('Montserrat',
                             fontWeight: FontWeight.w400,
                             fontSize: 15),
                       ),
                     )
                 ):Container(),
                 !mainDropDown.ds1.isplot()?
                 Container(
                     width: MediaQuery
                         .of(context)
                         .size
                         .width * 0.9,
                     child: TextField(
                       keyboardType:TextInputType.number ,

                       controller: cars,
                       style: GoogleFonts.getFont(
                           'Montserrat', fontWeight: FontWeight.w400,
                           fontSize: 15),
                       decoration: InputDecoration(
                         hintText:"No of Car Parking 0",
                         hintStyle: GoogleFonts.getFont('Montserrat',
                             fontWeight: FontWeight.w400,
                             fontSize: 15),
                       ),
                     )
                 ):Container(),

                 Container(
                   width: MediaQuery
                       .of(context)
                       .size
                       .width * 0.9,
                   child: DropDown(
                     onChanged: (val) {
                       sale.value = TextEditingValue(text: val);
                     },
                     items: ["Sale", "Rent", "Lease"],
                     hint: Text("Sale/Rent/Lease"),
                   ),
                 ),


                 Row(
                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                   children: [
                     Container(
                         width: MediaQuery
                             .of(context)
                             .size.width * 0.4,
                         height: 30,
                         child: TextField(
                           controller: area,
                           keyboardType:TextInputType.numberWithOptions(decimal: false,signed: false) ,
                           style: GoogleFonts.getFont('Montserrat',
                               fontWeight: FontWeight.w400,
                               fontSize: 15),
                           decoration: InputDecoration(
                             hintText: "Enter Area",
                             hintStyle: GoogleFonts.getFont(
                                 'Montserrat',
                                 fontWeight: FontWeight.w400,
                                 fontSize: 15),
                           ),
                         )
                     ),
                     Container(
                         width: MediaQuery
                             .of(context)
                             .size
                             .width * 0.45,
                         child: mainDropDown.ds4.getDropDown(context, this))
                   ],
                 ),

                 Container(
                     width: MediaQuery
                         .of(context)
                         .size
                         .width * 0.9,
                     child: TextField(
                       controller: demand,
                       keyboardType:TextInputType.number ,
                       style: GoogleFonts.getFont(
                           'Montserrat', fontWeight: FontWeight.w400,
                           fontSize: 15),
                       decoration: InputDecoration(
                         hintText: "Demand",
                         hintStyle: GoogleFonts.getFont('Montserrat',
                             fontWeight: FontWeight.w400,
                             fontSize: 15),
                       ),
                     )
                 ),
                 Container(
                     width: MediaQuery
                         .of(context)
                         .size
                         .width * 0.9,
                     child: TextField(
                       controller: otherdetail,
                       style: GoogleFonts.getFont(
                           'Montserrat', fontWeight: FontWeight.w400,
                           fontSize: 15),
                       decoration: InputDecoration(
                         hintText: 'Other Details',
                         hintStyle: GoogleFonts.getFont('Montserrat',
                             fontWeight: FontWeight.w400,
                             fontSize: 15),
                       ),
                     )
                 ),
                 Container(
                     width: MediaQuery
                         .of(context)
                         .size
                         .width * 0.9,
                     child: RaisedButton(
                       onPressed: () {
                         showDialog(
                             context: context, builder: (context) {
                           return selectLocation();
                         });
                       },
                       child: Text("SELECT LOCATION"),

                     )
                 ),

                 Container(
                     width: MediaQuery
                         .of(context)
                         .size
                         .width * 0.9,
                     child: RaisedButton(
                       onPressed: () async {

                         String type = '';
                         String provinceStr='';


                      submitDataButton();
                       },

                       child: Text("Add"),

                     )
                 ),
               ],
             ),


           )
         );
       }
       return ModalProgressHUD(inAsyncCall: true,child: Container(),);
     }
 ),



    );
  }

  bool  isFilled(){




    // mainDropDown.d1.;
    // mainDropDown.d2
    // mainDropDown.d3
    // mainDropDown.d4
    // mainDropDown.d5
    // mainDropDown.d6
    // mainDropDown.d7
    // mainDropDown.ds1
    // mainDropDown.ds2
    // mainDropDown.ds3
    //
    //
    // description
    // cars
    // washrooms
    // basement
    // kitchens
    // rooms
    // property_number
    // floors
    //
    // sale.value
    //
    // mainDropDown.ds4
    // area
    //
    //
    // demand
    // otherdetail

  }
  Future postData(){}
submitDataButton() async {

  EntryModal entryModal  = EntryModal(
    mainDropDown: mainDropDown,
    area: area.text,
    basement:basement.text  ,
    cars:cars.text  ,
    demand:demand.text  ,
    description:description.text  ,
    floors:floors.text  ,
    kitchens:kitchens.text  ,
    otherdetail:otherdetail.text  ,
    property_number:property_number.text  ,
    rooms:rooms.text  ,
    sale:sale.text  ,
    washrooms:washrooms.text  ,


  );


  if (entryModal.isfilled()
  /*district.value.text != ""
      &&
      scheme.value.text != ""
      &&
      area.value.text != ""
      &&
      areaUnit != ""
      &&
      demand.value.text != ""
      &&
      rooms.value.text != ""
      &&
      washrooms.value.text != ""
      &&
      kitchens.value.text != ""
      &&
      floors.value.text != ""
      &&
      sale.value.text != ""*/
  ) {
    // FirebaseFirestore firestore = FirebaseFirestore
    //     .instance;
    // CollectionReference listings =
    // FirebaseFirestore.instance.collection(
    //     'listings');
    // FirebaseAuth _auth = await FirebaseAuth
    //     .instance;
    //
    //
    // DocumentReference docRef = await listings
    //     .add(
    //     {
    //       "type": type,
    //       "seller": _auth.currentUser.uid,
    //       "province": provinceStr,
    //       "district": district.value.text,
    //       "scheme": scheme.value.text,
    //       "area": "${area.value
    //           .text} $areaUnit",
    //       "areaUnit": areaUnit,
    //       "floors": floors.value.text,
    //       "kitchens": kitchens.value.text,
    //       "washroom": washrooms.value.text,
    //       "demand": demand.value.text,
    //       "rooms": rooms.value.text,
    //       "sale": sale.value.text,
    //       "sold": "no",
    //       "time": DateTime.now(),
    //       "description": description.value
    //           .text,
    //       "marker_x": markersList[0].position
    //           .latitude.toString(),
    //       "marker_y": markersList[0].position
    //           .longitude.toString(),
    //     });
    //
    // FirebaseAuth auth = FirebaseAuth.instance;
    //
    // addToFeed
    //   (
    //     auth.currentUser.uid,
    //     scheme.value.text,
    //     type,
    //     "${area.value.text} $areaUnit",
    //     docRef.id,
    //     provinceStr
    // );
    //
    // setState(() {
    //   province.value = TextEditingValue.empty;
    //   district.value = TextEditingValue.empty;
    //   scheme.value = TextEditingValue.empty;
    //   area.value = TextEditingValue.empty;
    //   areaUnit = "";
    //   demand.value = TextEditingValue.empty;
    //   rooms.value = TextEditingValue.empty;
    //   washrooms.value =
    //       TextEditingValue.empty;
    //   kitchens.value = TextEditingValue.empty;
    //   floors.value = TextEditingValue.empty;
    //   sale.value = TextEditingValue.empty;
    //   description.value =
    //       TextEditingValue.empty;
    // });
    //
    // Navigator.pop(context);
  String str=   await entryModal.postData();
  showAlertDialog(context,'SUCCESS  ','lIST ADDED # $str');
  }
  else {
    showAlertDialog(context,'ERROR','Please Fill all of the Fields');
  }

}
  initDropDowns( QuerySnapshot data){
    List<QueryDocumentSnapshot> docLs = data.docs;


    mainDropDown.d1. initDropDown(docLs);
   // mainDropDown.d2. initDropDown(docLs);

  }
  showAlertDialog(BuildContext context,String msg , String submsg) {

    // set up the button
    Widget okButton = FlatButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.pop(context,true);

      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(msg),
      content: Text(submsg),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
  resetall(){}

}
