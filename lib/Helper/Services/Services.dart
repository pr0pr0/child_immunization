import 'dart:async';
import 'dart:io';
import 'dart:ui';
import 'package:child_immunization/Data/HiveDB/HiveDB.dart';
import 'package:child_immunization/Data/Model/KidsModel/KidsModel.dart';
import 'package:child_immunization/Data/Model/NotificationsModel/NotificationsModel.dart';
import 'package:child_immunization/Data/Repository/Repository.dart';
import 'package:child_immunization/Data/shared_preferences/CustomSharedPreferences.dart';
import 'package:child_immunization/Helper/DirectoryHelper/CreateDir_Helper.dart';
import 'package:child_immunization/Helper/Services/notification_service.dart';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_background_service_android/flutter_background_service_android.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Services {
  Future<void> initializeService() async {
    final service = FlutterBackgroundService();

    /// OPTIONAL, using custom notification channel id
    const AndroidNotificationChannel channel = AndroidNotificationChannel(
      'getData', // id
      'CHECK FOR DATA', // title
      description:
          'This channel is used for important notifications.', // description
      importance: Importance.max,
      // importance must be at low or higher level
    );

    final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();

    if (Platform.isIOS) {
      await flutterLocalNotificationsPlugin.initialize(
        const InitializationSettings(
          iOS: DarwinInitializationSettings(),
        ),
      );
    }

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    await service.configure(
      androidConfiguration: AndroidConfiguration(
        // this will be executed when app is in foreground or background in separated isolate
        onStart: onStart,
        autoStartOnBoot: false,
        // auto start service
        autoStart: true,

        isForegroundMode: true,
        notificationChannelId: 'getData',
        initialNotificationTitle: 'تحصين الاطفال',
        initialNotificationContent: 'CHECK FOR DATA',
        foregroundServiceNotificationId: 888,
      ),
      iosConfiguration: IosConfiguration(
        // auto start service
        autoStart: true,

        // this will be executed when app is in foreground in separated isolate
        onForeground: onStart,

        // you have to enable background fetch capability on xcode project
        onBackground: onIosBackground,
      ),
    );

    service.startService();
  }
}

@pragma('vm:entry-point')
Future<bool> onIosBackground(ServiceInstance service) async {
  WidgetsFlutterBinding.ensureInitialized();
  DartPluginRegistrant.ensureInitialized();

  SharedPreferences preferences = await SharedPreferences.getInstance();
  await preferences.reload();
  final log = preferences.getStringList('log') ?? <String>[];
  log.add(DateTime.now().toIso8601String());
  await preferences.setStringList('log', log);

  return true;
}

@pragma('vm:entry-point')
void onStart(ServiceInstance service) async {
  // Only available for flutter 3.0.0 and later
  DartPluginRegistrant.ensureInitialized();

  // For flutter prior to version 3.0.0
  // We have to register the plugin manually

  SharedPreferences preferences = await SharedPreferences.getInstance();
  await preferences.setString("hello", "world");

  /// OPTIONAL when use custom notification
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  if (service is AndroidServiceInstance) {
    service.on('setAsForeground').listen((event) {
      service.setAsForegroundService();
    });
    service.on('setAsBackground').listen((event) {
      service.setAsBackgroundService();
    });
  }

  service.on('stopService').listen((event) {
    service.stopSelf();
  });

  // bring to foreground

  if (service is AndroidServiceInstance) {
    if (await service.isForegroundService()) {
      flutterLocalNotificationsPlugin.show(
        888,
        'تحصين الاطفال',
        'CHECK FOR DATA',
        const NotificationDetails(
          android: AndroidNotificationDetails(
            'getData',
            'CHECK FOR DATA',
            icon: '@drawable/launch_background',
            ongoing: true,
          ),
        ),
      );
    }
  }
  final deviceInfo = DeviceInfoPlugin();
  String? device;
  if (Platform.isAndroid) {
    final androidInfo = await deviceInfo.androidInfo;
    device = androidInfo.model;
  }

  if (Platform.isIOS) {
    final iosInfo = await deviceInfo.iosInfo;
    device = iosInfo.model;
  }

  service.invoke(
    'update',
    {
      "current_date": DateTime.now().toIso8601String(),
      "device": device,
    },
  );
  intiHiveDB();

  getAdviceDB(service);
}

Future<dynamic> getAdviceDB(ServiceInstance service) async {
  LocalNotificationService().initialize();

  try {
    await CustomSharedPreferences.get('MyUser').then((id) {
      Repository().getNotifications(id: id).then((value) async {
        if (value.runtimeType != String && value is List<KidsModel>) {
          int index = 0;
          value.forEach((element) async {
            index = index + 1;
            await HiveDB().addOneBox(
                NotificationsModel(
                    id: element.id,
                    name: element.name,
                    message:
                        "موعد التلقيح بعد يوم الرجاء التواجد لاقرب مركز صحي"),
                "Notifications");
            const AndroidNotificationDetails androidNotificationDetails =
                AndroidNotificationDetails(
              'my_channel_id',
              'My Channel Name',
              importance: Importance.max,
              priority: Priority.high,
              showWhen: false,
            );
            const NotificationDetails notificationDetails =
                NotificationDetails(android: androidNotificationDetails);
            final FlutterLocalNotificationsPlugin
                flutterLocalNotificationsPlugin =
                FlutterLocalNotificationsPlugin();
            await flutterLocalNotificationsPlugin.show(
              0,
              'New Notification',
              'This is a notification from your background service',
              notificationDetails,
            );
          });
          if (index == value.length) {
            service.stopSelf();
          }
        }
      });
    });
  } catch (_) {
    service.stopSelf();
  }
}

Future<void> intiHiveDB() async {
  Hive.init(await CreateDir_Helper().CreateDir("Hive"));
  await Hive.initFlutter();
  Hive.registerAdapter(NotificationsModelAdapter());
}
