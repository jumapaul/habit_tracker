import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  static final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static Future<void> onDidReceiveNotification(
      NotificationResponse notificationResponse) async {}

  //initialize notification
  static Future<void> init() async {
    //initialize android setting
    const AndroidInitializationSettings androidInitializationSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    //initialize for ios
    const DarwinInitializationSettings iosInitializationSetting =
        DarwinInitializationSettings();

    const InitializationSettings initializationSettings =
        InitializationSettings(
            android: androidInitializationSettings,
            iOS: iosInitializationSetting);

    //initialize the plugin with the setting
    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse: onDidReceiveNotification,
        onDidReceiveBackgroundNotificationResponse: onDidReceiveNotification);

    //request notification permission for android
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.requestNotificationsPermission();
  }

  static Future<void> scheduleNotification(
      String title, String body, DateTime scheduleTime) async {
    const NotificationDetails platformSpecifics = NotificationDetails(
        android: AndroidNotificationDetails("channelId", "channelName",
            importance: Importance.high, priority: Priority.high),
        iOS: DarwinNotificationDetails());

    await flutterLocalNotificationsPlugin.zonedSchedule(0, title, body,
        tz.TZDateTime.from(scheduleTime, tz.local), platformSpecifics,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        matchDateTimeComponents: DateTimeComponents.dateAndTime,
        androidScheduleMode: AndroidScheduleMode.exact);
  }
}
