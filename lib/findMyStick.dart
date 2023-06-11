import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:google_fonts/google_fonts.dart';
import 'main.dart';


class FindMyStick extends StatefulWidget {
  String uniqueName;
  FindMyStick(this.uniqueName);

  @override
  State<FindMyStick> createState() => _FindMyStickState();
}
bool _isButtonPressed = false;
int alertLevel = 0;
final dBr = FirebaseDatabase.instance.ref();
var temp;
class _FindMyStickState extends State<FindMyStick> {
String title = "Alert";
  
  Future<void> getStickData() async{
    var snapshot = await dBr.child("Users/${widget.uniqueName}").get();
    if(snapshot.exists && snapshot.value != null)
    {
      temp = snapshot.value;
      alertLevel = temp["Panic"];
      print("Alert level: " + alertLevel.toString());
      _isButtonPressed = alertLevel > 0;
    }
  }
  
  
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getStickData(),
      builder: (context, snapshot) {
        if(snapshot.connectionState == ConnectionState.done)
         { return Scaffold(
        appBar: AppBar(
          backgroundColor:  primaryColor,
          title: Text(title ,style: GoogleFonts.karla(
            fontSize: 20,
            color: Colors.white,
          ),),
          centerTitle: true,
        ),
        backgroundColor: thatDarkBlueColor,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: 
            
            [
              AvatarGlow(
                animate: _isButtonPressed,
                glowColor: primaryColor,
                duration: const Duration(milliseconds: 2000),
                repeatPauseDuration: const Duration(microseconds: 100),
                repeat: true,
                 endRadius: 200.0,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Container(
                    height: 200,
                    width: 200,
                    child: FittedBox(
                      child: FloatingActionButton(
                        focusColor: Colors.yellow,
                        backgroundColor: primaryColor,
                        foregroundColor: Colors.red,
                        child: const Icon(Icons.info_outline,color: Colors.white,size: 50,),
                        onPressed: () async{
                          setState(() {
                          _isButtonPressed = !_isButtonPressed;
                          alertLevel = alertLevel == 0 ? 1 : 0;
                        });
                          if(alertLevel == 0)
                            await dBr.child("Users/${widget.uniqueName}").update({"Panic":0});
                          else {
                            await dBr.child("Users/${widget.uniqueName}").update({"Panic":1});
                          }
                          
                      },),
                    ),
                      ),
                )),
                 Padding(
                   padding: EdgeInsets.only(left: 50,right: 40),
                   child: Text(
                    alertLevel == 1 ? "ALERTING THE USER..." : "Click the button to turn ON stick buzzer and alert the User",
                    style: GoogleFonts.karla(
                      color:Colors.white,
                      fontSize: 30,
                    ),
                   ),
                 ),
            ],
          ),
        ),
      );
         }
        return Scaffold(
            backgroundColor: thatDarkBlueColor,
            body: Center(
              child: CircularProgressIndicator(
                color: primaryColor,
              ),
            ),
          );
      },
    
    );
  }
}