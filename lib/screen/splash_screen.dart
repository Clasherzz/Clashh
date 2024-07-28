import 'package:flutter/material.dart';
import 'package:flutter_application_2/main.dart';
import 'package:flutter_application_2/screen/home_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  
  @override
  void initState(){
    super.initState();
    Future.delayed(const Duration(milliseconds: 1500),(){
      // ignore: use_build_context_synchronously
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=> const MyHomePage()));
    });
  }
  
  
  Widget build(BuildContext context) {
    mq = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: mq/5,),
          Image.asset('./assets/logo.png'),
          SizedBox(height: mq/10),
          Text("An minimalistic messaging app by K Govind",
          textAlign: TextAlign.center,
          
          style: TextStyle(fontWeight:FontWeight.bold),)
        ],
      ),
    );
  }
}