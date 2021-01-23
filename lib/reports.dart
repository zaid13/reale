import "package:flutter/material.dart";
import "package:cloud_firestore/cloud_firestore.dart";
import 'package:flutter_dropdown/flutter_dropdown.dart';
import 'package:reale/propertyDetails.dart';

var currentFilterValue=0;
var currentFilterName="province";
TextEditingController currentSearch= TextEditingController();
var filters=["province","type","sold","area"];

class reports extends StatefulWidget {
  @override
  _reportsState createState() => _reportsState();
}

class _reportsState extends State<reports> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Container(
            child: ListView(
              shrinkWrap: true,
              children: [
                Container(
                    margin: EdgeInsets.only(left:10,right: 10),
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
                              currentFilterValue=val;
                            });
                          },
                          hint: Text("${currentFilterName}"),
                          value: currentFilterValue,
                          items: [
                            DropdownMenuItem(child: Text("Province Wise"),value: 0,),
                            DropdownMenuItem(child: Text("Property type wise"),value: 1,),
                            DropdownMenuItem(child: Text("Sold Wise"),value: 2,),
                            DropdownMenuItem(child: Text("Area wise"),value: 3,),
                          ],),

                      ],
                    )
                ),
                Container(
                  height: MediaQuery.of(context).size.height,
                  child: StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection("listings").orderBy("time",descending: true)
                        .snapshots(),
                    builder: (context,snapshot){
                      if(snapshot.hasData){

                        QuerySnapshot data= snapshot.data;
                        List<QueryDocumentSnapshot> documents=data.docs;


                        return ListView.builder(
                            itemCount: documents.length,
                            itemBuilder: (context,index){

                              check()async{
                                print(currentFilterName);
                                DocumentSnapshot currentDoc= documents[index];
                                var data= await currentDoc.data();

                                if(data[currentFilterName].toString().toLowerCase().contains(currentSearch.value.text.toString().toLowerCase()))
                                {
                                    return true;
                                }
                                else{
                                  return false;
                                }

                              }



                              return FutureBuilder(
                                future: check(),
                                builder: (context,snapshot){

                                  print(snapshot.data);
                                  if(snapshot.data==true){
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
                                                  "Time : $timeFormat",
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontFamily: "Times New Roman",
                                                      fontWeight: FontWeight.w700,
                                                      fontSize: 20
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(height: 10,),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "Scheme : ${documents[index].data()["scheme"]}",
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontFamily: "Times New Roman",
                                                      fontWeight: FontWeight.w700,
                                                      fontSize: 20
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
                                                      fontSize: 20
                                                  ),
                                                   )
                                                ,Icon(Icons.location_on,size: 50,)

                                              ],
                                            ),
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
                                                          Text("Seller : ",
                                                            style: TextStyle(
                                                              color: Colors.black,
                                                                fontFamily: "Times New Roman",
                                                                fontWeight: FontWeight.w700,
                                                                fontSize: 20
                                                            ),
                                                          ),
                                                          Text("${snapshot.data.data()["businessName"]}",
                                                            style: TextStyle(
                                                                color: Colors.deepOrangeAccent,
                                                                fontFamily: "Times New Roman",
                                                                fontWeight: FontWeight.w700,
                                                                fontSize: 20,
                                                            ),
                                                            overflow: TextOverflow.fade,
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

                                          ],
                                        ),
                                      ),
                                    );
                                  }
                                  else{
                                    return SizedBox(height: 0,);
                                  }


                                },
                              );




                            }
                        );
                      }
                      else{
                        return Text("LOADING");
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
