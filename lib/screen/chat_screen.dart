import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application_2/models/user.dart';

class ChatScreen extends StatefulWidget {
  final ChatUser user;
  const ChatScreen({super.key,required this.user});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        flexibleSpace: _appBar(),

      ),
      body: Column(
        children: [
          Expanded(
            child: 
          
          
          ),
          
          _chatInput()]
      ),
    );
  }

  Widget _appBar(){
    return Row(children: [
      IconButton(onPressed: (){}, 
      icon: Icon(Icons.arrow_back))
    ],);
  }

  Widget _chatInput(){
    return Row(children: [
      IconButton(onPressed: (){}, 
      icon: Icon(Icons.arrow_back))
    ],);
  }
}