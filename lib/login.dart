import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'main.dart';
import 'homepage.dart';
import 'authFunctions.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flash/flash.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:string_validator/string_validator.dart';



final dBr = FirebaseDatabase.instance.ref();
class LoginForm extends StatefulWidget {
  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  //  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  String email = '';
  String password = '';
  String fullname = '';
  String victimName = '',title = "Log in",num1 = "",num2 = "",num3 = "";
  bool login = true,_isPasswordVisible = false,isChecked = false;
  Color textColor = Colors.white;
  int response = -1;
  
  
  
  
  
  
  // void _showBasicsFlash({
  //   Duration? duration,
  //   String? text,
  //   flashStyle = FlashBehavior.floating,
  // }) {
  //   showFlash(
  //     context: context,
  //     duration: duration,
  //     builder: (context, controller) {
  //       return Flash(
  //         controller: controller,
  //         behavior: flashStyle,
  //         position: FlashPosition.bottom,
  //         backgroundColor: thatDarkBlueColor,
  //         boxShadows: kElevationToShadow[4],
  //         horizontalDismissDirection: HorizontalDismissDirection.horizontal,
  //         child: FlashBar(
  //           content: Text(text!,style: TextStyle(color: Colors.orangeAccent,fontSize:15),),
  //         ),
  //       );
  //     },
  //   );
  // }
  
  String getUniqueName(String mail)
  {
    return mail.substring(0,mail.indexOf('@'));
  }
@override
  void initState() {
    _isPasswordVisible = false;
    isChecked = false;
    login = true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> loginWidgets = [
                          TextFormField(
                              style: TextStyle(color: textColor,fontSize: 17),
                              key: ValueKey('fullname'),
                              decoration: InputDecoration(
                                hintText: 'Enter Full Name',
                                hintStyle: TextStyle(color: Colors.white54,fontSize: 15),
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please Enter Full Name';
                                } else {
                                  return null;
                                }
                              },
                              onSaved: (value) {
                                setState(() {
                                  fullname = value!;
                                });
                              },
                            ),
                          TextFormField(
                            style: TextStyle(color: textColor,fontSize: 17),
                            key: ValueKey('email'),
                            decoration: InputDecoration(
                              hintText: 'Enter Email',
                              hintStyle: TextStyle(color: Colors.white54,fontSize: 15),
                            ),
                            validator: (value) {
                              if (value!.isEmpty || !value.contains('@')) {
                                return 'Please Enter valid Email';
                              } else {
                                return null;
                              }
                            },
                            onSaved: (value) {
                              setState(() {
                                email = value!;
                              });
                            },
                          ),
                          TextFormField(
                        style: TextStyle(color: textColor,fontSize: 17),
                        key: ValueKey('password'),
                        obscureText: !_isPasswordVisible,
                        decoration: InputDecoration(
                          hintText: 'Enter Password',
                          hintStyle: TextStyle(color: Colors.white54,fontSize: 15),
                           suffixIcon: IconButton(
                        icon: Icon(
                          // Based on passwordVisible state choose the icon
                          _isPasswordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                          color: Colors.white54,
                          ),
                        onPressed: () {
                          // Update the state i.e. toogle the state of passwordVisible variable
                          setState(() {
                              _isPasswordVisible = !_isPasswordVisible;
                          });}
                        ),),
                        validator: (value) {
                          if (value!.length < 6) {
                            return 'Please Enter Password of min length 6';
                          } else {
                            return null;
                          }
                        },
                        onSaved: (value) {
                          setState(() {
                            password = value!;
                          });
                        },
                      ),
                      Padding(
                       padding: EdgeInsets.only(left: 60),
                       child: Row(
                        children: [
                          Checkbox(
                            checkColor: textColor,
                            activeColor: Colors.blue,
                            focusColor: Colors.redAccent,
                            hoverColor: Colors.deepPurpleAccent,
                            value: isChecked,
                            onChanged: (bool? value) async{
                              setState(() {
                                isChecked = value!;
                              });
                              
                              }),
                              Text("Keep me signed in",style: TextStyle(color: Colors.white60,fontSize: 15),),
                        ],
                       ),
                     )
                      ];
  List<Widget> signupWidgets = [
                        TextFormField(
                              style: TextStyle(color: textColor,fontSize: 17),
                              key: ValueKey('fullname'),
                              decoration: InputDecoration(
                                hintText: 'Enter Full Name',
                                hintStyle: TextStyle(color: Colors.white54,fontSize: 15),
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please Enter Full Name';
                                } else {
                                  return null;
                                }
                              },
                              onSaved: (value) {
                                setState(() {
                                  fullname = value!;
                                });
                              },
                            ),
            
                      // ====== Name of the victim ====              
                      TextFormField(
                        style: TextStyle(color: textColor,fontSize: 17),
                        key: ValueKey('victimName'),
                        decoration: InputDecoration(
                          hintText: 'Name of the visually impaired person',
                          hintStyle: TextStyle(color: Colors.white54,fontSize: 15),
                        ),
                        validator: (value) {
                          if (value!.length < 6) {
                            return 'Please Enter a valid name';
                          } else {
                            return null;
                          }
                        },
                        onSaved: (value) {
                          setState(() {
                            victimName = value!;
                          });
                        },
                      ),
                      
                      // ======== Email ========
                      TextFormField(
                        style: TextStyle(color: textColor,fontSize: 17),
                        key: ValueKey('email'),
                        decoration: InputDecoration(
                          hintText: 'Enter Email',
                          hintStyle: TextStyle(color: Colors.white54,fontSize: 15),
                        ),
                        validator: (value) {
                          if (value!.isEmpty || !value.contains('@')) {
                            return 'Please Enter valid Email';
                          } else {
                            return null;
                          }
                        },
                        onSaved: (value) {
                          setState(() {
                            email = value!;
                          });
                        },
                      ),
                      // ======== Password ========
                      TextFormField(
                        style: TextStyle(color: textColor,fontSize: 17),
                        key: ValueKey('password'),
                        obscureText: !_isPasswordVisible,
                        decoration: InputDecoration(
                          hintText: 'Enter Password',
                          hintStyle: TextStyle(color: Colors.white54,fontSize: 15),
                           suffixIcon: IconButton(
                        icon: Icon(
                          // Based on passwordVisible state choose the icon
                          _isPasswordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                          color: Colors.white54,
                          ),
                        onPressed: () {
                          // Update the state i.e. toogle the state of passwordVisible variable
                          setState(() {
                              _isPasswordVisible = !_isPasswordVisible;
                          });}
                        ),),
                        validator: (value) {
                          if (value!.length < 6) {
                            return 'Please Enter Password of min length 6';
                          } else {
                            return null;
                          }
                        },
                        onSaved: (value) {
                          setState(() {
                            password = value!;
                          });
                        },
                      ),
                      TextFormField(
                              style: TextStyle(color: textColor,fontSize: 17),
                              key: ValueKey('num1'),
                              decoration: InputDecoration(
                                hintText: 'Enter your contact number',
                                hintStyle: TextStyle(color: Colors.white54,fontSize: 15),
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter your contact number';
                                } 
                                else if(!isNumeric(value.toString()))
                                {
                                  return 'Please enter a contact number';
                                }
                                else if(value.length != 8 && value.length != 10)
                                {
                                  return 'Please enter a valid contact number';
                                }
                                else {
                                  return null;
                                }
                              },
                              onSaved: (value) {
                                setState(() {
                                  num1 = value!;
                                });
                              },
                            ),
            
                      // ====== Name of the victim ====              
                      TextFormField(
                        style: TextStyle(color: textColor,fontSize: 17),
                        key: ValueKey('num2'),
                        decoration: InputDecoration(
                          hintText: 'Enter a second contact number (Optional)',
                          hintStyle: TextStyle(color: Colors.white54,fontSize: 15),
                        ),
                        validator: (value) {
                          if(value == num1)
                          {
                            return 'Please enter a different contact number for each field';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          setState(() {
                            num2 = (isNumeric(value.toString()) && (value!.length == 8 || value!.length == 10)) ? value! : "Nil";
                          });
                        },
                      ),
                      TextFormField(
                        style: TextStyle(color: textColor,fontSize: 17),
                        key: ValueKey('num3'),
                        decoration: InputDecoration(
                          hintText: 'Enter a third contact number (Optional)',
                          hintStyle: TextStyle(color: Colors.white54,fontSize: 15),
                        ),
                        validator: (value) {
                          if(value == num1 || value == num2)
                          {
                            return 'Please enter a different contact number for each field';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          setState(() {
                            num3 = (isNumeric(value.toString()) && (value!.length == 8 || value!.length == 10)) ? value! : "Nil";
                          });
                        },
                      ),
                      ];
    return Scaffold(
            // key: _scaffoldKey,
            //resizeToAvoidBottomInset: false,
            appBar: AppBar(
              elevation: 0,
              title: Text(title,style: TextStyle(fontSize: 25),),
              centerTitle: true,
              backgroundColor: thatDarkBlueColor,
            ),
            backgroundColor: thatDarkBlueColor,
            body: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Form(
                key: _formKey,
                child: Container(
                  padding: EdgeInsets.all(14),
                  child: 
                  
                  
                  
                  SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: login ? MainAxisAlignment.center : MainAxisAlignment.spaceEvenly,
                      children: (login ? loginWidgets : signupWidgets) +
                      [
                        
                        SizedBox(
                          height: 30,
                        ),
                        Container(
                          height: 55,
                          width: double.infinity,
                          child: ElevatedButton(
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  _formKey.currentState!.save();
                                  response = login
                                      ? await signinUser(email, password, context)
                                      : await signupUser(
                                          email, password, fullname,victimName,context);
                                  if(response == 0)
                                  {
                                  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
                                  sharedPreferences.setString("username", fullname);
                                  // sharedPreferences.setInt("Phone", -1);
                                  sharedPreferences.setString("uniqueName",getUniqueName(email));
                                  sharedPreferences.setBool("Flag", isChecked);
                                  if(!login)
                                  {
                                    await dBr.child("Users/${getUniqueName(email)}").set({'Email': email, 'Name': fullname,'Victim name':victimName,"Location":{"Lat":0,"Lng":0,"Speed":0,"Satellites":0,"Last Viewed":DateTime.now().toString()},"Panic":0,"Trigger":false,"Phone Numbers":{"Number 1":num1,"Number 2":num2,"Number 3":num3}}); 
                                  }
                                  Navigator.pushAndRemoveUntil(context,
                                  MaterialPageRoute(builder: (context) => MyHomePage(getUniqueName(email))),(route)=> false);
                                //   ScaffoldMessenger.of(context)
                                // .showSnackBar(SnackBar(content: Text(login ? 'Log in successful!' : 'Sign up successful')));
                                 // _showBasicsFlash(duration: Duration(seconds:3),text: "${title} successful!");
                                  
                                  // (SnackBar(
                                  //     content: Text(
                                  //     'Welcome',
                                  //     ),
                                  //     duration: Duration(seconds: 2),
                                  //   ));
                                  
                                  }
                                  else
                                  {
                                    print("Some error occured");
                                  }
                                }
                              },
                              child: Text(login ? 'Login' : 'Signup')),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextButton(
                            onPressed: () {
                              setState(() {
                                login = !login;
                                title = login ? "Log in" : "Sign up";
                              });
                            },
                            child: Text(login
                                ? "Don't have an account? Signup"
                                : "Already have an account? Login"))
                      ],
                    ),
                  ),
                  // :
                  
                  // Column(
                  //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  //   children: [
                  //     // ======== Full Name ========
                      
                  //     SizedBox(
                  //       height: 30,
                  //     ),
                  //     Container(
                  //       height: 55,
                  //       width: double.infinity,
                  //       child: ElevatedButton(
                  //           onPressed: () async {
                  //             if (_formKey.currentState!.validate()) {
                  //               _formKey.currentState!.save();
                  //               response = login
                  //                   ? await signinUser(email, password, context)
                  //                   : await signupUser(
                  //                       email, password, fullname,victimName,context);
                  //               if(response == 0)
                  //               {
                  //               await dBr.child("Users/${victimName}").set({'Email': email, 'Name': fullname,'Victim name':victimName,"Location":{"Lat":12.96,"Lng":80.08}});
                                
                                
                                
                  //               Navigator.pushAndRemoveUntil(context,
                  //               MaterialPageRoute(builder: (context) => MyHomePage(victimName, fullname, password)),(route)=> false);
                  //               // ScaffoldMessenger.of(context).showSnackBar(
                  //               //   SnackBar(content: Text('Signed up successfully !')));
                  //               //_showBasicsFlash(duration: Duration(seconds:3),text: "Signed up successfully!");
                                
                                
                  //               // (SnackBar(
                  //               //     content: Text(
                  //               //     'Welcome',
                  //               //     ),
                  //               //     duration: Duration(seconds: 2),
                  //               //   ));
                                
                  //               }
                  //               else
                  //               {
                  //                 print("Some error occured");
                  //               }
                  //             }
                  //           },
                  //           child: Text(login ? 'Login' : 'Signup')),
                  //     ),
                  //     SizedBox(
                  //       height: 10,
                  //     ),
                  //     TextButton(
                  //         onPressed: () {
                  //           setState(() {
                  //             login = !login;
                  //             title = login ? "Log in" : "Sign up";
                  //           });
                  //         },
                  //         child: Text(login
                  //             ? "Don't have an account? Signup"
                  //             : "Already have an account? Login"))
                  //   ],
                  // ),
                ),
              ),
            ),
          );
      
    
        
  }
}