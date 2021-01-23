// import "package:flutter/material.dart";
// import 'package:google_fonts/google_fonts.dart';
// import 'package:reale/addListing.dart';
//
//
// class Entries extends StatefulWidget {
//   @override
//   _EntriesState createState() => _EntriesState();
// }
//
// class _EntriesState extends State<Entries> {
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         body: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: [
//                   RaisedButton(
//                       elevation: 10,
//                       color: Colors.pinkAccent,
//                       shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(10.0),
//                           side: BorderSide(color: Colors.black)
//                       ),
//                       onPressed: (){
//                         Navigator.push(context,MaterialPageRoute(builder: (context){
//                           return addListing("HOME");
//                         }));
//                       },
//                       child: Text(
//                         "HOUSE/HOME",
//                           style: TextStyle(
//                               fontFamily: "Times New Roman",
//                               fontWeight: FontWeight.w700,
//                               color: Colors.white,
//                               fontSize: 20
//                           )
//                       )
//                   ),
//                   RaisedButton(
//                       elevation: 10,
//                       color: Colors.pinkAccent,
//                       shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(10.0),
//                           side: BorderSide(color: Colors.black)
//                       ),
//                       onPressed: (){
//                         Navigator.push(context,MaterialPageRoute(builder: (context){
//                           return addListing("FLAT");
//                         }));
//                       },
//                       child: Text(
//                         "FLAT",
//                           style: TextStyle(
//                               fontFamily: "Times New Roman",
//                               fontWeight: FontWeight.w700,
//                               color: Colors.white,
//                               fontSize: 20
//                           )
//                          )
//                   ),
//                 ],
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: [
//                   RaisedButton(
//                       elevation: 10,
//                       color: Colors.pinkAccent,
//                       shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(10.0),
//                           side: BorderSide(color: Colors.black)
//                       ),
//                       onPressed: (){
//                         Navigator.push(context,MaterialPageRoute(builder: (context){
//                           return addListing("SHOP");
//                         }));
//                       },
//                       child: Text(
//                         "SHOP",
//                           style: TextStyle(
//                               fontFamily: "Times New Roman",
//                               fontWeight: FontWeight.w700,
//                               color: Colors.white,
//                               fontSize: 20
//                           )
//                       )
//                   ),
//                   RaisedButton(
//                       elevation: 10,
//                       color: Colors.pinkAccent,
//                       shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(10.0),
//                           side: BorderSide(color: Colors.black)
//                       ),
//                       onPressed: (){
//                         Navigator.push(context,MaterialPageRoute(builder: (context){
//                           return addListing("BUILDING");
//                         }));
//                       },
//                       child: Text(
//                         "BUILDING",
//                           style: TextStyle(
//                               fontFamily: "Times New Roman",
//                               fontWeight: FontWeight.w700,
//                               color: Colors.white,
//                               fontSize: 20
//                           )
//                          )
//                   ),
//                 ],
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: [
//                   RaisedButton(
//                       elevation: 10,
//                       color: Colors.pinkAccent,
//                       shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(10.0),
//                           side: BorderSide(color: Colors.black)
//                       ),
//                       onPressed: (){
//                         Navigator.push(context,MaterialPageRoute(builder: (context){
//                           return addListing("PLOT");
//                         }));
//                       },
//                       child: Text(
//                         "PLOT",
//                           style: TextStyle(
//                               fontFamily: "Times New Roman",
//                               fontWeight: FontWeight.w700,
//                               color: Colors.white,
//                               fontSize: 20
//                           )
//                       )
//                   ),
//                   RaisedButton(
//                       elevation: 10,
//                       color: Colors.pinkAccent,
//                       shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(10.0),
//                           side: BorderSide(color: Colors.black)
//                       ),
//                       onPressed: (){
//                         Navigator.push(context,MaterialPageRoute(builder: (context){
//                           return addListing("CONSTRUCTION");
//                         }));
//                       },
//                       child: Text(
//                         "CONSTRUCTION",
//                           style: TextStyle(
//                               fontFamily: "Times New Roman",
//                               fontWeight: FontWeight.w700,
//                               color: Colors.white,
//                               fontSize: 20
//                           )
//                       )
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
