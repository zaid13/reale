import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import "package:flutter/material.dart";
import "package:cloud_firestore/cloud_firestore.dart";
import 'package:reale/addListing.dart';
import 'package:reale/propertyDetails.dart';
import 'package:reale/updateListing.dart';

var filters=["province","type","sold","area"];
var filterIndex=0;
var currentFilterName="province";
TextEditingController currentSearch= TextEditingController();

class sold extends StatefulWidget {
  @override
  _soldState createState() => _soldState();
}

class _soldState extends State<sold> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
            child: StreamBuilder(
        stream: FirebaseFirestore.instance.collection("listings").orderBy("time",descending: true).snapshots(),
        builder: (context,snapshot){
          if(snapshot.hasData){

            QuerySnapshot data= snapshot.data;
            List<QueryDocumentSnapshot> documents=data.docs;


            return ListView(
              children: [
                Container(
                    margin: EdgeInsets.only(top: 20,left:10,right: 10),
                    child: Row(
                      children: [

                        Container(
                            width: 200,
                            child: TextField(
                              onChanged: (val){
                                setState(() {
                                });
                              },
                              controller: currentSearch ,
                              decoration: InputDecoration(
                                  hintText: "Enter Search Query"
                              ),
                              style: TextStyle(fontSize: 16),
                            )
                        ),
                        DropdownButton(
                          onChanged: (val) {
                            setState(() {
                              print(val);
                              currentFilterName=filters[val];
                              filterIndex=val;
                            });
                          },
                          hint: Text("${currentFilterName}"),
                          value: filterIndex,
                          items: [
                            DropdownMenuItem(child: Text("Province Wise"),value: 0,),
                            DropdownMenuItem(child: Text("Property type wise"),value: 1,),
                            DropdownMenuItem(child: Text("Sold Wise"),value: 2,),
                            DropdownMenuItem(child: Text("Area wise"),value: 3,),
                          ],),

                      ],
                    )
                ),
                ListView.builder(
                  shrinkWrap: true,
                    itemCount: documents.length,
                    itemBuilder: (context,index){
                      FirebaseAuth auth= FirebaseAuth.instance;

                      if(
                      documents[index].data()["seller"]==auth.currentUser.uid
                      &&
                      documents[index].data()[currentFilterName].toString().toLowerCase().contains(currentSearch.value.text.toLowerCase())
                      ){
                        var hoursDifference=DateTime.now().difference(documents[index].data()["time"].toDate()).inHours;
                        DateTime time=documents[index].data()["time"].toDate();
                        var timeHours=time.hour;
                        var timeMinutes=time.minute;
                        var timeCode="am";
                        if(timeHours>=12)
                          {
                            timeHours=timeHours-12;
                            timeCode="pm";
                          }

                        var timeFormat= "${time.year}-${time.month}-${time.day} $timeHours:$timeMinutes $timeCode ";

                        return Container(
                          decoration: BoxDecoration(
                              color: documents[index].data()["sold"]=="yes"?Colors.blueGrey:Colors.white,
                              border: Border.all(width: 2)
                          ),
                          margin: EdgeInsets.only(bottom: 40,left:5,right: 5),
                          padding: EdgeInsets.all(20),
                          child: RaisedButton(

                            elevation: 0,
                            color: documents[index].data()["sold"]=="yes"?Colors.blueGrey:Colors.white,
                            onPressed: (){
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context){
                                    return propertyDetails(documents[index].data());
                                  })
                              );
                            },
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Scheme : ${documents[index].data()["scheme"]}",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontFamily: "Times New Roman",
                                        fontWeight: FontWeight.w700,
                                        fontSize: 20,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Province : ${documents[index].data()["province"]}",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontFamily: "Times New Roman",
                                        fontWeight: FontWeight.w700,
                                        fontSize: 20,
                                      ),
                                    ),


                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                        "Sold: ${documents[index].data()["sold"]}",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontFamily: "Times New Roman",
                                        fontWeight: FontWeight.w700,
                                        fontSize: 20,
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(height: 10,),
                                Row(
                                  children: [
                                    Text(
                                      "Area : ${documents[index].data()["area"]}",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontFamily: "Times New Roman",
                                        fontWeight: FontWeight.w700,
                                        fontSize: 20,
                                      ),
                                      overflow: TextOverflow.fade,),
                                  ],
                                ),
                                SizedBox(height: 10,),

                                Row(
                                  children: [
                                    Text(
                                      "Time : $timeFormat ",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontFamily: "Times New Roman",
                                        fontWeight: FontWeight.w700,
                                        fontSize: 20,
                                      ),
                                      overflow: TextOverflow.fade,),
                                  ],
                                ),
                                SizedBox(height: 10,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    StreamBuilder(
                                      stream: FirebaseFirestore.instance.collection("users").doc(documents[index].data()["seller"]).snapshots(),
                                      builder: (context,snapshot){
                                        if(snapshot.hasData){
                                          return Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                "Seller : ${snapshot.data.data()["businessName"]}",
                                                style: TextStyle(
                                                  color: Colors.deepOrangeAccent,
                                                  fontFamily: "Times New Roman",
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 20,
                                                ),
                                              )
                                            ],
                                          );
                                        }
                                        else{
                                          return Text("LOADING");
                                        }
                                      },
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    RaisedButton(
                                      color: hoursDifference<=24?Colors.pinkAccent:Colors.blueGrey,
                                      elevation: 15,
                                      child: Row(
                                        children: [
                                          Text(
                                            "EDIT ",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontFamily: "Times New Roman",
                                              fontWeight: FontWeight.w700,
                                              fontSize: 16,
                                            ),
                                          ),
                                          Icon(Icons.edit,color: Colors.white,)
                                        ],
                                      ),
                                      onPressed: (){
                                        if(hoursDifference<=24)
                                        {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context){
                                                    return updateListing(documents[index].data()["type"],documents[index].id);
                                                  }
                                              )
                                          );
                                        }
                                        else
                                        {
                                          Scaffold.of(context).showSnackBar(
                                              SnackBar(
                                                backgroundColor: Colors.red,
                                                content: Text(
                                                  "More Than 24 hours passed",
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontFamily: "Times New Roman",
                                                    fontWeight: FontWeight.w700,
                                                    fontSize: 20,
                                                  ),
                                                ) ,
                                              )
                                          );
                                        }

                                      },
                                    )
                                  ],
                                ),

                              ],
                            ),
                          ),
                        );
                      }
                      else{
                        return SizedBox(height: 0,);
                      }
                    }
                ),
              ],
            );
          }
          else{
            return Text("LOADING");
          }
        },
      )
        ),
      ),
    );
  }
}
