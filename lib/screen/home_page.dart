import 'package:flutter/material.dart';
import 'package:flutter_application_2/apis/apis.dart';
import 'package:flutter_application_2/widgets/chat_user_card.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
 

  @override
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
           final lists = [];
       
        if(snapshot.hasData){
           final data = snapshot.data?.docs;
          for(var i in data!){
            lists.add(i.data()['name']);
          }
        }
        return ListView.builder(
          itemCount: lists.length,
          itemBuilder: (context,index){
            return Text('name : ${lists[index]}');
          },);

           
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