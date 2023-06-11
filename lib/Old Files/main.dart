import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

Color textColor = Colors.white,backgroundColor = Color.fromARGB(255, 2, 22, 35);
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
      ),
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Column(
        children: [
          // Container(
          //     child:  Column(
          //         mainAxisAlignment: MainAxisAlignment.start,
          //         children: [
          //           Image.asset("assets/woodBackground.jpg"),
          //         ]
          //     )
          // ),
          Container(
            padding: EdgeInsets.all(20.0),
            alignment: Alignment.bottomLeft,
            //color: Color.fromARGB(255, 252, 166, 60),
            color: Color.fromARGB(255, 3, 171, 107),
            // decoration: BoxDecoration(color: Colors.orangeAccent,
            //   borderRadius: BorderRadius.circular(20),
            height: 150,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Hello, Nithin!",style: GoogleFonts.karla(
                  color: textColor,
                  fontSize: 27,
                  fontWeight: FontWeight.bold,
                )),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    //color: Color.fromARGB(169, 252, 166, 60),
                    color: Color.fromARGB(184, 5, 208, 130),
                  ),
                  child: IconButton(icon: Icon(Icons.logout),
                  color: Colors.white,
                  iconSize: 30,
                  onPressed: (){
                    
                  },),
                ),
              ],
            ),
    ),

        Padding(
          padding: EdgeInsets.fromLTRB(30, 200, 30, 50),
          child: Container(
            child: Text("Hey, there ! This is the place where text is gonna lie",style: GoogleFonts.karla(
              color: textColor,
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),),
            
          ),
        ),

        ],
      ),
    );
  }
}
