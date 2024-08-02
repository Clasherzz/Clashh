
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application_2/apis/apis.dart';
import 'package:flutter_application_2/main.dart';
import 'package:flutter_application_2/models/message.dart';
import 'package:flutter_application_2/screen/chat_screen.dart';
import '../models/user.dart';


class ChatUserCard extends StatefulWidget {
  final ChatUser user;
  const ChatUserCard({super.key,required this.user});

  @override
  State<ChatUserCard> createState() => _ChatUserCardState();
}

class _ChatUserCardState extends State<ChatUserCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      // child:StreamBuilder(
      // stream: APIs.getLastMessage(widget.user), 
      
      // builder: (context,snapshot){
      // final data = snapshot.data?.docs;
      // late Message _message;
      // if(data!=null && data.first.exists){
      //   _message = Message.fromJson(data.first.data());
      // }
      // return ListTile(
      //   onTap: (){
      //       print("at Usercard${widget.user.id}");
      //       Navigator.push(context,MaterialPageRoute(builder: (_) => ChatScreen(user: widget.user) ));

      //   },


      //   // 
      //   leading: ClipRRect(
      //     borderRadius: BorderRadius.circular(10),
      //   child: CachedNetworkImage(
      //     // width:mq.width * 0.055,
      //     // height: mq.height*0.055,
      //     imageUrl: "https://www.google.com/search?q=pictures&sca_esv=a835f771045fe61e&sca_upv=1&rlz=1C1VDKB_enIN1022IN1022&sxsrf=ADLYWIKPN2556JvP6OKj48qkkKLRUl9D7A:1721219669183&udm=2&source=iu&ictx=1&vet=1&fir=tYmxDgFq4MrkJM%252C-t22bY2ix3gHaM%252C%252Fm%252F0jg24%253BsKMM4eBjWSQEBM%252CB51x0PBR9KNzvM%252C_%253BL78jAzIbPtQBcM%252CbnFH7L5A1JFCTM%252C_%253BScnmyk9jYFSBNM%252CE-_aOwFp15AeLM%252C_%253BuJ0dNAI72KR-NM%252CIaGVCB8zjywltM%252C_%253BlfWnW2IEnhbPvM%252CePjCKhFm09p5bM%252C_%253Bc_k0XZB-zd8bBM%252CqMZ3UDNPbU6AlM%252C_&usg=AI4_-kTs2JcVvVzzCwrvJa83_cAtp_Z2Pg&sa=X&ved=2ahUKEwj30tj3iq6HAxVtyjgGHT9VAE4Q_B16BAgmEAE#vhid=tYmxDgFq4MrkJM&vssid=mosaic",
      //     placeholder: (context,url)=>  const CircularProgressIndicator(),
      //     errorWidget: (context,url,error)=>const Icon(Icons.error),
      //     ),

      //   ),
      //   title: Text(widget.user.name),


      //   subtitle: Text(widget.user.about,maxLines: 1,),


        
      //   trailing:  Container(
      //     width: 15,
      //     height:15,
      //     decoration: BoxDecoration(color: Colors.greenAccent,borderRadius: BorderRadius.circular(10)),

      //   ),
      // );})
      
      child: ListTile(
        onTap: (){
            print("at Usercard${widget.user.id}");
            Navigator.push(context,MaterialPageRoute(builder: (_) => ChatScreen(user: widget.user) ));

        },


        // 
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(10),
        child: CachedNetworkImage(
          // width:mq.width * 0.055,
          // height: mq.height*0.055,
          imageUrl: "https://www.google.com/search?q=pictures&sca_esv=a835f771045fe61e&sca_upv=1&rlz=1C1VDKB_enIN1022IN1022&sxsrf=ADLYWIKPN2556JvP6OKj48qkkKLRUl9D7A:1721219669183&udm=2&source=iu&ictx=1&vet=1&fir=tYmxDgFq4MrkJM%252C-t22bY2ix3gHaM%252C%252Fm%252F0jg24%253BsKMM4eBjWSQEBM%252CB51x0PBR9KNzvM%252C_%253BL78jAzIbPtQBcM%252CbnFH7L5A1JFCTM%252C_%253BScnmyk9jYFSBNM%252CE-_aOwFp15AeLM%252C_%253BuJ0dNAI72KR-NM%252CIaGVCB8zjywltM%252C_%253BlfWnW2IEnhbPvM%252CePjCKhFm09p5bM%252C_%253Bc_k0XZB-zd8bBM%252CqMZ3UDNPbU6AlM%252C_&usg=AI4_-kTs2JcVvVzzCwrvJa83_cAtp_Z2Pg&sa=X&ved=2ahUKEwj30tj3iq6HAxVtyjgGHT9VAE4Q_B16BAgmEAE#vhid=tYmxDgFq4MrkJM&vssid=mosaic",
          placeholder: (context,url)=>  const CircularProgressIndicator(),
          errorWidget: (context,url,error)=>const Icon(Icons.error),
          ),

        ),
        title: Text(widget.user.name),


        subtitle: Text(widget.user.about,maxLines: 1,),


        
        trailing:  Container(
          width: 15,
          height:15,
          decoration: BoxDecoration(color: Colors.greenAccent,borderRadius: BorderRadius.circular(10)),

        ),
      ),
    );
  }
}