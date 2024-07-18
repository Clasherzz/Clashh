import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
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
    return const Placeholder();
  }

  Widget _blueMessage(){
    return Row(children: [
      Container(
        
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft:Radius.circular(30) ,
            topRight: Radius.circular(30),
            bottomRight: Radius.circular(30),
          )
        ),
        child:Text(widget.message.msg)
      )
    ],)
  }
}