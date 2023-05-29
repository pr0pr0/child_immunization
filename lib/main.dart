import 'dart:io';

import 'package:child_immunization/Helper/DirectoryHelper/CreateDir_Helper.dart';
import 'package:child_immunization/Helper/HiveAdapter/Adapter_Helper.dart';
import 'package:child_immunization/Helper/Services/Services.dart';
import 'package:child_immunization/Pages/HomePage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart' as pathProvider;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  await intiHiveDB();
  runApp(const MyApp());
}

Future<void> intiHiveDB() async {
  Hive.init(await CreateDir_Helper().CreateDir("Hive"));
  await Hive.initFlutter();
  AdapterHelper().adapter();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Immunization',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'AlmarAI', useMaterial3: true),
      home: const HomePage(),
    );
  }
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Services().initializeService();
}
