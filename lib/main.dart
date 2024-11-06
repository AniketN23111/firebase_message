import 'dart:ui';

import 'package:async_redux/async_redux.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:message/Constants/notification_receiver.dart';
import 'package:message/Constants/routes_name.dart';
import 'package:message/Model/personal_details.dart';
import 'package:message/Views/LoginScreen/login_screen_connector.dart';
import 'package:message/Views/MyHomePage/my_home_page_connector.dart';
import 'package:message/Views/Register/register_screen_connector.dart';
import 'package:message/Views/chat.dart';
import 'package:message/Views/extra_page.dart';
import 'package:message/app_state.dart';
import 'Constants/firebase_options.dart';

late Store<AppState> store;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await NotificationReceiver.initLocalNotification();
  await Hive.initFlutter();
  var state = AppState.initState();
  store = Store<AppState>(initialState: state);
  Hive.registerAdapter(PersonalDetailsAdapter());

  const fatalError = true;
  FlutterError.onError = (errorDetails) {
    if (fatalError) {
      FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
    }
  };
  PlatformDispatcher.instance.onError = (error, stack) {
    if (fatalError) {
      FirebaseCrashlytics.instance.recordError(error, stack);
    }
    return true;
  };

  String token = await NotificationReceiver.getToken();
  print(token);
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  runApp(const MyApp());
}

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  print("Handling a background message: ${message.messageId}");
  print("Messgae Data BAckground: ${message.data}");
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    NotificationReceiver.requestPermission();
    FirebaseMessaging.onMessage.listen((message) {
      //NotificationReceiver.initLocalNotification(, message);
      NotificationReceiver.showNotification(message);
      NotificationReceiver.showInAppDialog(context, message);
    });
  }

  @override
  Widget build(BuildContext context) => StoreProvider<AppState>(
      store: store,
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme:
              ColorScheme.fromSeed(seedColor: Color.fromARGB(242, 0, 157, 255)),
          useMaterial3: true,
        ),
        debugShowCheckedModeBanner: false,
        initialRoute: RoutesName.login,
        routes: {
          RoutesName.home: (context) => const MyHomePageConnector(),
          RoutesName.extra: (context) => const ExtraPage(),
          RoutesName.login: (context) => const LoginScreenConnector(),
          RoutesName.register: (context) => const RegisterScreenConnector(),
        },
        onGenerateRoute: (settings) {
          switch (settings.name) {
            case RoutesName.home:
              return MaterialPageRoute(
                  builder: (context) => const MyHomePageConnector());
            case RoutesName.chat:
              return settings.arguments != null
                  ? MaterialPageRoute(
                      builder: (context) => Chat(
                          remoteMessage: settings.arguments as RemoteMessage))
                  : MaterialPageRoute(builder: (context) => const Chat());
            case RoutesName.extra:
              return MaterialPageRoute(builder: (context) => const ExtraPage());
            case RoutesName.register:
              return MaterialPageRoute(
                  builder: (context) => RegisterScreenConnector());
            case RoutesName.login:
              return MaterialPageRoute(
                  builder: (context) => LoginScreenConnector());
          }
          return MaterialPageRoute(
            builder: (context) => const Scaffold(
              body: Center(
                child: Text('Route not found!'),
              ),
            ),
          );
        },
      ));
}
