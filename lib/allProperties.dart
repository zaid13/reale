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


var currentFilter;
TextEditingController currentSearch= TextEditingController();


class allProperties extends StatefulWidget {
  final  id;


  allProperties(this.id);

  @override
  _allPropertiesState createState() => _allPropertiesState();
}

class _allPropertiesState extends State<allProperties> {

  bool searchbool= false;
  check()async{
    List<DocumentSnapshot> ls =[];
    CollectionReference addListing =await     FirebaseFirestore.instance.collection(
        'Scheme').doc(widget.id).collection('listings');
    QuerySnapshot currentDoc = await    addListing.get();
   for (    int i =0 ; i< currentDoc.docs.length ; i++)  {
      DocumentSnapshot element = currentDoc.docs[i];
      DocumentReference lst =await     FirebaseFirestore.instance.collection(
          'listings').doc(element.data()['add_id']);

DocumentSnapshot ds = await  lst.get();

if(ds.data()==null)
  return ls;


      // if('Rent'== ds.data()['sale'] ??'')
      ls.add(ds);

    }

    // print(currentFilter);
    // DocumentSnapshot currentDoc= documents[index];
    // var data= await currentDoc.data();

    // if(searchbool) return <DocumentSnapshot>[];

    List <DocumentSnapshot> tmpList = [];

    ls.forEach((element) {
print(search_controller.d1.label);
print( element.data()['phase']);

      if(search_controller.d1.search &&   !tmpList.contains(element) &&   element.data()['phase']== search_controller.d1.label)
      tmpList.add(element);

    if(search_controller.d2.search &&   !tmpList.contains(element) &&   element.data()['block']== search_controller.d1.label)
    tmpList.add(element);


    });

    return ls+tmpList;


  }

  getCheckBox(){
return   CheckboxGroup(

    itemBuilder: (checkBox, label, index) => Row(

      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [

        Row(
          children: [
            checkBox,
            Text(label.data),
          ],
        ),
        checkBox.value?DropDown_widList[index]:Container(),
      ],

    ),

    labels: <String>[

      "Zone",

      "Block",

      "Sub Block",
      "Property Type",

      // "Wednesday",

      // "Thursday",

      // "Friday",

      // "Saturday",

    ],

    onSelected: (List<String> checked) => print(checked.toString()),
  onChange: (bool isChecked, String label, int index){
      // print(index);
      setState(() {
        search_controller. changeStatus(isChecked , label,index);

      });
  },

);
  }

  getStringList(List<DocumentSnapshot> ls,field){
    List<String> list = [];
    ls.forEach((element) {
      list.add( element.data()[field]);
    });
    return list;
  }
  getdropDownvalues() async {

    QuerySnapshot addListing =await     FirebaseFirestore.instance.collection(
        'Phase').where('townID',isEqualTo:widget.id ).get();

List<DocumentSnapshot>phasedocs =  addListing.docs;
    addListing =await     FirebaseFirestore.instance.collection(
        'block').where('phaseID',isEqualTo:search_controller.d1.id??'').get();
    List<DocumentSnapshot>blockdocs =  addListing.docs;

    addListing =await     FirebaseFirestore.instance.collection(
        'subblock').where('blockID',isEqualTo:search_controller.d2.id??'').get();
    List<DocumentSnapshot>subblockdocs =  addListing.docs;



    ///fro 1
    search_controller.d1.idlst= getStringList (phasedocs,'id');
    search_controller.d1.lst= getStringList (phasedocs,'name');
///for 2


    search_controller.d2.idlst= getStringList (blockdocs,'id');
    search_controller.d2.lst= getStringList (blockdocs,'name');
///for 3

    search_controller.d3.idlst= getStringList (subblockdocs,'id');
    search_controller.d3.lst= getStringList (subblockdocs,'name');
///for 4

    search_controller.d4.idlst= propertyType['id'];
    search_controller.d4.lst= propertyType['name'];


    return {"zone":{'name':getStringList (phasedocs,'name'),'id':getStringList (phasedocs,'name') } };


 }
  List <DropDown> DropDown_widList= [];
  List Widlist = [];
    Search_controller search_controller =Search_controller();

  initDropDown() async {


    DropDown_widList = [];
    DropDown_widList.add(DropDown(
      onChanged: (val){
        setState(() {

          search_controller.d1.setid(val);
        });
      },
      items: search_controller.d1.lst,
      hint: Text("Zone"),
    ));
    DropDown_widList.add(DropDown(
      onChanged: (val){
        setState(() {

          search_controller.d2.setid(val);
        });
      },
      items:  search_controller.d2.lst,
      hint: Text("Sub Zone"),
    ));
    DropDown_widList.add(DropDown(
      onChanged: (val){
        setState(() {

          search_controller.d3.setid(val);        });
      },
      items:           search_controller.d3.lst,
      hint: Text("Sub block"),
    ));
    DropDown_widList.add(DropDown(
     onChanged: (val){
       setState(() {

         search_controller.d4.setid(val);        });
     },
     items:           search_controller.d4.lst,
     hint: Text("Property Type"),
   ));

  }
  GetList (List documents){
    Widlist = [];
    initDropDown();
    // Widlist.add(getCheckBox());

    documents.forEach((element) {

      if(search_controller.d1.label==element.data()["time"] )
      {}
      else {
        var hoursDifference = DateTime
            .now()
            .difference(element.data()["time"].toDate())
            .inHours;
        DateTime time = element.data()["time"].toDate();
        var timeHours = time.hour;
        var timeMinutes = time.minute;
        var timeCode = "am";
        if (timeHours >= 12) {
          timeHours = timeHours - 12;
          timeCode = "pm";
        }

        var timeFormat = "${time.year}-${time.month}-${time
            .day} $timeHours:$timeMinutes $timeCode ";


        Widlist.add(Container(
          decoration: BoxDecoration(
              color: element.data()["sold"] == "yes" ? Colors.blueGrey : Colors
                  .white,
              border: Border.all(width: 2)
          ),

          margin: EdgeInsets.only(bottom: 40, left: 5, right: 5),
          padding: EdgeInsets.all(20),
          child: RaisedButton(
            elevation: 0,
            color: element.data()["sold"] == "yes" ? Colors.blueGrey : Colors
                .white,
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) {
                    return propertyDetails(element.data());
                  })
              );
            },
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text("Time : $timeFormat",
                      style: TextStyle(
                          color: Colors.black,
                          fontFamily: "Times New Roman",
                          fontWeight: FontWeight.w700,
                          fontSize: 20
                      ),
                      overflow: TextOverflow.fade,),
                  ],
                ),
                SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text("Scheme : ${element.data()["scheme"]}",
                      style: TextStyle(
                          color: Colors.black,
                          fontFamily: "Times New Roman",
                          fontWeight: FontWeight.w700,
                          fontSize: 20
                      ),
                      overflow: TextOverflow.fade,),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(   "Province : ${element.data()["province"]}",
                      style: TextStyle(
                          color: Colors.black,
                          fontFamily: "Times New Roman",
                          fontWeight: FontWeight.w700,
                          fontSize: 20
                      ),
                      overflow: TextOverflow.fade,)
                    , Icon(Icons.location_on, size: 50,)

                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    StreamBuilder(
                      stream: FirebaseFirestore.instance.collection("users")
                          .doc(element.data()["seller"])
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Seller : ${snapshot.data
                                    .data()["businessName"]}",
                                style: TextStyle(
                                    color: Colors.deepOrange,
                                    fontFamily: "Times New Roman",
                                    fontWeight: FontWeight.w700,
                                    fontSize: 20
                                ),
                                overflow: TextOverflow.fade,)
                            ],
                          );
                        }
                        else {
                          return Text("LOADING");
                        }
                      },
                    ),
                  ],
                ),

              ],
            ),
          ),
        ));
      }
    });
    return Widlist;
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Container(
            child:    Container(
              height: MediaQuery.of(context).size.height,
              child: FutureBuilder(
                future: check(),
                builder: (context,snapshotduture){
                  if(snapshotduture.hasData){
                    List<DocumentSnapshot> documents= snapshotduture.data;
                    GetList(documents);
                    return Column(
                      children: [

                        getCheckBox(),
                        Expanded(
                          child: ListView.builder(

                              itemCount:Widlist.length /*documents.length*/,
                              itemBuilder: (context,index){
                               {

                                  return Widlist[index];
                                }
                              }
                          ),
                        ),
                      ],
                    );
                  }
                  else{
                    return Container(

                        child: Text("LOADING"));
                  }
                },
              ),
            ),          ),
        ),
      ),
    );
  }
  List <DocumentSnapshot> checkZone(List ls){
    return ls;
if(!search_controller.d1.search)
  {return ls;}

    List newls = [];
    ls.forEach((element) {

if(search_controller.d1.search) return ls;

print(  search_controller.d1.label);
// print(element['phase']);
    // if(  search_controller.d1.label ==element['phase'] )
          newls.add(element);

    });
return newls;

  }
  List <DocumentSnapshot>checkBlock(ls){return ls;}
  List <DocumentSnapshot>checkSubBlock(ls){return ls;}
  List <DocumentSnapshot>checkPropertyType(ls){return ls;}



}

