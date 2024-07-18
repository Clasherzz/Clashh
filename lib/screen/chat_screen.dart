import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application_2/models/message.dart';
import 'package:flutter_application_2/models/user.dart';
import 'package:flutter_application_2/widgets/message_card.dart';

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
            child: StreamBuilder(
    stream: null ,
      builder: (context,snapshot){
        switch(snapshot.connectionState){
          case ConnectionState.waiting:
          case ConnectionState.none:
          //  print("after none\n");
            return Center(child:CircularProgressIndicator());
          
          case ConnectionState.active:
          case ConnectionState.done:
           List<Message> lists = [];
       
        // if(snapshot.hasData){
        //    final data = snapshot.data?.docs;
        //   lists = data?.map((e) => ChatUser.fromJson(e.data()),).toList() ?? [];
        // }
        if(lists.isNotEmpty){
        return ListView.builder(
          itemCount: lists.length,
          itemBuilder: (context,index){
            // return Text('name : ${lists[index]}');
            return MessageCard(message: lists[index]);
          },);}else{
            return const Center(child: Text("No Messages"));
          }

           
        }


       
      },

      // body: Column(
      //   children: [
      //     ChatUser(),
      //     ChatUser(),
      //   ],
      
      
      ),
          
          
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