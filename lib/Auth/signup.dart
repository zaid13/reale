import 'package:flutter/Material.dart';
import "package:flutter/cupertino.dart";
import "package:google_fonts/google_fonts.dart";
import "package:flutter_signin_button/flutter_signin_button.dart";
import "package:firebase_auth/firebase_auth.dart";
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:reale/Auth/login.dart';
import 'package:reale/codeEntry.dart';

import 'package:reale/mainPage.dart';
import 'package:reale/mobileEntry.dart';
import "package:google_sign_in/google_sign_in.dart";
import 'package:reale/setUserDetails.dart';
import "package:flutter_facebook_auth/flutter_facebook_auth.dart";
import 'package:firebase_auth/firebase_auth.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:url_launcher/url_launcher.dart';


Future<UserCredential> signInWithGoogle() async {
  // Trigger the authentication flow
  final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();

  // Obtain the auth details from the request
  final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

  // Create a new credential
  final GoogleAuthCredential credential = GoogleAuthProvider.credential(
    accessToken: googleAuth.accessToken,
    idToken: googleAuth.idToken,
  );

  // Once signed in, return the UserCredential
  return await FirebaseAuth.instance.signInWithCredential(credential);
}


var obscured=true;

TextEditingController email=TextEditingController();
TextEditingController password=TextEditingController();
TextEditingController passwordConfirm=TextEditingController();

class signup extends StatefulWidget {
  @override
  _signupState createState() => _signupState();
}

class _signupState extends State<signup> {


  _login() async {

    try{

      final result = await FacebookAuth.instance.login();
      String _token = result.accessToken.token;
      OAuthCredential credential = await FacebookAuthProvider.credential(_token); // _token is your facebook access token as a string
      FirebaseApp defaultApp = await Firebase.initializeApp();
      FirebaseAuth _auth=FirebaseAuth.instance;
      final User user = (await _auth.signInWithCredential(credential)).user;
      await setUserDetails(
          user.uid,
          name: user.displayName,
          email: user.email,
          profile: user.photoURL,
          phone: user.phoneNumber
      );
      print("logged in");
      Navigator.push(context, MaterialPageRoute(builder: (context){
        return mainPage();
      }));


    }
    catch(e){
      showDialog(context: context,builder: (context){
        return SafeArea(
          child: Scaffold(
            body: Center(
              child: Text("$e"),
            ),
          ),
        );
      });
    }

  }



  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 40,),
              Container(
                padding: EdgeInsets.only(left:30),
                child: Row(
                  children: <Widget>[

                    FlatButton(
                      onPressed:(){
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (context){
                              return SafeArea(
                                child: Scaffold(
                                    body: login()
                                ),
                              );
                            })
                        );
                      },
                      child: Column(
                        children: <Widget>[
                          Text(
                            "Login",
                            style: GoogleFonts.getFont('Montserrat',fontWeight: FontWeight.w500,fontSize: 20),
                          ),
                          SizedBox(height: 10,),
                          SizedBox(height: 0,width: 50,child: Container(color: Colors.black,),)
                        ],
                      ),
                    ),
                    FlatButton(
                      onPressed:(){

                      },
                      child: Column(
                        children: <Widget>[
                          Text(
                            "Sign Up",
                            style: GoogleFonts.getFont('Montserrat',fontWeight: FontWeight.w500,fontSize: 20),
                          ),
                          SizedBox(height: 10,),
                          SizedBox(height: 2,width: 50,child: Container(color: Colors.black,),)
                        ],
                      ),
                    ),

                  ],
                ),
              ),//
              SizedBox(height: 20,),
              // BUTTONS
              Column(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(left:40),
                    child: Row(
                      children: <Widget>[
                        Text(
                          "Hello,",
                          style: GoogleFonts.getFont('Montserrat',fontWeight: FontWeight.w500,fontSize: 50),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.only(left:40,top: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "Press button below to continue",//"Enter your details below or login with \na social media account,",
                          style: GoogleFonts.getFont('Montserrat',fontWeight: FontWeight.w400,fontSize: 15),
                        ),
                      ],
                    ),
                  ),
                  // Container(
                  //     width: MediaQuery.of(context).size.width*0.8,
                  //     child: TextField(
                  //       controller: email,
                  //       style:GoogleFonts.getFont('Montserrat',fontWeight: FontWeight.w400,fontSize: 15),
                  //       decoration: InputDecoration(
                  //         hintText: "Email Adress",
                  //         hintStyle: GoogleFonts.getFont('Montserrat',fontWeight: FontWeight.w400,fontSize: 15),
                  //       ),
                  //     )
                  // ),
                  // Container(
                  //     width: MediaQuery.of(context).size.width*0.8,
                  //     child: TextField(
                  //       controller: password,
                  //       obscureText: obscured,
                  //       style:GoogleFonts.getFont('Montserrat',fontWeight: FontWeight.w400,fontSize: 15),
                  //       decoration: InputDecoration(
                  //         suffix: FlatButton(
                  //           onPressed: (){
                  //             setState(() {
                  //               if(obscured==true){
                  //                 obscured=false;
                  //               }
                  //               else{
                  //                 obscured=true;
                  //               }
                  //             });
                  //
                  //           },
                  //           child: Icon(Icons.remove_red_eye,size: 20,),
                  //         ),
                  //         hintText: "Password",
                  //         hintStyle: GoogleFonts.getFont('Montserrat',fontWeight: FontWeight.w400,fontSize: 15),
                  //       ),
                  //     )
                  // ),
                  // Container(
                  //     width: MediaQuery.of(context).size.width*0.8,
                  //     child: TextField(
                  //       controller: passwordConfirm,
                  //       obscureText: obscured,
                  //       style:GoogleFonts.getFont('Montserrat',fontWeight: FontWeight.w400,fontSize: 15),
                  //       decoration: InputDecoration(
                  //         suffix: FlatButton(
                  //           onPressed: (){
                  //             setState(() {
                  //               if(obscured==true){
                  //                 obscured=false;
                  //               }
                  //               else{
                  //                 obscured=true;
                  //               }
                  //             });
                  //
                  //           },
                  //           child: Icon(Icons.remove_red_eye,size: 20,),
                  //         ),
                  //         hintText: "Confirm Password",
                  //         hintStyle: GoogleFonts.getFont('Montserrat',fontWeight: FontWeight.w400,fontSize: 15),
                  //       ),
                  //     )
                  // ),
                  // SizedBox(height: 20,),
                  // Container(
                  //   padding: EdgeInsets.only(left:25),
                  //   child: Row(
                  //     mainAxisAlignment: MainAxisAlignment.start,
                  //     children: <Widget>[
                  //       RaisedButton(
                  //         color: Colors.white,
                  //         onPressed: ()async{
                  //
                  //
                  //           if(
                  //           email.value!=TextEditingValue.empty
                  //           &&
                  //           password.value!=TextEditingValue.empty
                  //           &&
                  //           passwordConfirm.value!=TextEditingValue.empty
                  //           ){
                  //             print(email.value.text);
                  //             print(password.value.text);
                  //
                  //             try{
                  //               var emailValue=email.value.text.trim();
                  //               var passwordValue=password.value.text.trim();
                  //               FirebaseApp defaultApp = await Firebase.initializeApp();
                  //               FirebaseAuth auth=FirebaseAuth.instance;
                  //               UserCredential credentials=await auth.createUserWithEmailAndPassword(email: emailValue, password: passwordValue);
                  //               print(auth.currentUser.uid);
                  //               User user = FirebaseAuth.instance.currentUser;
                  //               await setUserDetails(
                  //                   user.uid,
                  //                   name: user.displayName,
                  //                   email: user.email,
                  //                   profile: user.photoURL,
                  //                   phone: user.phoneNumber
                  //               );
                  //               setUserDetails(auth.currentUser.uid.toString(),email: emailValue.toString());
                  //
                  //               print("LOGGED IN");
                  //
                  //               Navigator.push(
                  //                   context,
                  //                   MaterialPageRoute(builder: (context){
                  //                     return mainPage();
                  //                   })
                  //               );
                  //
                  //             }
                  //
                  //             catch(e){
                  //
                  //
                  //               Alert(
                  //                 context: context,
                  //                 title: "ERROR",
                  //                 desc:e.message,
                  //               ).show();
                  //
                  //
                  //               // showDialog(context: context,builder: (context){
                  //               //   return Scaffold(
                  //               //     body: Center(
                  //               //         child: Text(
                  //               //           "${e.toString()}",
                  //               //           style: TextStyle(fontSize: 50),
                  //               //         )
                  //               //     ),
                  //               //   );
                  //               // });
                  //             }
                  //
                  //           }
                  //           else{
                  //             Scaffold.of(context).showSnackBar(
                  //                 SnackBar(
                  //                   backgroundColor: Colors.red,
                  //                   content: Text("Please Enter Email and Password"),
                  //                 )
                  //             );
                  //           }
                  //
                  //         },
                  //         elevation: 0,
                  //         child: Container(
                  //             decoration: BoxDecoration(
                  //                 color:Colors.pinkAccent,
                  //                 border: Border.all(
                  //                     color: Colors.white
                  //                 ),
                  //                 borderRadius: BorderRadius.all(Radius.circular(20))
                  //             ),
                  //             padding: EdgeInsets.all(25),
                  //             child: Icon(Icons.arrow_forward,color: Colors.white,)
                  //         ),
                  //       )
                  //     ],
                  //   ),
                  // ),
                  // SizedBox(height: 10,),
                  // SizedBox(height: 10,),

                  SizedBox(height: 20,),
                  Container(
                    padding: EdgeInsets.only(left:40),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        ButtonTheme(
                          child: RaisedButton(
                            onPressed: (){

                              Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context){
                                    return mobileEntry();
                                  })
                              );


                            },
                            color: Colors.orangeAccent,
                            elevation: 5,
                            padding: EdgeInsets.only(left:10,top:10,bottom: 10,right: 10),
                            child: Row(
                              children: <Widget>[
                                Container(
                                    margin: EdgeInsets.only(right:10),
                                    child: Icon(Icons.phone)
                                ),
                                Text("Sign Up with Phone Number")
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  // Container(
                  //   padding: EdgeInsets.only(left:40),
                  //   child: Row(
                  //     mainAxisAlignment: MainAxisAlignment.start,
                  //     children: <Widget>[
                  //       SignInButton(
                  //         Buttons.Google,
                  //         text: "Sign up with Google",
                  //         onPressed: ()async{
                  //           await GoogleSignIn().signOut();
                  //           print("signing in with google");
                  //           FirebaseApp defaultApp = await Firebase.initializeApp();
                  //           FirebaseAuth auth=FirebaseAuth.instance;
                  //           UserCredential user= await signInWithGoogle();
                  //           print("signed in");
                  //
                  //           await setUserDetails(
                  //               user.user.uid,
                  //               name: user.user.displayName,
                  //               email: user.user.email,
                  //               profile: user.user.photoURL,
                  //               phone: user.user.phoneNumber
                  //           );
                  //
                  //           Navigator.push(context, MaterialPageRoute(builder: (context){
                  //             return mainPage();
                  //           }));
                  //         },
                  //         padding: EdgeInsets.all(5),
                  //         elevation: 2,
                  //       ),
                  //     ],
                  //   ),
                  // ), //GOOGLE
                  // Container(
                  //   padding: EdgeInsets.only(left:40),
                  //   child: Row(
                  //     mainAxisAlignment: MainAxisAlignment.start,
                  //     children: <Widget>[
                  //       SignInButton(
                  //         Buttons.Facebook,
                  //         text: "Sign up with Facebook",
                  //         onPressed: ()async{
                  //             print("THIS WILL SIGN up with facebook");
                  //             await _login();
                  //         },
                  //         padding: EdgeInsets.only(left: 5,right: 5,top: 12,bottom: 12),
                  //         elevation: 5,
                  //       ),
                  //     ],
                  //   ),
                  // ),//F
                  // ACEBOOK
                  SizedBox(height: 10,),
                  Text(
                    "مدد کے لیے کال کریں",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.getFont('Montserrat',fontWeight: FontWeight.bold,fontSize: 25),
                  ),
                  FlatButton(
                    onPressed: (){
                      launch("tel:+923339400527");

                      },
                    child: Text(
                      "+923339400527",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.getFont('Montserrat',color: Colors.blueAccent,fontWeight: FontWeight.bold,fontSize: 20),
                    ),
                  )
                ],
              )

            ],
          ),
        ),
      ),
    );
  }
}
