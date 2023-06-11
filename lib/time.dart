// import 'dart:async';
// import 'package:firebase_database/firebase_database.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
// final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
//     FlutterLocalNotificationsPlugin();

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();

//   // Initialize Firebase Messaging
//   await _firebaseMessaging.requestPermission();
//   final token = await _firebaseMessaging.getToken();
//   print('FCM Token: $token');

//   // Initialize Flutter Local Notifications
//   final initializationSettingsAndroid =
//       AndroidInitializationSettings('@mipmap/ic_launcher');
//   final initializationSettingsIOS = IOSInitializationSettings;
//   final initializationSettings = InitializationSettings(
//     android: initializationSettingsAndroid,
//     iOS: initializationSettingsIOS,
//   );
//   await _flutterLocalNotificationsPlugin.initialize(initializationSettings);

//   // Listen for changes to the boolean flag in Firebase Database
//   final databaseReference = FirebaseDatabase.instance.reference();
//   databaseReference.child('notifications').onValue.listen((event) {
//     final boolFlag = event.snapshot.value;
//     if (boolFlag == true) {
//       sendNotification();
//     }
//   });
// }

// Future onSelectNotification(String payload) async {
//   // Handle notification tap event
// }

// Future<void> sendNotification() async {
//   const channel = AndroidNotificationChannel(
//     'default_notification_channel_id',
//     'Default Notification Channel',
//     'Description',
//     importance: Importance.high,
//   );
//   await _flutterLocalNotificationsPlugin
//       .resolvePlatformSpecificImplementation<
//           AndroidFlutterLocalNotificationsPlugin>()
//       ?.createNotificationChannel(channel);

//   final notificationDetails = NotificationDetails(
//     android: AndroidNotificationDetails(
//       channel.id,
//       channel.name,
//       channel.description,
//       importance: Importance.high,
//     ),
//     iOS: IOSNotificationDetails(),
//   );

//   await _flutterLocalNotificationsPlugin.show(
//     0,
//     'Title',
//     'Body',
//     notificationDetails,
//     payload: 'Payload',
//   );
// }
