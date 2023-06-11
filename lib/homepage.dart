import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:victim_tracker/liveImage.dart';
import 'main.dart';
import 'package:firebase_database/firebase_database.dart';
import 'login.dart';
import 'classes.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'weather.dart';
import 'location_details.dart';
import 'findMyStick.dart';
import 'package:geolocator/geolocator.dart';
import 'package:string_validator/string_validator.dart';

final _formKey1 = GlobalKey<FormState>();
// class GetPhoneNumbers extends StatefulWidget {
//   String uniqueName1;
//   GetPhoneNumbers(this.uniqueName1);

//   @override
//   State<GetPhoneNumbers> createState() => _GetPhoneNumbersState();
// }
// String num1 = "",num2 = "",num3 = "";
// var phone;
// class _GetPhoneNumbersState extends State<GetPhoneNumbers> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//               elevation: 0,
//               title: Text("Emergency Contact",style: TextStyle(fontSize: 25),),
//               centerTitle: true,
//               backgroundColor: thatDarkBlueColor,
//             ),
//             backgroundColor: thatDarkBlueColor,
//             body: Padding(
//               padding: const EdgeInsets.all(10.0),
//               child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Text("Provide contact numbers to send SMS alert in case of emergency",style: TextStyle(
//                         color: textColor,
//                         fontSize: 15,
//                         fontWeight: FontWeight.w400,
//                       ),),
//                       Form(
//                         key: _formKey1,
//                         child: Container(
//                           padding: EdgeInsets.all(14),
//                           child: Column(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               TextFormField(
//                               style: TextStyle(color: textColor,fontSize: 17),
//                               key: ValueKey('num1'),
//                               decoration: InputDecoration(
//                                 hintText: 'Enter your contact number',
//                                 hintStyle: TextStyle(color: Colors.white54,fontSize: 15),
//                               ),
//                               validator: (value) {
//                                 if (value!.isEmpty) {
//                                   return 'Please enter your contact number';
//                                 } 
//                                 else if(!isNumeric(value.toString()))
//                                 {
//                                   return 'Please enter a contact number';
//                                 }
//                                 else if(value.length != 8 && value.length != 10)
//                                 {
//                                   return 'Please enter a valid contact number';
//                                 }
//                                 else {
//                                   return null;
//                                 }
//                               },
//                               onSaved: (value) {
//                                 setState(() {
//                                   num1 = value!;
//                                 });
//                               },
//                             ),
            
//                       // ====== Name of the victim ====              
//                       TextFormField(
//                         style: TextStyle(color: textColor,fontSize: 17),
//                         key: ValueKey('num2'),
//                         decoration: InputDecoration(
//                           hintText: 'Enter a second contact number (Optional)',
//                           hintStyle: TextStyle(color: Colors.white54,fontSize: 15),
//                         ),
//                         validator: (value) {
//                           if(value == num1)
//                           {
//                             return 'Please enter a different contact number for each field';
//                           }
//                           return null;
//                         },
//                         onSaved: (value) {
//                           setState(() {
//                             num2 = (isNumeric(value.toString()) && (value!.length == 8 || value!.length == 10)) ? value! : "Nil";
//                           });
//                         },
//                       ),
//                       TextFormField(
//                         style: TextStyle(color: textColor,fontSize: 17),
//                         key: ValueKey('num3'),
//                         decoration: InputDecoration(
//                           hintText: 'Enter a third contact number (Optional)',
//                           hintStyle: TextStyle(color: Colors.white54,fontSize: 15),
//                         ),
//                         validator: (value) {
//                           if(value == num1 || value == num2)
//                           {
//                             return 'Please enter a different contact number for each field';
//                           }
//                           return null;
//                         },
//                         onSaved: (value) {
//                           setState(() {
//                             num3 = (isNumeric(value.toString()) && (value!.length == 8 || value!.length == 10)) ? value! : "Nil";
//                           });
//                         },
//                       ),
//                          SizedBox(height: 30,),
//                          Container(
//                         height: 55,
//                         width: double.infinity,
//                         child: ElevatedButton(
//                             onPressed: () async {
//                               if (_formKey1.currentState!.validate()) {
//                                 _formKey1.currentState!.save();
//                                 sharedPreferences = await SharedPreferences.getInstance();
//                                 await sharedPreferences.setInt("Phone", 1);
//                                 await dBr.child("Users/${widget.uniqueName1}/Phone Numbers").update({"Number 1":num1,"Number 2":num2,"Number 3":num3});
//                                 Navigator.pushAndRemoveUntil(context,
//                                 MaterialPageRoute(builder: (context) => HomePage(widget.uniqueName1)),(route)=> false);
//                                 }
                                
                                
//                                 },
//                               child: Text("Submit",style: TextStyle(color: textColor,fontSize: 18),),
//                                 ))
//                             ],
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
                  
                  
//                   ));
   
//   }
// }





class MyHomePage extends StatefulWidget {
  String uniqueName;
  MyHomePage(this.uniqueName);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

Widget textIt(String text,Color color,double size)
{
  return Text(text,style: GoogleFonts.karla(color: color,fontSize: size,fontWeight: FontWeight.bold));
}


final dBr = FirebaseDatabase.instance.ref();
// bool hasGivenPhoneNumbers = true;
class _MyHomePageState extends State<MyHomePage> {

  // var tim = Timer.periodic(const Duration(seconds:5),(timer) { });
  //bool isViewed = false;
  int _currentIndex = 0;
  @override
  void initState()
   {
    getAllFutureCommands();
    super.initState();
  }

  Future<void> getAllFutureCommands()async
  {
    var temp,lat1;
    userAllData.name = await userName;
    userAllData.uniqueName = await widget.uniqueName;
    final Snapshot = await dBr.child("Users/${widget.uniqueName}").get();
    if(Snapshot.exists && Snapshot.value != null)
    {
      temp = Snapshot.value;
      userAllData.victimName = temp["Victim name"];
      lat1 = temp["Location"]["Lat"] ?? 0.0;
      sharedPreferences = await SharedPreferences.getInstance();
      // phone = await sharedPreferences.getInt("Phone") ?? -1;
    }
    else
    {
       userAllData.victimName = "User";
    }
    if(lat1 == 0.0)
    {
      LocationPermission permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) 
      {
      
        print('Location permissions are denied');
        await dBr.child("Users/${widget.uniqueName}/Location").update({"Lat":12.96,"Lng":80.08,"Speed":0,"Satellites":0}); 
      }
      else
      {
        Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
        await dBr.child("Users/${widget.uniqueName}/Location").update({"Lat":position.latitude,"Lng":position.longitude,"Speed":position.speed,"Satellites":0}); 
      }
    }
  }
  @override
  void dispose() {
    // isViewed = true;
    // tim.cancel();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
      return WillPopScope(
        onWillPop: () async{
        showDialog(
                context: context, 
                builder: (context) => AlertDialog(
                backgroundColor: thatDarkBlueColor,
                title: Text("Exit", style: TextStyle(color: Colors.white,fontSize: 25,fontWeight: FontWeight.bold),),
                content: Text("Are you sure you want to Exit ?",style: TextStyle(color: Colors.white,fontSize: 15),),
                actions: [
                  ElevatedButton(onPressed: () => Navigator.pop(context), 
                  child: Text("No",style: TextStyle(color: Colors.white,fontSize: 15),),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor
                  ),
                  ),
                  TextButton(onPressed: (){
                    SystemNavigator.pop();
                  }, child: Text("Yes",style: TextStyle(color: primaryColor,fontSize: 15),)),
                ],
              ));
              return false;
      },
        child: FutureBuilder(
          //future: createNotificationChannel(),
          future: getAllFutureCommands(),
          builder: (context,snapshot) {
            if(snapshot.connectionState == ConnectionState.done)
            {
            // if(phone == -1)
            // {
            //   return GetPhoneNumbers(widget.uniqueName);
            // }
            return HomePage(widget.uniqueName);
            }   
            return Scaffold(
              backgroundColor: thatDarkBlueColor,
              body: Center(
                child: CircularProgressIndicator(
                  color: primaryColor,
                ),
              ),
            );
            }),
              
                        
          );
            }}


class HomePage extends StatefulWidget {
  String uniqueName;
  HomePage(this.uniqueName);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
            backgroundColor: thatDarkBlueColor,
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(80.0),
              child: AppBar(
                backgroundColor: primaryColor,
                title: Padding(
                  padding: const EdgeInsets.fromLTRB(5, 70, 50, 40),
                  child: Text("Hello ${userName}",style: GoogleFonts.karla(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          )),
                ),
                
              actions: [
                Padding(
                  padding: const EdgeInsets.only(top:20),
                  child: 
                 
                    Padding(
                          padding: const EdgeInsets.only(bottom: 15),
                          child: IconButton(icon: Icon(Icons.logout),
                          color: Colors.white,
                          iconSize: 30,
                          onPressed: () =>
                            showDialog(context: context,
                            builder: (context) =>
                            AlertDialog(
                                      backgroundColor: thatDarkBlueColor,
                                      title: Text("Logout", style: TextStyle(color: Colors.white,fontSize: 25,fontWeight: FontWeight.bold),),
                                      content: Text("Are you sure you want to Logout ?",style: TextStyle(color: Colors.white,fontSize: 15),),
                                      actions: [
                                        ElevatedButton(onPressed: () => Navigator.pop(context), 
                                        child: Text("No",style: TextStyle(color: Colors.white,fontSize: 15),),
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: primaryColor,
                                        ),
                                        ),
                                        TextButton(onPressed: () async{
                                          await sharedPreferences.setBool("Flag", false);
                                          Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => LoginForm()), (route) => false);
                                        }, child: Text("Yes",style: TextStyle(color: primaryColor,fontSize: 15),)),
                                      ],
                                      )),
                          ),
                        )),
                
              ],
              ),
            ),
            body: 
                  // _currentIndex == 0 ?
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GridView.count(
                                    crossAxisCount: 1,
                                    mainAxisSpacing: 20,
                                    crossAxisSpacing: 20,
                                    padding: EdgeInsets.all(20),
                                    children: [
                                    
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: InkWell(
                                        child: Container(
                                          
                                          decoration: BoxDecoration(color: primaryColor,
                                          borderRadius: BorderRadius.circular(20),
                                          ),
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Icon(Icons.location_on,color: Colors.white,size:50,),
                                              textIt("Location Data", Colors.white, 30),
                                            ],
                                          ),
                                          ),
                                          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => LocationPage("Users/${widget.uniqueName}/Location"))),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: InkWell(
                                        child: Container(
                                          decoration: BoxDecoration(color: primaryColor,
                                          borderRadius: BorderRadius.circular(20),
                                          ),
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Icon(Icons.sunny,color: Colors.white,size: 50,),
                                              textIt("Weather Data", Colors.white, 30),
                                            ],
                                          ),
                                          ),
                                          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => WeatherDisplay("Users/${widget.uniqueName}/Location"))),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: InkWell(
                                        child: Container(
                                          decoration: BoxDecoration(color: primaryColor,
                                          borderRadius: BorderRadius.circular(20),
                                          ),
                                          child: Center(
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Icon(Icons.image_outlined,color: Colors.white,size: 50,),
                                                textIt("Live Image", Colors.white, 30),
                                              ],
                                            ),
                                          ),
                                          ),
                                          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => ShowImage("Users/${widget.uniqueName}"))),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: InkWell(
                                        child: Container(
                                          decoration: BoxDecoration(color: primaryColor,
                                          borderRadius: BorderRadius.circular(20),
                                          ),
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Icon(Icons.info_outline,color: Colors.white,size: 50,),
                                              textIt("Alert the user", Colors.white, 30),
                                            ],
                                          ),
                                          ),
                                          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => FindMyStick(userAllData.uniqueName))),
                                      ),
                                    ),
                                  ],
                                  ),
                  ),
                  // ) : Settings(),
                  // bottomNavigationBar: BottomNavigationBar(
                  //   backgroundColor: thatDarkBlueColor,
                  //   selectedItemColor: primaryColor,
                  //   unselectedItemColor: Colors.white,
                  //   selectedFontSize: 20,
                  //   unselectedFontSize: 15,
                  //   currentIndex: _currentIndex,
                  //   type: BottomNavigationBarType.fixed,
                  //   items: [
                  //     BottomNavigationBarItem(
                  //       icon: Icon(Icons.home,size: 30,),
                  //       label: "Home",
                  //     ),
                  //     BottomNavigationBarItem(
                  //       icon: Icon(Icons.settings,size: 30,),
                  //       label: "Settings",

                  //     ),
                  //   ],
                  //   onTap: (index){
                  //     setState(() {
                  //     _currentIndex = index;
                  //     });
                  //   },
                  // ),
              );
  }
}
