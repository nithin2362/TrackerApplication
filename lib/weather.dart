import 'package:flutter/material.dart';
import 'main.dart';
import 'wait.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:http/http.dart';
import 'dart:convert';
String weatherAPI = "24ad4427ef83e4f360eacb7c52caf32e";
var lat = 12.89,lng = 79.08;
String weather = "Nil",description = "Nil",iconLink = "Nil",temperature = "Nil",humidity = "Nil",airVelocity = "Nil",airPressure = "Nil";
String getdesc(String weather,String description)
  {
    String val = description[0].toString().toUpperCase() + description.toString().substring(1);
    if(description.toString().toLowerCase() == weather.toString().toLowerCase()) {
      val = 'Mild ' + val;
    }
    return val;
  }
NetworkImage? nimage;
Future<void> getNetworkImage(String link)async
{
  nimage = await NetworkImage(link);
}
Future<void> getWeather(String path)async
{
  await Firebase.initializeApp();
  final dBr = FirebaseDatabase.instance.ref();
  final snapshot = await dBr.child(path).get();
  var temp,t_decoded;
  if(snapshot.exists && snapshot.value != null)
  {
    temp = snapshot.value;
    lat = temp["Lat"];
    lng = temp["Lng"];
  }
  var tempurl = Uri.parse('https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lng&appid=$weatherAPI');
  Response temp_response = await get(tempurl);
  if(temp_response.statusCode == 200)  
    {
      t_decoded = await jsonDecode(temp_response.body);
      weather = t_decoded["weather"][0]["main"];
      description = getdesc(weather, t_decoded["weather"][0]["description"]) ;
      var iconimg = t_decoded["weather"][0]["icon"];
      iconLink = "https://openweathermap.org/img/wn/${iconimg}@2x.png";
      temperature = (t_decoded["main"]["feels_like"] - 273.15).toStringAsPrecision(4);
      humidity = t_decoded["main"]["humidity"].toString() + '%';
      airVelocity = t_decoded["wind"]["speed"].toString() + ' m/s';
      airPressure = t_decoded["main"]["pressure"].toString() + ' hPa';
      getNetworkImage(iconLink);
    }
  else
    {
      print("Weather request failed due to bad response");
    }
}
class WeatherDisplay extends StatefulWidget {
  String path;
 WeatherDisplay(this.path);

  @override
  State<WeatherDisplay> createState() => _WeatherDisplayState();
}
Widget imgWidget()
{
  Widget widget;
  try{
    widget = Image(image: NetworkImage(iconLink.toString()));
  }
  catch(e)
  {
    widget = Container(height: 5);
  }
  return widget;
}
class _WeatherDisplayState extends State<WeatherDisplay> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: getWeather(widget.path),
                builder:(context,snapshot)
                {
                  if(snapshot.connectionState == ConnectionState.done)
                  {
                    return Stack(
                       children:
                       [
                      Container(color: thatDarkBlueColor),
                      Column(
                                      
                          children: [
                                        
                                         Padding(
                                           padding: EdgeInsets.only(top:50,left: 20,right: 20),
                                           child: 
                                               Center(
                                                 child: Text(
                                            "Weather at ${userAllData.victimName}\'s place" ,
                                            style: TextStyle(
          
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                            ),
                                            
                                          ),
                                               ),
                                    
                                         ),
                                        SizedBox(height: 30,),
                                        Padding(
                                          padding: EdgeInsets.only(top:20.0,bottom: 30.0),
                                          
                                          child:Column(
                                           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                            children: 
                                            [
                                          SizedBox(height: 20,),
                                          Center(
                                            child: imgWidget(),
                                          ),
                                          Text(
                                                weather,
                                                style: TextStyle(
                                                  fontSize: 30,
                                                  color: textColor,
                                                  fontWeight: FontWeight.bold,
                                                  
                                                ),
                                              ),
                                              SizedBox(height: 10,),
                                              Text(
                                                description,
                                                style: TextStyle(
                                                  fontSize: 20,
                                                  color: textColor,
                                                  
                                                  )
                                                  ),
                                              ]
                                              ),
                                            ),
          //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                                          Column(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              SizedBox(height: 50,),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                children: [
                                                    Container(
                                                      width: 150,
                                                      height: 150,
                                                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(25),border: Border.all(color:primaryColor,width:2)),
                                                      child: Column(
                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                          children: [
                                                              CircleAvatar(
                                                          backgroundImage: AssetImage('assets/thermo.png'),
                                                          
                                                        ),
                                                        SizedBox(height: 10,),
                                                        Text(temperature + '°C',
                                                                    style: TextStyle(
                                                                    fontSize: 23,                                             
                                                                   
                                                                    color: textColor,
                                                                    
                                                            ),
                                                            ),
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
                                                  CircleAvatar(
                                                  backgroundImage: AssetImage('assets/humidity.jpg'),
                                                ),
                                                SizedBox(height: 10,),
                                                Text(humidity,
                                                              style: TextStyle(
                                                              fontSize: 23,
                                                              
                                                              color: textColor,
                                                              
                                                      ),
                                                      
                                                      ),
                                                ],
                                              ),
                                            ),
                                                ],
                                              ),
                                              SizedBox(height: 30,),
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
                                                            CircleAvatar(
                                                            backgroundImage: AssetImage('assets/wind.jpg'),
                                                          ),
                                                          SizedBox(height: 10,),
                                                          Text(airVelocity,
                                                                      style: TextStyle(
                                                                      fontSize: 23,
                                                                      
                                                                      color: textColor,
                                                                      
                                                              ),
                                                              
                                                              ),
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
                                                CircleAvatar(
                                                backgroundImage: AssetImage('assets/pressure.jpg'),
                                                
                                              ),
                                              SizedBox(height: 10,),
                                              Text(airPressure,
                                                            style: TextStyle(
                                                            fontSize: 23,
                                                            
                                                            color: textColor,
                                                            
                                                    ),
                                                    
                                                    ),
                                              ],
                                              
                                            ),
                                          ),
                                                ],
                                              ),
                                          
                                            ],
                                            ),
                                          
                                          
                                          
                                          
                           ] ),
                                    
                                    
                                    
                         
                       ]);
                  }
                  return WaitScreen("Weather", Color.fromARGB(255, 37, 9, 42));
                    
                }
        
        
        
      ),
    );
  }
}