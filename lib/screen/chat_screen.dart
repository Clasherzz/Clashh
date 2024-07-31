import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application_2/main.dart';
import 'package:flutter_application_2/models/message.dart';
import 'package:flutter_application_2/models/user.dart';
import 'package:flutter_application_2/widgets/message_card.dart';
import 'package:image_picker/image_picker.dart';

class ChatScreen extends StatefulWidget {
  final ChatUser user;
  const ChatScreen({super.key,required this.user});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _textcontroller = TextEditingController();
//   int width = mq.width;
// double height = mq.size.height;
  @override
  Widget build(BuildContext context) {
   // mq = MediaQuery.sizeOf(context);
    return SafeArea(
      child:Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey,
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

      
      
      
      ),
          
          
          ),
          
          _chatInput()]
     ),
    
    ),
    );
  }

  Widget _appBar(){

    return InkWell(
      onTap: (){Navigator.pop(context);},
    
    child: Row(children: [
      IconButton(onPressed: (){
        Navigator.pop(context);
      }, 
      icon: Icon(Icons.arrow_back)),
       
       ClipRRect(
          borderRadius: BorderRadius.circular(10),
        child: CachedNetworkImage(
        //   width:mq.width * 0.055,
        //  height: mq.height * 0.055,
         width: 1,
         height:1,
          imageUrl: "https://images.app.goo.gl/Aaw1bYY4cBVs3Dbw8",
          placeholder: (context,url)=>  const CircularProgressIndicator(),
          errorWidget: (context,url,error)=>const Icon(Icons.error),
          ),

          

        ),

        SizedBox(width:9),

        Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.user.name,
                style: TextStyle(
                  fontWeight: FontWeight.normal
                ),),
                SizedBox(height: 2,),
                Text("Not available")


          ],)
    ],),);
  }

  Widget _chatInput(){
    final _textcontroller = TextEditingController();
    return Card( 
    shadowColor: Colors.grey,
    child:Row(children: [
     
      IconButton(
        onPressed: (){}, 
        icon: Icon(Icons.emoji_emotions),
        color: Colors.grey,
      ),
       Expanded(
        child:  TextField(
          keyboardType: TextInputType.multiline,
          maxLines:null,
          controller: _textcontroller ,
          decoration: InputDecoration(
            hintText: "Enter the chat",
            border: InputBorder.none
          ),

       ),),
      IconButton(
        onPressed: () async{
            debugPrint("hello");
             final ImagePicker picker = ImagePicker();
                  final XFile? image = 
                    await picker.pickImage(source: ImageSource.gallery);
                    if(image!=null){
                      print("entered:${image.path}");
                      Navigator.pop(context);
                    }else{
                      print("not");
                    }
        }, 
        icon: Icon(Icons.image),
        color: Colors.grey,
      ),
      IconButton(
        onPressed: ()async{
           final ImagePicker picker = ImagePicker();
                  final XFile? image = 
                    await picker.pickImage(source: ImageSource.camera);
                    if(image!=null){
                      debugPrint("Camera:${image.path}");
                    //  Navigator.pop(context);
                    }

        }, 
        icon: Icon(Icons.camera_alt_rounded),
        color: Colors.grey,
      ),
      MaterialButton(
        onPressed: () {

        } ,
        
        child: Icon(
          Icons.send,


        )
      
      )
      

    ],),);
  }
}