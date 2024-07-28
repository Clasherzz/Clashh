import 'package:flutter/material.dart';
import 'package:flutter_application_2/firebase_options.dart';
import 'package:flutter_application_2/screen/auth/login_screen.dart';
import 'package:flutter_application_2/screen/home_page.dart';
import 'package:flutter_application_2/screen/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
// import 'firebase_options.dart';
late var mq;

void main() async{
    WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
);

 // print(user.uid);




  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
       
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
     home: const MyHomePage(),
  // home: const LoginScreen(),
    
    );
  }
}
