import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:message/Constants/firebase_remote_config_service.dart';
import 'package:message/Constants/notification_receiver.dart';
import 'package:message/Constants/routes_name.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final FirebaseRemoteConfigService _remoteConfigService =
      FirebaseRemoteConfigService();
  String name = '';

  @override
  void initState() {
    FirebaseMessaging.onMessageOpenedApp.listen((event) {
      //NotificationReceiver.handleMessage(context, event);
      NotificationReceiver.showInAppDialog(context, event);
    });
    super.initState();
    _initializeRemoteConfig();
  }

  Future<void> _initializeRemoteConfig() async {
    await _remoteConfigService.initializeRemoteConfig();
    setState(() {
      name = _remoteConfigService.getRemoteConfigValue('Title');
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(name),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    name = _remoteConfigService.getRemoteConfigValue('Title');
                    print(name);
                  });
                },
                child: const Text('Get Name'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, RoutesName.extra);
                },
                child: const Text('Extra Page'),
              )
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            FirebaseCrashlytics.instance.crash();
          },
          tooltip: 'Crash App',
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
