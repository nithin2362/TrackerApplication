// import 'dart:math';
// import 'signin.dart';
// import 'package:flutter/material.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_database/firebase_database.dart';
// import 'package:flutter/services.dart';
// //import 'package:flutter_spinkit/flutter_spinkit.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'main.dart';
// import 'wait.dart';
// class Signup extends StatefulWidget {
//   String name = '',mail = '',username = '',password = '';
//   Signup(this.name,this.mail,this.password);

//   @override
//   State<Signup> createState() => _SignupState();
// }

// class _SignupState extends State<Signup> {
//   final dBr = FirebaseDatabase.instance.ref();
//   List users = [];
//   var data;
//   // void getIds(var list) async
//   // {
//   //   list.forEach((user) => ids.add(user["Flags"]["Id"]));
//   // }
//   Future<void> getUsers(var dBr) async
//   {
//     final snapshot = await dBr.child("Users").get();
//     if(snapshot.exists)
//     {
//       data = snapshot.value;
//       users = data.keys.toList();
//       // var vals = data.values.toList();
//       // getIds(vals);
//     }
//     print("getUsers function executed !");
//   }
//   String getUsername(String mail)
//   {
//     return mail.substring(0,mail.indexOf('@'));
//   }


//   List<TextEditingController> controllers = [TextEditingController(),TextEditingController(),TextEditingController(),TextEditingController(),TextEditingController()];
//   TextEditingController tc1 = new TextEditingController(),tc2 = new TextEditingController();
//   bool isChecked = false;
//   String password = '';
//   int security = 1;
//   final _formKey = GlobalKey<FormState>();


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
//         future: getUsers(dBr),
//         builder: ((context, snapshot) {
//           if(snapshot.connectionState == ConnectionState.done)
//           {
//             return Scaffold(
//               appBar: AppBar(title: Center(child: Text("Sign Up",style: TextStyle(color: Colors.white,fontSize: 20.0,fontWeight: FontWeight.bold),)),
//               backgroundColor: Color(0xFF163057),
//               ),
//               backgroundColor: Color(0xFF163057),
//               body: Form(
//                 key: _formKey,
//                 child: Column(
//                   children: [
//                     Text("Enter the name of user",style: TextStyle(color: Colors.white,fontSize: 20)),
//                 Padding(
//                   padding: const EdgeInsets.only(left:10.0,right: 10.0),
//                   child: Container(
//                     decoration:BoxDecoration(
//                     borderRadius: BorderRadius.circular(10),
//                     color: Color.fromARGB(255, 33, 72, 131),
//                     ),
                        
//                     child: TextFormField(
                    
//                     controller: controllers[2],
//                     cursorColor: Colors.white,
//                     style: TextStyle(color: Colors.white,fontSize: 15),
//                     validator: (value) {
//                       if (value == null || value.isEmpty) {
//                         return 'Please enter a valid Name !';
//                       }
//                       else
//                       {
//                         widget.name = value.toString();
//                       }
//                       return null;
//                     },
//                     onSaved: (value) => widget.name = value.toString(),
//                    ))),
//                 Text("Enter a unique mail ID",style: TextStyle(color: Colors.white,fontSize: 20)),
//                 Padding(
//                   padding: const EdgeInsets.only(left:10.0,right: 10.0),
//                   child: Container(
//                     decoration:BoxDecoration(
//                     borderRadius: BorderRadius.circular(10),
//                     color: Color.fromARGB(255, 33, 72, 131),
//                     ),
                        
//                     child: TextFormField(
//                     controller: controllers[3],
//                     cursorColor: Colors.white,
//                     style: TextStyle(color: Colors.white,fontSize: 15),
//                     validator: (value) {
//                       if (value == null || value.isEmpty || !(value.toString().contains('@'))) {
//                         return 'Please enter a valid mail ID !';
//                       }
//                       else if(users.contains(getUsername(value)))
//                       {
//                         return 'This mail ID is already used !';
//                       }
//                       else if(value.contains(" "))
//                       {
//                         return 'It should not contain spaces !';
//                       }
//                       else
//                       {
//                         widget.mail = value.toString();
//                         widget.username = getUsername(widget.mail);
//                       }
//                       return null;
//                     },
//                     onSaved: (value) { widget.mail = value.toString();
//                                        widget.username = getUsername(widget.mail);
//                                       },
//                    ))),
//                    Text("Enter a Password",style: TextStyle(color: Colors.white,fontSize: 20)),
//                 Padding(
//                   padding: const EdgeInsets.all(10.0),
//                   child: Container(
//                     decoration:BoxDecoration(
//                     borderRadius: BorderRadius.circular(10),
//                     color: Color.fromARGB(255, 33, 72, 131),
//                     ),
                        
//                     child: TextFormField(
//                     controller: controllers[0],
//                     cursorColor: Colors.white,
//                     style: TextStyle(color: Colors.white,fontSize: 15),
//                     validator: (value) {
//                       if (value == null || value.isEmpty) {
//                         return 'Please enter a valid password !';
//                       }
//                       else if(value.length < 4)
//                       {
//                         return 'Password must be atleast 4 characters long !!';
//                       }
//                       else
//                       {
//                         password = value.toString();
//                       }
//                       return null;
//                     },
//                     onSaved: (value) => password = value.toString(),
//                     obscureText: true,
//                    ))),
              
//                    Text("Confirm Password",style: TextStyle(color: Colors.white,fontSize: 20)),
//                 Padding(
//                   padding: const EdgeInsets.all(10.0),
//                   child: Container(
//                     decoration:BoxDecoration(
//                     borderRadius: BorderRadius.circular(10),
//                     color:Color.fromARGB(255, 33, 72, 131),
//                     ),
                        
//                     child: TextFormField(
//                     controller: controllers[1],
//                     cursorColor: Colors.white,
//                     style: TextStyle(color: Colors.white,fontSize: 15),
//                     validator: (value) {
//                       if (!(password == value)) {
//                         return 'Please enter the same password';
//                       }
//                       widget.password = value.toString();
//                       onSaved: (value) => widget.password = value.toString();
//                       return null;
//                     },
//                     obscureText: true,
//                    ))),
//                    Text("Enter a 4 digit number",style: TextStyle(color: Colors.white,fontSize: 20)),
//                   Padding(
//                   padding: const EdgeInsets.only(left:10.0,right: 10.0),
//                   child: Container(
//                     decoration:BoxDecoration(
//                     borderRadius: BorderRadius.circular(10),
//                     color: Color.fromARGB(255, 33, 72, 131),
//                     ),
                        
//                     child: TextFormField(
//                     controller: tc2,
//                     cursorColor: Colors.white,
//                     style: TextStyle(color: Colors.white,fontSize: 15),
//                     validator: (value) {
//                       if (value == null || value.isEmpty || int.parse(value) < 1000 || int.parse(value) > 9999) {
//                         return 'Please change your code !';
//                       }
//                       else
//                       {
//                         security = int.parse(value);
//                       }
//                       return null;
//                     },
//                     onSaved: (value) { security = int.parse(value.toString());
//                                       },
//                    ))),
//                    Padding(
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
//                    Row(
//                      mainAxisAlignment: MainAxisAlignment.center,
//                      children: [
//                        ElevatedButton(
                          
//                           onPressed: () async {
//                             if (_formKey.currentState!.validate()) {
//                               ScaffoldMessenger.of(context).showSnackBar(
//                                 SnackBar(content: Text('Signed up successfully !')));
//                                showDialog(
//                                 context: context, 
//                                 builder: (context) => AlertDialog(
//                                 backgroundColor: Color.fromARGB(255, 33, 72, 131), 
//                                 title: Text("Security Code", style: TextStyle(color: Colors.white,fontSize: 25,fontWeight: FontWeight.bold),),
//                                 content: Text("Please save your security code ${security} somewhere. It is required during password change. ",style: TextStyle(color: Colors.white,fontSize: 15),),
//                                 actions: [
//                                   ElevatedButton(onPressed: () => Navigator.pop(context), child: Text("Ok",style: TextStyle(color: Colors.white,fontSize: 20),)),
//                                 ],
//                               ));
//                               SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
//                               await sharedPreferences.setInt(widget.username,security);
//                               dBr.child("Users/${widget.username}/${widget.password}").set({"Location":{"Lat":12.89,"Lng":80.08},"FindMyStick":false});
//                               print("Username: ${widget.username}");
//                               print("Password: ${widget.password}");
//                               sharedPreferences.setString("Username",widget.username);
//                               sharedPreferences.setString("Password",widget.password);
//                               sharedPreferences.setString("Victim_Name", "");
//                               sharedPreferences.setBool("Flag", isChecked);
//                               Navigator.pushAndRemoveUntil(context,
//                                 MaterialPageRoute(builder: (context) => MyHomePage(widget.username,widget.password,"")),(route)=> false);
//                               setState((){});
//                             }
//                           },
//                           child: Text("Register ",style: TextStyle(fontSize: 20)),
//                           ),
//                           Center(child: TextButton(onPressed: (){
//                           Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => SignInScreen()),(route)=>false);
//                       }, child: Text("Sign In",style: TextStyle(color: Colors.blue,fontSize: 20),))),
//                      ],
//                    ),
                      
//                   ],
//                 ),
//               ),
//             );
//           }
//           else
//           {
//             return WaitScreen("",Color.fromARGB(220, 24, 193, 184));
//           }
//       })),
//     );
//   }
// }