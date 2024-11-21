import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  static final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static Future<void> onDidReceiveNotification(
      NotificationResponse notificationResponse) async {}

  static Future<void> init() async {
    const AndroidInitializationSettings androidInitializationSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    const InitializationSettings initializationSettings =
        InitializationSettings(android: androidInitializationSettings);

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: onDidReceiveNotification,
      onDidReceiveBackgroundNotificationResponse: onDidReceiveNotification,
    );

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.requestNotificationsPermission();

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.requestExactAlarmsPermission();
  }

  static Future<void> showInstantNotification(
    String title,
    String body,
  ) async {
    const NotificationDetails platfromspecific = NotificationDetails(
      android: AndroidNotificationDetails("channel_Id", "channel_Name",
          importance: Importance.high, priority: Priority.high),
    );
    await flutterLocalNotificationsPlugin.show(
        0, title, body, platfromspecific);
  }

  static Future<void> shedualNotification(
      String title, String body, DateTime shedualTime) async {
    const NotificationDetails platfromspecific = NotificationDetails(
      android: AndroidNotificationDetails("channel_Id", "channel_Name",
          importance: Importance.high, priority: Priority.high),
    );
    await flutterLocalNotificationsPlugin.zonedSchedule(0, title, body,
        tz.TZDateTime.from(shedualTime, tz.local), platfromspecific,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        matchDateTimeComponents: DateTimeComponents.dateAndTime,
        androidScheduleMode: AndroidScheduleMode.alarmClock);
  }
}
