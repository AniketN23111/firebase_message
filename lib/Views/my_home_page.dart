import 'package:firebase_crashlytics/firebase_crashlytics.dart';
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
    super.initState();
    _initializeFirebaseServices();
    NotificationReceiver.firebaseInit(context);
    NotificationReceiver.requestPermission();
  }

  Future<void> _initializeFirebaseServices() async {
    await _initializeRemoteConfig();
  }

  Future<void> _initializeRemoteConfig() async {
    await _remoteConfigService.initializeRemoteConfig();
    setState(() {
      name = _remoteConfigService.getRemoteConfigValue('Title');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('You have pushed the button this many times:'),
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
    );
  }
}
