
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_application_2/apis/apis.dart';
import 'package:flutter_application_2/main.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<LoginScreen> {
  @override
   Future<UserCredential?> _signInWithGoogle() async {
    try{
      await InternetAddress.lookup("google.com");
  // Trigger the authentication flow
  final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

  // Obtain the auth details from the request
  final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

  // Create a new credential
  final credential = GoogleAuthProvider.credential(
    accessToken: googleAuth?.accessToken,
    idToken: googleAuth?.idToken,
  );
  print("try\n");
  return await APIs.auth.signInWithCredential(credential);
    }catch(e){
      print("error\n");
      print(e);
    }
   }

  void _signIn()async{
    _signInWithGoogle().then((user){
      print("after then\n");
      print(user?.credential);
      Navigator.pop(context);
    });
  }
  Widget build(BuildContext context) {
  
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("CLASH"),
        leading: Icon(Icons.home),
        actions: [
          IconButton(onPressed: (){}, icon: Icon(Icons.search)),
          IconButton(onPressed: (){}, icon: Icon(Icons.settings)),

        ],

      ),
      body:Column(
        children: [
          Image.asset('./assets/logo.png'),
          ElevatedButton.icon(

            onPressed:  (){
              _signIn();
            }, 
          label:Text("LOGIN USING GOOGLE ACCOUNT",
          style: TextStyle(color: Colors.black),),
           icon: Image.asset('./assets/google.png',fit: BoxFit.cover,),
           )
        ],
      )
    );
  }
}