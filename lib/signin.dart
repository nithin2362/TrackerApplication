// import 'package:flutter/material.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_database/firebase_database.dart';
// import 'signup.dart';
// import 'package:flutter/services.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'wait.dart';
// import 'main.dart';
// import 'forgotpwd.dart';
// class Signin extends StatefulWidget {
//   const Signin({ Key? key }) : super(key: key);

//   @override
//   State<Signin> createState() => _SigninState();
// }
// var data;

// final _formKey = GlobalKey<FormState>();
// List<TextEditingController> controllers = [TextEditingController(),TextEditingController()];
// String username='',password='';
// List users = [];
// bool isChecked = false;
// final dBr = FirebaseDatabase.instance.ref();
// Future<void> getAllData() async
// {
  
//   var Snapshot = await dBr.child("Users").get();
//   if(Snapshot.exists)
//   {
//     data = Snapshot.value;
//     users = data.keys.toList();
    
//   }
//   else
//   {
//     print("Data not found !");
//   }
//   print("getAllData function executed !");
  
// }
//   String getUsername(String mail)
//   {
//     return mail.substring(0,mail.indexOf('@'));
//   }
// Map getUserinfo()
// {
//   Map info = {};
//   users.forEach((key) => info[key.toString()] = data[key].keys.toList()[0]);
//   print(info);
//   print("getUserInfo function executed !");
//   return info;
// }
// Future<Map> details(String username) async
// {
//   var Snapshot = await dBr.child("Users").get();
//   Map map1 = {};
//   if(Snapshot.exists)
//   {
//     data = Snapshot.value;
//     data.keys.toList().forEach((key) => map1[key] = data[key][data[key].keys.toList()[0]]);
//     print("details function executed !");
//     return map1[username];
    
//   }
//   else
//   {
//     print("Data not found !");
//     print("details function executed !");
//     return {};
//   }
  
// }

// class _SigninState extends State<Signin> {
//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder(
//       // Initialize FlutterFire
//       future: Firebase.initializeApp(),
//       builder: (context, snapshot) {
//         // Check for errors
//         if (snapshot.hasError) 
//         {
//           return Container(
//             child: Text(
//               "Found some error"
//             ),
//           );
//         }
//         else if(snapshot.connectionState == ConnectionState.done)
//         {
//           return SignInScreen();
//         }
//         else
//           return WaitScreen("Intro",Color.fromARGB(240, 9, 24, 49));
//       }
//     );
//   }
// }

// class SignInScreen extends StatefulWidget {
//   const SignInScreen({ Key? key }) : super(key: key);

//   @override
//   State<SignInScreen> createState() => _SignInScreenState();
// }

// class _SignInScreenState extends State<SignInScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return WillPopScope(
//       onWillPop: () async{
//         showDialog(
//                 context: context, 
//                 builder: (context) => AlertDialog(
//                 backgroundColor: Color.fromARGB(255, 33, 72, 131), 
//                 title: Text("Exit", style: TextStyle(color: Colors.white,fontSize: 25,fontWeight: FontWeight.bold),),
//                 content: Text("Are you sure you want to Exit ?",style: TextStyle(color: Colors.white,fontSize: 15),),
//                 actions: [
//                   ElevatedButton(onPressed: () => Navigator.pop(context), child: Text("No",style: TextStyle(color: Colors.white,fontSize: 15),)),
//                   TextButton(onPressed: (){
//                     SystemNavigator.pop();
//                   }, child: Text("Yes",style: TextStyle(color: Colors.blue,fontSize: 15),)),
//                 ],
//               ));
//               return false;
//       },
//       child: FutureBuilder(
//         // Initialize FlutterFire
//         future: getAllData(),
//         builder: (context, snapshot) {
//           // Check for errors
//           if (snapshot.hasError) 
//           {
//             return Container(
//               child: Text(
//                 "Unable to fetch data !!!"
//               ),
//             );
//           }
//           else if(snapshot.connectionState == ConnectionState.done)
//           {
//             return Scaffold(
//               appBar: AppBar(title: Center(child: Text("Sign In",style: TextStyle(color: Colors.white,fontSize: 20.0,fontWeight: FontWeight.bold),)),backgroundColor: Color(0xFF163057),),
//               backgroundColor: Color(0xFF163057),
//               body: Form(
//                 key: _formKey,
//                 child: Center(
//                   child: Column(
//                     children: [
//                       Text("Enter mail ID",style: TextStyle(color: Colors.white,fontSize: 20)),
//                   Padding(
//                     padding: const EdgeInsets.all(10.0),
//                     child: Container(
//                       decoration:BoxDecoration(
//                       borderRadius: BorderRadius.circular(10),
//                       color: Color.fromARGB(255, 33, 72, 131),
//                       ),
                          
//                       child: TextFormField(
//                       controller: controllers[0],
//                       cursorColor: Colors.white,
//                       style: TextStyle(color: Colors.white,fontSize: 20),
//                       validator: (value) {
//                         var d1 = data;
//                         // print("D1: $d1");
//                         // print("Users: $users");
//                         if (value == null || value.isEmpty || !(value.toString().contains('@'))) {
//                           return 'Enter a valid mail ID';
//                         }
//                         else if(d1 != null && !users.contains(getUsername(value)))
//                         {
//                           return 'Invalid mail ID';
//                         }
//                         else{
//                           username = getUsername(value.toString());
//                         }
//                         return null;
//                       },
//                       onSaved: (value) => username = getUsername(value.toString()),
//                      ))),
              
//                      Text("Enter Password",style: TextStyle(color: Colors.white,fontSize: 20)),
//                   Padding(
//                     padding: const EdgeInsets.all(10.0),
//                     child: Container(
//                       decoration:BoxDecoration(
//                       borderRadius: BorderRadius.circular(10),
//                       color: Color.fromARGB(255, 33, 72, 131),
//                       ),
                          
//                       child: TextFormField(
//                       controller: controllers[1],
//                       cursorColor: Colors.white,
//                       style: TextStyle(color: Colors.white,fontSize: 20),
//                       validator: (value) {
//                         if (value == null || value.isEmpty) {
//                           return 'Please enter a valid password !';
//                         }
//                         else if(value.length < 4)
//                         {
//                           return 'Password must be atleast 4 characters long !!';
//                         }
//                         else
//                         {
//                           password = value.toString();
//                         }
//                         return null;
//                       },
//                       onSaved: (value) => password = value.toString(),
//                       obscureText: true,
//                      ))),
//                      Padding(
//                        padding: EdgeInsets.only(left: 60),
//                        child: Row(
//                         children: [
//                           Checkbox(
//                             checkColor: Colors.white,
//                             activeColor: Colors.blue,
//                             value: isChecked,
//                             onChanged: (bool? value) async{
//                               setState(() {
//                                 isChecked = value!;
//                               });
                              
//                               }),
//                               Text("Keep me signed in",style: TextStyle(color: Colors.white,fontSize: 20),),
//                         ],
//                        ),
//                      ),
//                     ElevatedButton(
//                         onPressed: () async{
//                           if(_formKey.currentState == null)
//                           {
//                             print("Sign in page Formkey current state is null");
//                           }
//                           else if (_formKey.currentState!.validate()) {
//                             Map users1 = getUserinfo();
//                             print("Users: $users1");
//                             print("Username: $username");
//                             if(users1[username] == password)
//                             {
//                               final prefs = await SharedPreferences.getInstance();
//                               prefs.setString("Username",username);
//                               prefs.setString("Password", password);
//                               /////////////////////////////////
//                               prefs.setString("Victim_Name", "");
//                               prefs.setBool("Flag", isChecked);
//                               ScaffoldMessenger.of(context).showSnackBar(
//                               SnackBar(content: Text('Signed in successfully !')));
//                               setState((){});
//                               Navigator.pushAndRemoveUntil(context,
//                               MaterialPageRoute(builder: (context) => MyHomePage(username,password,"")),(route)=> false);
//                             }
//                             else
//                             {
//                               ScaffoldMessenger.of(context).showSnackBar(
//                               SnackBar(content: Text('Invalid login credentials !')));
//                             }
                            
//                           }
//                         },
//                         child: Text("Sign In ",style: TextStyle(fontSize: 20)),
//                         ),
//                         Center(child: TextButton(onPressed: (){
//                         Navigator.push(context, MaterialPageRoute(builder: (context) => Pwd(users)));
//                       }, child: Text("Forgot your password ?",style: TextStyle(color: Colors.blue,fontSize: 20),))),
                      
//                       Center(child: Text("Don't have an account ?",style: TextStyle(color: Colors.white,fontSize: 20),)),
//                       Center(child: TextButton(onPressed: (){
//                         Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => Signup("","","")),(route)=>false);
//                       }, child: Text("Sign Up",style: TextStyle(color: Colors.blue,fontSize: 20),))),
              
//                     ],
//                   ),
//                 ),
//               ),
//               );
//           }
//           else
//             return WaitScreen("",Color.fromARGB(220, 24, 193, 184));
//       }),
//     );
// }
// }