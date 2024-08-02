import 'dart:async';
import 'dart:core';
import 'dart:developer';
import 'dart:io';


import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_application_2/models/message.dart';
import 'package:flutter_application_2/models/user.dart';
class APIs{
  static FirebaseAuth auth = FirebaseAuth.instance;
  
  
  static FirebaseFirestore firestore = FirebaseFirestore.instance;

  static FirebaseStorage firebaseStorage = FirebaseStorage.instance;

  static User get user => auth.currentUser!;

  static late ChatUser me;
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
  
  static Future<void> getSelfInfo() async{
      await firestore.collection("users").doc(user.uid).get().then((user) async {
        if(user.exists){
            me = ChatUser.fromJson(user.data()!);
        }else{
          await createUser().then((value)=>{
            getSelfInfo()
          }
          
          );

        }
      });
  }

  static Future<void> updateUserInfo() async{
    await firestore.collection("users").doc(user.uid).update(
      {
        "name":me.name,
        "about":me.about
      }
    );
  }



  static Future<void> updateProfile(File file) async{
    final ext = file.path.split('.').last;
    final ref = firebaseStorage.ref().child('profilePictures/${user.uid}.${ext}');
    await ref.putFile(file,).then((p)=>{
      log("completion: ${p}/1000")
    });

    me.image =await  ref.getDownloadURL();
    await firestore.collection("users").doc(user.uid).update(
      {
        "image":me.image
      }
    );
  }

  static String getConversationId(String id){
    return user.uid.hashCode <= id.hashCode ? '${user.uid}_${id}' : '${id}_${user.uid}';
  }

  static Stream<QuerySnapshot<Map<String,dynamic>>> getAllMessages(ChatUser chatUser) {
    return  firestore.collection('chats/${getConversationId(chatUser.id)}/messages').snapshots();
  } 

  static Future<void> sendMessage(ChatUser chatUser,String chatMessage)async{
    final time =DateTime.now().millisecondsSinceEpoch.toString();
    
    
    final Message message = Message(
      fromId:user.uid ,
      msg: chatMessage,
      read:"",
      type:Type.text,
      toId: chatUser.id,
      sent: time
    );

    print("fromid:${message.fromId}touserid:${message.toId}");


    final ref = firestore.collection('chats/${getConversationId(chatUser.id)}/messages');
    await ref.doc(time).set(message.toJson());


  }


  // static Future<void> sendChatImage(ChatUser chatuser,File file){
  //    var ref = 
  // }
  static Future<void> sendChatImage(ChatUser chatUser,File file) async{
    final ext = file.path.split('.').last;
    final ref = firebaseStorage.ref().child('image/${getConversationId(chatUser.id)}/${DateTime.now().millisecondsSinceEpoch.toString()}.${ext}');
    await ref.putFile(file,).then((p)=>{
      log("completion: ${p}/1000")
    });

    me.image =await  ref.getDownloadURL();
    await firestore.collection("users").doc(user.uid).update(
      {
        "image":me.image
      }
    );
  }





  static Stream<QuerySnapshot<Map<String,dynamic>>>   getUserInfo(ChatUser chatUser){
    return firestore.collection("users").where("id",isEqualTo: chatUser.id).snapshots();
  }

  static Future<void> updateActiveStatus(bool isOnline) async{
    firestore.collection("users").doc(user.uid).update({'is_online':isOnline,"last_active":DateTime.now().millisecondsSinceEpoch.toString()});
  }
  

   static Stream<QuerySnapshot<Map<String,dynamic>>>   getLastMessage(ChatUser chatUser){
    return firestore.collection("chats/${getConversationId(chatUser.id)}/messages").limit(1).snapshots();
   }

  
}