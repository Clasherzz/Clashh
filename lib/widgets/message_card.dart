import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application_2/apis/apis.dart';
import 'package:flutter_application_2/models/message.dart';

class MessageCard extends StatefulWidget {
  final Message message;
  const MessageCard({super.key,required this.message});

  @override
  State<MessageCard> createState() => _MessageCardState();
}

class _MessageCardState extends State<MessageCard> {
  
  @override
  Widget build(BuildContext context) {
    return APIs.me.id == widget.message.toId ? _greenMessage() : _blueMessage();
  }

  Widget _blueMessage(){
    return Row(children: [
  
      //mainAxisAlignment: MainAxisAlignment.spaceBetween
      Flexible(
      child:Container(
        padding: EdgeInsets.all(1),
        
        decoration: BoxDecoration(
          color: Colors.grey,
          border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.only(
            topLeft:Radius.circular(30) ,
            topRight: Radius.circular(30),
            bottomRight: Radius.circular(30),
          )
        ),
        child:Text(widget.message.msg)
      ),),
      Text(widget.message.sent),
    ],);


    
  }
  Widget _greenMessage(){
    return Row(children: [
  
      //mainAxisAlignment: MainAxisAlignment.spaceBetween
      Flexible(
      child:Container(
        padding: EdgeInsets.only(right: 1),
        
        decoration: BoxDecoration(
          color: Colors.green,
          border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.only(
            topLeft:Radius.circular(30) ,
            topRight: Radius.circular(30),
            bottomRight: Radius.circular(30),
          )
        ),
        child:Text(widget.message.msg)
      ),),
      Text(widget.message.sent),

    ],);
        
      
      
  }
}