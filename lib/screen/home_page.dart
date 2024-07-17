import 'package:flutter/material.dart';
import 'package:flutter_application_2/apis/apis.dart';
import 'package:flutter_application_2/models/user.dart';
import 'package:flutter_application_2/screen/profile_screen.dart';
import 'package:flutter_application_2/widgets/chat_user_card.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
   List<ChatUser> lists = [];
 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("CLASH"),
        leading: Icon(Icons.home),
        actions: [
          IconButton(onPressed: (){}, icon: Icon(Icons.search)),
          IconButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (_)=> ProfileScreen(  user: APIs.me)));
          }, icon: Icon(Icons.settings)),

        ],
      ), 
      body:StreamBuilder(
      stream: APIs.firestore.collection("users").snapshots() ,
      builder: (context,snapshot){
        switch(snapshot.connectionState){
          case ConnectionState.waiting:
          case ConnectionState.none:
            print("after none\n");
            return Center(child:CircularProgressIndicator());
          
          case ConnectionState.active:
          case ConnectionState.done:
           
       
        if(snapshot.hasData){
           final data = snapshot.data?.docs;
          lists = data?.map((e) => ChatUser.fromJson(e.data()),).toList() ?? [];
        }
        if(lists.isNotEmpty){
        return ListView.builder(
          itemCount: lists.length,
          itemBuilder: (context,index){
            // return Text('name : ${lists[index]}');
            return ChatUserCard(user: lists[index]);
          },);}else{
            return const Center(child: Text("No contacts"));
          }

           
        }


       
      }

      // body: Column(
      //   children: [
      //     ChatUser(),
      //     ChatUser(),
      //   ],
      
      
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black12,
        onPressed: (){},child: Icon(Icons.add_comment),),
    );
  }
}