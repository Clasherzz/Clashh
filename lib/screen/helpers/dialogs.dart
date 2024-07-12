import 'package:flutter/material.dart';

class Dialogs{
  static void showSnackar(BuildContext context,String msg){
     ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg)),
     //   behavior:SnackBarBehavior.floating,
        );
  }

  static void progressBar(BuildContext context){
    showDialog(context: context, builder: (_)=>
    
      CircularProgressIndicator()
    );

  }
}