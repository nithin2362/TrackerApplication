import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:victim_tracker/findMyStick.dart';
import 'classes.dart';
import 'splash.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'login.dart';
var val;
String userName = "Nithin",pwdd = "",uname = "";
var dBr,sharedPreferences;
List vals = [];
Color thatDarkBlueColor = Color.fromARGB(240, 9, 24, 49);
Color textColor = Colors.white;
Color primaryColor = Color.fromARGB(255, 3, 171, 107);
UserAllData userAllData = new UserAllData("man","dude","man007",false);
bool darkTheme = true;
Future <void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  sharedPreferences = await SharedPreferences.getInstance();
  dBr = await FirebaseDatabase.instance.ref();
  vals = await keepMeSignedIn();
  userName = vals[0] ?? "User";
  uname = vals[1];
  val = vals[2] ?? false;
  // val = false;
  print("Details from main page: $userName  $uname $val");
  
  runApp(
  MaterialApp(
  // home: val ? MyHomePage(vname,uname,pwdd) : Signin(),
  home: SplashScreen(uname,val),
  debugShowCheckedModeBanner: false,
  ));
  
}
Future<List> keepMeSignedIn()async
{
  String pwd,uniqueName,name;
  sharedPreferences = await SharedPreferences.getInstance();
  uniqueName = await sharedPreferences.getString("uniqueName").toString();
  name = await sharedPreferences.getString("username").toString();
  val = await sharedPreferences.getBool("Flag");
  return [name,uniqueName,val];
}

class IntroScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        return LoginForm();
      },
    );
  }
}