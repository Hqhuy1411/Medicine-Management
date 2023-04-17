import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationsService {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  static int id = 0;

  Future<void> initializeNotification() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
    );
    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  void sendNotification(int device, int box, int hour, int minute) async {
    print(hour.toString() + " " + minute.toString());
    var dateTime = DateTime(DateTime.now().year, DateTime.now().month,
        DateTime.now().day, hour, minute, 0);
    tz.initializeTimeZones();
    await flutterLocalNotificationsPlugin.zonedSchedule(
      id++,
      "Uong thuoc",
      "Toi gio uong thuoc cua ${box} trong ${device}",
      tz.TZDateTime.from(dateTime, tz.local),
      NotificationDetails(
        android: AndroidNotificationDetails(id.toString(), 'Go To Bed',
            importance: Importance.max,
            priority: Priority.max,
            icon: '@mipmap/ic_launcher'),
      ),
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      androidAllowWhileIdle: true,
      matchDateTimeComponents: DateTimeComponents.time,
    );
  }
}
