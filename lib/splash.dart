import 'package:flutter/material.dart';
import 'homepage.dart';
import 'main.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';


class SplashScreen extends StatefulWidget {
  String uName;
  bool flag;
  SplashScreen(this.uName,this.flag);
  
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedSplashScreen(
      duration: 2000,
      splash: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
        
        Icon(Icons.location_on,size: 30,color: primaryColor,),
        SizedBox(height: 10,),
        Text("SPOTLINK",style: TextStyle(fontSize: 25,color: primaryColor,fontWeight: FontWeight.bold),),
        


      ]),
      nextScreen: widget.flag ? (MyHomePage(widget.uName)) : IntroScreen(),
      splashTransition: SplashTransition.fadeTransition,
      backgroundColor: thatDarkBlueColor,
    ),
    );
  }
}