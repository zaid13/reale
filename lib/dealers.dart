import "package:flutter/material.dart";
import "package:cloud_firestore/cloud_firestore.dart";
import 'package:google_fonts/google_fonts.dart';
import 'package:reale/chat.dart';

TextEditingController currentSearch=TextEditingController();


class dealers extends StatefulWidget {
  @override
  _dealersState createState() => _dealersState();
}

class _dealersState extends State<dealers> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          //height: MediaQuery.of(context).size.height-100,
          child: ListView(
            children: [
              SizedBox(height: 20,),
              Container(
                width: 300,
                child: TextField(
                  onChanged: (val){
                    setState(() {
                    });
                  },
                  controller: currentSearch,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                  ),
                  decoration: InputDecoration(
                    hintMaxLines: 3,
                      suffixIcon: Icon(Icons.search),
                      hintText: "Search by name,id card,email,phone"
                  ),
                ),
              ),
              StreamBuilder(
                stream: FirebaseFirestore.instance.collection("users").snapshots(),
                builder: (context,snapshot){
                  if(snapshot.hasData){

                    QuerySnapshot data= snapshot.data;
                    List<QueryDocumentSnapshot> users=data.docs;

                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: users.length,
                      itemBuilder: (context,index){
                        var username=users[index].data()["name"].toString();
                        var idCard=users[index].data()["idCard"].toString();
                        var email=users[index].data()["email"].toString();
                        var phone=users[index].data()["phone"].toString();
                        var businessOwner=users[index].data()["businessOwner"].toString();
                        var businessName=users[index].data()["businessName"].toString();

                        if(
                          users[index].data()["approved"]==true
                        )
                        {
                          if (
                          username.contains(currentSearch.value.text.toString())
                              || idCard.toString().toLowerCase().contains(currentSearch.value.text.toString().toLowerCase())
                              || email.toString().toLowerCase().contains(currentSearch.value.text.toString().toLowerCase())
                              || phone.toString().toLowerCase().contains(currentSearch.value.text.toString().toLowerCase())
                              || businessOwner.toString().toLowerCase().contains(currentSearch.value.text.toString().toLowerCase())
                              || businessName.toString().toLowerCase().contains(currentSearch.value.text.toString().toLowerCase())



                          ) {
                            return Container(
                              margin: EdgeInsets.only(left:20,right: 20,bottom: 10),
                              child: RaisedButton(
                                padding: EdgeInsets.all(20),
                                elevation: 10,
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) {
                                            return chatScreen(users[index].id);
                                          }
                                      )
                                  );
                                },
                                color: Colors.pinkAccent,
                                child: Column(
                                  children: [
                                    Text(
                                      "${users[index].data()["name"]}",
                                      textAlign: TextAlign.left,
                                      style: GoogleFonts.getFont(
                                          'Montserrat', color: Colors.white,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 25),
                                    ),
                                    Text(
                                      "Owner:",
                                      textAlign: TextAlign.left,
                                      style: GoogleFonts.getFont(
                                          'Montserrat', color: Colors.white,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 18),
                                    ),
                                    Text(
                                      "${businessOwner}",
                                      textAlign: TextAlign.left,
                                      style: GoogleFonts.getFont(
                                          'Montserrat', color: Colors.white,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 25),
                                    ),
                                    Text(
                                      "business Name:",
                                      textAlign: TextAlign.left,
                                      style: GoogleFonts.getFont(
                                          'Montserrat', color: Colors.white,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 18),
                                    ),
                                    Text(
                                      "${businessName}",
                                      textAlign: TextAlign.left,
                                      style: GoogleFonts.getFont(
                                          'Montserrat', color: Colors.white,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 25),
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
                        else{
                          return SizedBox(height: 0,);
                        }

                      },
                    );

                  }
                  else{
                    return Text("LOADING");
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
