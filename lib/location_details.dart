import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'main.dart';
import 'wait.dart';
import 'homepage.dart';
import 'package:http/http.dart';
import 'dart:convert';
import 'dart:async';
import 'package:url_launcher/url_launcher.dart';

class LocationPage extends StatefulWidget {
  String path;
  LocationPage(this.path);

  @override
  State<LocationPage> createState() => _LocationPageState();
}

String cityName = "Nil",stateName = "Nil",direction = "Nil",satellites = "Nil",placeType = "Nil";
DateTime lastViewed = DateTime.now();
String locationApi = "qNwNMrL7uXXS4MfRhdGcFpixBWQGTWbC";
double speed = 0.0;
//String locationApi = "AI42DHJnuEZmCYWcGAKfB3NKdYCdAX9j";
var lat = 12.89,lng = 79.08;
Widget textIt(String text,Color color,double size)
{
  return Text(text,style: TextStyle(color: color,fontSize: size));
}
Future<void> getData(String path)async
{
  await Firebase.initializeApp();
  final dBr = FirebaseDatabase.instance.ref();
  // //var path1 = null;
  // print("Path: $path");
  // print("Check1");
  var temp,temp1;
  final snap = await dBr.child(path).get();
  if(snap.exists && snap.value != null)
  {
    temp = snap.value;
    speed = double.parse(temp["Speed"].toStringAsFixed(2));
    direction = temp["Direction"] ?? "Nil";
    satellites = temp["Satellites"].toString();
    
    lastViewed = DateTime.parse(temp["Last Viewed"].toString());
    lat = temp["Lat"];
    lng = temp["Lng"];
  }
  else
    {
      print("Data fetch failed in location.dart...");
      return;
    }
  int timeDifference = await DateTime.now().difference(lastViewed).inMinutes;
  print("Time difference: " + timeDifference.toString());
  if(timeDifference >= 15)
  {
    print("Making location API request");
    var location_url = Uri.parse(
      "https://dataservice.accuweather.com/locations/v1/cities/geoposition/search?apikey=$locationApi&q=$lat%2C$lng&details=false");
    Response response = await get(location_url);  
    if(response.statusCode == 200)
    {
      temp1 = await jsonDecode(response.body);
      cityName = temp1["EnglishName"];
      stateName = temp1["AdministrativeArea"]["EnglishName"];
      placeType = temp1["Type"];
      await dBr.child(path).update({"Place":cityName,"State":stateName,"Type":placeType,"Last Viewed":DateTime.now().toString()});
    }
  else 
    {
      print("Location request failed due to bad response");
      return;
    }
  }
  else 
  {
    print("Using data from Database");
    cityName = temp["Place"];
    stateName = temp["State"];
    placeType = temp["Type"] ?? "City";
  }
}
MaterialStateProperty<Color> getColor(Color color,Color colorPressed)
{
  final getColor = (Set<MaterialState> states) {
    if(states.contains(MaterialState.pressed)){
      return colorPressed;
    }
    else
    {
      return color;
    }
  };
  return MaterialStateProperty.resolveWith(getColor);
}
class _LocationPageState extends State<LocationPage> {
  @override
  var tim = Timer.periodic(const Duration(seconds:60),(timer) { });
  bool isViewed = false;
  void initState() {
    tim = Timer.periodic(Duration(seconds: 60), (timer) {
    getData(widget.path);
    setState(() {});
      
    });
    if(isViewed)
        tim.cancel();
  }
  @override
  void dispose() {
    isViewed = true;
    tim.cancel();
    super.dispose();
  }
  
  Widget build(BuildContext context) {
   return FutureBuilder(
                future: getData(widget.path),
                builder:(context,snapshot)
                {
                  if(snapshot.connectionState == ConnectionState.done)
                  {
                    return Scaffold(
                      body: Stack(
                        children: [
                          Container(
                            color: thatDarkBlueColor,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text("${userAllData.victimName}\'s Location",style: TextStyle(color: Colors.white,fontSize: 25),),
                              //SizedBox(height: 20,),
                              Center(
                                            child: ListTile(
                                                leading: Icon(Icons.location_on,size:35,color: Colors.white),
                                                
                                                title: Text(
                                                      cityName.contains("\"") ? 
                                                      
                                                      cityName.toUpperCase().substring(1,cityName.length-1):
                                                      cityName.toUpperCase(),
                                                      
                                                      style: TextStyle(
                                                        fontSize: 25,
                                                        color: Colors.white,
                                                        //fontFamily: 'Noticia',
                                                      ),
                                                    ),
                                                subtitle: Text(
                                                      stateName.contains("\"") ? stateName.substring(1,stateName.length-1) : stateName,
                                                      style: TextStyle(
                                                        fontSize: 15,
                                                        color: Colors.white,
                                                        //fontFamily: 'Noticia',
                                                      ),
                                                    ),
                                              ),
                                          ),
                            
                            
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Container(
                                  height: 150,
                                  width: 150,
                                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(25),border: Border.all(color:primaryColor,width:2)),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      textIt("SPEED",Colors.white,10),
                                      SizedBox(height: 10,),
                                      textIt(speed.toString() + "m/s",Colors.white,25),
                                    ],
                                  
                                  ),
                                ),
                                Container(
                                  height: 150,
                                  width: 150,
                                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(25),border: Border.all(color:primaryColor,width:2)),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      textIt("DIRECTION",Colors.white,10),
                                      SizedBox(height: 10,),
                                      textIt(direction.toString(),Colors.white,25),
                                    ],
                                  
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Container(
                                  height: 150,
                                  width: 150,
                                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(25),border: Border.all(color:primaryColor,width:2)),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      textIt("SATELLITES",Colors.white,10),
                                      SizedBox(height: 10,),
                                      textIt(satellites.toString(),Colors.white,25),
                                    ],
                                  
                                  ),
                                ),
                                Container(
                                  height: 150,
                                  width: 150,
                                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(25),border: Border.all(color:primaryColor,width:2)),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      textIt("TYPE",Colors.white,10),
                                      SizedBox(height: 10,),
                                      textIt(placeType.toString(),Colors.white,25),
                                    ],
                                  
                                  ),
                                ),
                              ],
                            ),
                            ElevatedButton.icon(
                              onPressed: () => launchUrl(Uri.parse("https://maps.google.com/?q=${lat},${lng}")), 
                              icon: Icon(Icons.location_on,color: Colors.white,), 
                              label: Text("Google Map",style: TextStyle(color: Colors.white,fontSize: 20),),
                              style: ButtonStyle(
                                //foregroundColor: getColor(Colors.white,Colors.red),
                                backgroundColor: getColor(Colors.blue,primaryColor),
                                
                              ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  }
                  return WaitScreen("Location", Color.fromARGB(255, 150, 97, 0));
                });
  }
}