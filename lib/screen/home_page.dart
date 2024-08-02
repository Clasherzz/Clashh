import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_2/apis/apis.dart';
import 'package:flutter_application_2/main.dart';
import 'package:flutter_application_2/models/user.dart';
import 'package:flutter_application_2/screen/auth/login_screen.dart';
import 'package:flutter_application_2/screen/profile_screen.dart';
import 'package:flutter_application_2/widgets/chat_user_card.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
   List<ChatUser> lists = [];
   final List<ChatUser> _searchList = [];
    bool _isSearching = false;

  @override
  Widget build(BuildContext context) {
   // mq = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
       
        title:_isSearching ?
        TextField(
          onChanged: (value) => {
            _searchList.clear(),
            for(ChatUser val in lists){
              if(val.name.toLowerCase().contains(value.toLowerCase())||val.email.toLowerCase().contains(value.toLowerCase())){
                _searchList.add(val)
              },
              setState(() {
                _searchList;
              })
            }
          },
          decoration: InputDecoration(
            hintText: "Enter name or email",
            border: InputBorder.none,
           
            
            
          ),
          autofocus: true,
           

          ):Text("CLASH"),
          
        
        leading:Icon(Icons.home),
        actions: [
          IconButton(onPressed: (){
            setState(() {
             _isSearching = ! _isSearching;
            });

          }, icon: Icon(_isSearching ? Icons.cancel:Icons.search)),
          
          IconButton(
  onPressed: () async {
    // Get the current user
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      await APIs.getSelfInfo();
      // User is logged in, navigate to the Profile screen
      Navigator.push(
        
        context,
        MaterialPageRoute(
          builder: (_) => ProfileScreen(user: APIs.me),
        ),
      );
    } else {
      // User is not logged in, navigate to the Login screen
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => LoginScreen(),
        ),
      );
    }
  },
  icon: Icon(Icons.settings),
)


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
          itemCount:_isSearching ? _searchList.length : lists.length,
          
          itemBuilder: (context,index){
            // return Text('name : ${lists[index]}');
            return _isSearching ? ChatUserCard(user: _searchList[index]):ChatUserCard(user: lists[index]);
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