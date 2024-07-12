import 'dart:async';
import 'dart:core';


import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_2/models/user.dart';
class APIs{
  static FirebaseAuth auth = FirebaseAuth.instance;
  
  
  static FirebaseFirestore firestore = FirebaseFirestore.instance;
  static User get user => auth.currentUser!;


  static Future<bool> userExists() async {
    return (await firestore
    .collection("users")
    .doc(user.uid)
    .get())
    .exists;

  }

  static Future<void> createUser() async {
    final time = DateTime.now().millisecondsSinceEpoch.toString();
    final chatUser = ChatUser(
      image: user.photoURL.toString(), 
      about: '', 
      name: user.displayName.toString(), 
      createdAt: time, 
      isOnline: false, 
      id: user.uid, 
      lastActive: time, 
      email: user.email.toString(), 
      pushToken: ''
    );
    
    
    return (await firestore
    .collection("users")
    .doc(user.uid)
    .set(chatUser.toJson()))
    ;

  }

}