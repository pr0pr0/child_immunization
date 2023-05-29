import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class LocalNotificationService {
  LocalNotificationService();

  final _localNotificationService = FlutterLocalNotificationsPlugin();

  Future<void> initialize() async {
    const AndroidInitializationSettings androidInitializationSettings =
        AndroidInitializationSettings('@drawable/launch_background');

    final InitializationSettings settings = InitializationSettings(
      android: androidInitializationSettings,
    );



    await _localNotificationService.initialize(
      settings,
    );
  }

  Future<NotificationDetails> _notificationDetails(
      {required String channelId, required String channelName}) async {
    AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(channelId, channelName,
            channelDescription: 'description',
            importance: Importance.max,
            priority: Priority.max,

            ongoing: true,
            playSound: true);

    return NotificationDetails(
      android: androidNotificationDetails,
    );
  }

  Future<void> showNotification(
      {required int id,
      required String title,
      required String body,
      required String channelId,
      required String channelName}) async {
    final details = await _notificationDetails(
        channelId: channelId, channelName: channelName);
    await _localNotificationService.show(id, title, body, details);
  }
  Future<void> scheduleNotification(
      {required int id,
      required String title,
      required String body,
      required String channelId,
      required String channelName}) async {
    final details = await _notificationDetails(
        channelId: channelId, channelName: channelName);
    await _localNotificationService.schedule(
        id, title, body, DateTime.now().add(const Duration(seconds:25)), details);
  }

  Future<void> showNotificationWithPayload(
      {required int id,
      required String title,
      required String body,
      required String payload,
      required String channelId,
      required String channelName}) async {
    final details = await _notificationDetails(
      
        channelId: channelId, channelName: channelName);
    await _localNotificationService.show(id, title, body, details,
        payload: payload);
  }

  void onDidReceiveLocalNotification(
      int id, String? title, String? body, String? payload) {
    print('id $id');
  }
}
