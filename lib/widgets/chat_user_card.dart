import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ChatUser extends StatefulWidget {
  const ChatUser({super.key});

  @override
  State<ChatUser> createState() => _ChatUserState();
}

class _ChatUserState extends State<ChatUser> {
  @override
  Widget build(BuildContext context) {
    return Card(
      
      child:ListTile(
        onTap: (){},


        leading: CircleAvatar(child:Icon(Icons.person)),


        title: Text("username"),


        subtitle: Text("last seen"),
        
        trailing:  Text("12PM"),
      )
    );
  }
}