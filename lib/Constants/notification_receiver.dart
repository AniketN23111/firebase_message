import 'dart:async';
import 'dart:math';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:message/Constants/routes_name.dart';

// Top-level function for background notification response
void onBackgroundNotificationResponse(NotificationResponse response) {
  print("Notification clicked in background: ${response.payload}");
}

class NotificationReceiver {
  static final FlutterLocalNotificationsPlugin
      _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  static Future<void> requestPermission() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );
    print('User granted permission: ${settings.authorizationStatus}');
  }

  // Get Firebase Cloud Messaging token
  static Future<String> getToken() async {
    final fcmToken = await FirebaseMessaging.instance.getToken();
    await FirebaseMessaging.instance.setAutoInitEnabled(true);
    print("FCM Token: $fcmToken");
    return fcmToken ?? '';
  }

  static Future<void> initLocalNotification(
      BuildContext context, RemoteMessage message) async {
    var androidInitializationSettings =
        const AndroidInitializationSettings("@drawable/mobigic_logo");
    var initializationSettings = InitializationSettings(
      android: androidInitializationSettings,
    );
    _flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (payload) {
        handleMessage(context, message);
      },
    );
  }

  // Initialize Firebase listeners for handling messages
  static void firebaseInit(BuildContext context) {
    FirebaseMessaging.onMessage.listen((message) {
      initLocalNotification(context, message);
      showNotification(message);
    });
  }

  // Show notification locally
  static Future<void> showNotification(RemoteMessage message) async {
    if (message.notification != null) {
      AndroidNotificationChannel channel = AndroidNotificationChannel(
        Random.secure().nextInt(1000).toString(),
        'Notifications',
        description: 'This channel is for general notifications.',
        importance: Importance.max,
      );

      AndroidNotificationDetails androidNotificationDetails =
          AndroidNotificationDetails(
        channel.id,
        channel.name,
        channelDescription: channel.description,
        importance: Importance.high,
        priority: Priority.high,
        ticker: 'Ticker',
        color: Colors.amberAccent,
      );

      NotificationDetails notificationDetails =
          NotificationDetails(android: androidNotificationDetails);

      await _flutterLocalNotificationsPlugin.show(
        Random().nextInt(100000),
        message.notification!.title ?? 'No title',
        message.notification!.body ?? 'No body',
        notificationDetails,
      );
    }
  }

  static Future<void> handleMessage(
      BuildContext context, RemoteMessage message) async {
    if (message.data['type'] == 'chat') {
      Navigator.pushNamed(context, RoutesName.chat, arguments: message);
    }
  }
}
