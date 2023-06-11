import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:firebase_database/firebase_database.dart';
import 'location_details.dart';
import 'main.dart';
import 'dart:async';
import 'package:google_fonts/google_fonts.dart';
final dBr = FirebaseDatabase.instance.ref();

String base64String = "",timeStamp = "Nil",location1 = "Data not found",date = "Nil",time24 = "Nil";
var temp;
int alert = 0;
class ShowImage extends StatefulWidget {
  String path;
  ShowImage(this.path);
  @override
  State<ShowImage> createState() => _ShowImageState();
}

class _ShowImageState extends State<ShowImage> {
  // var tim = Timer.periodic(Duration(seconds: 5), (timer){});
  // @override
  // void initState() {
  //   if(alert)
  //   {
  //     tim = Timer.periodic(Duration(seconds: 5), (timer)async{ 
  //       await getImage();
  //       setState(() {
  //       });
  //     });
  //   }
  //   super.initState();
  // }
  
  // @override
  // void dispose() {
  //   tim.cancel();
  //   super.dispose();
  // }
  String getTimeData(String timeStamp)
  {
    if(timeStamp == "Nil")
      return "Nil";
    String data = "";
    String meridian = "";
    int hr = int.parse(timeStamp.substring(0,2));
    if(hr > 12)
    {
      meridian = " P.M.";
      hr -= 12;
    }
    else if(hr == 0)
    {
      meridian = " A.M.";
      hr = 12;
    }
    else
    {
      meridian = " A.M.";
    }
    data = (hr < 10 ? "0":"") +  hr.toString() + timeStamp.substring(2) + meridian;
    return data;    
  }
  
  @override
  Future<void>getImage()async
  {
    final snapshot = await dBr.child(widget.path).get();
    if(snapshot.exists && snapshot.value != null)
    {
      temp = snapshot.value;
      base64String = temp["Photo"] ?? "";
      timeStamp = temp["Timestamp"] ?? "Nil";
      alert = temp["Panic"] ?? 0;
      location1 = temp["Location"]["Place"] ?? "Data not found"; 
      try
      {
        date = timeStamp.substring(8,10) + "-" + timeStamp.substring(5,7) + "-" + timeStamp.substring(0,4);
        time24 = timeStamp.substring(11,19);
      }
      catch(e)
      {
        print("Timestamp: " + timeStamp);
      }
    }
    else
    {
      print("Unable to fetch image data");
    }
  }
  
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getImage(),
      builder: (context,snapshot) {
        if(snapshot.connectionState == ConnectionState.done)
        {return Scaffold(
          backgroundColor: thatDarkBlueColor,
          appBar: AppBar(
            backgroundColor: primaryColor,
            title:Text("Image",style: GoogleFonts.karla(
              color:textColor,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),),
            centerTitle: true,
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(alert == 2 ? "Alert !!!":"",style: GoogleFonts.karla(
                color: Colors.red,
                fontSize: 30,
                fontWeight: FontWeight.bold
              )),
              Container(
                child: (base64String == null || base64String == "-FAIL-" || base64String == "") ?  Container(color: Colors.red,child: Center(child: Text("Unable to get Image data",style: GoogleFonts.karla(
                color:textColor,
                fontSize: 20,
              ),)),) : Image.memory(base64Decode(base64String),height: 400,width: 900,fit: BoxFit.fitWidth),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 25),
                child: Text("Date: " + date ,style: GoogleFonts.karla(
                  color:textColor,
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                ),),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Text("Time: " + ((time24 != "Nil" && time24.length > 3) ? getTimeData(time24) : "Nil"),style: GoogleFonts.karla(
                  color:textColor,
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                ),),
              ),
              Text("Location: $location1",style: GoogleFonts.karla(
                color:textColor,
                fontSize: 20,
                fontWeight: FontWeight.w400,
              ),),
              // ElevatedButton(
              // onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => LocationPage(widget.path + "/Location"))), 
              // child: Text("Go to location page",style: GoogleFonts.karla(
              //     color:textColor,
              //     fontSize: 15,
              //   ),),
              //   style: ElevatedButton.styleFrom(
              //     backgroundColor: Colors.red,
              //   ))
              ElevatedButton(onPressed: ()async{
                if(alert == 2)
                {
                  await dBr.child(widget.path).update({"Panic":0});  
                }
              await dBr.child(widget.path).update({"Trigger":true});
              int i = 0;
              await getImage();
              await Future.delayed(Duration(seconds: 3),() => setState(() {}));
              },
              child: Text(alert == 2 ? "Stop Alert" : "Refresh Image",style: GoogleFonts.karla(
                color: textColor,
                fontSize: 20,
              ),),
              style: ElevatedButton.styleFrom(
                backgroundColor: alert == 2 ? Colors.red : primaryColor,

              ),
              ),
            ]
          ),
          // floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
          // floatingActionButton: FloatingActionButton(
          //   child: !alert ? Icon(Icons.refresh,color: textColor,size: 25,) : Text("Stop auto refresh"),
          //   backgroundColor: primaryColor,
          //   onPressed: ()async{
          //     if(alert)
          //     {
          //       await dBr.child(widget.path).update({"Panic":false});  
          //     }
          //     await dBr.child(widget.path).update({"Trigger":true});
          //     int i = 0;
          //     await getImage();
          //     await Future.delayed(Duration(seconds: 3),() => setState(() {}));
          //   },
          // ),
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