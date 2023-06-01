import 'package:flutter/material.dart';
import 'package:flutter_local_noti/fetures/notification/data/models/notification_model.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

import '../../../../utils/convert_payload.dart';

class NotificationService {
  //Inject Notification
  final FlutterLocalNotificationsPlugin notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  //TODO : Function Setup
  Future<void> initNotification() async {
    //1.1 For Android
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('flutter_logo');

    //1.2 For IOS
    const DarwinInitializationSettings initializationSettingsDarwin =
        DarwinInitializationSettings();

    //2. Initial setting
    const initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsDarwin,
    );

    //ใช้งานบริการการแจ้งเตือน โดยกำหนดค่าต่าง ๆ ตาม initializationSettings
    await notificationsPlugin.initialize(initializationSettings);
  }

  //----------------------------------------------------------------------------------------------------------------------

  //TODO 1: Send Notification Single
  Future<void> sendNotification({
    required String title,
    required String body,
  }) async {
    //1.1 Setup Detail For Android
    AndroidNotificationDetails androidNotificationDetails =
        const AndroidNotificationDetails(
      'channelId', 'channelName',
      importance: Importance.max, //ระดับความสำคัญ
      priority: Priority.high, //ระดับความสำคัญกรณีที่มีหลายรายการพร้อมกัน
      icon: 'flutter_logo', //icon name
      channelShowBadge: true, //badge บนตัว app
      largeIcon: DrawableResourceAndroidBitmap('flutter_logo'), //icon detail
    );

    //1.2 Setup Detail For IOS
    const iosNotificatonDetail = DarwinNotificationDetails();

    //2. Detail Notification
    NotificationDetails notificationDetails = NotificationDetails(
      android: androidNotificationDetails,
      iOS: iosNotificatonDetail,
    );

    //3. Send Notification
    await notificationsPlugin.show(0, title, body, notificationDetails);
  }

  //TODO 2: Sechedule Notificaion
  Future<void> secheduleNotificaion({
    required int id,
    required String title,
    required String body,
    required TimeOfDay timeDay,
  }) async {
    //get timezone location
    tz.initializeTimeZones();
    //setting time scheduled
    var now = DateTime.now();
    var scheduledDate = DateTime(
      now.year,
      now.month,
      now.day,
      timeDay.hour,
      timeDay.minute,
      0,
    );
    final String payload =
        tz.TZDateTime.from(scheduledDate, tz.local).toString();

    //1.1 Setup Detail For Android
    AndroidNotificationDetails androidNotificationDetails =
        const AndroidNotificationDetails(
      'channelId', 'channelName',
      importance: Importance.max, //ระดับความสำคัญ
      priority: Priority.high, //ระดับความสำคัญกรณีที่มีหลายรายการพร้อมกัน
      icon: 'flutter_logo', //icon name
      channelShowBadge: true, //badge บนตัว app
      largeIcon: DrawableResourceAndroidBitmap('flutter_logo'), //icon detail
    );

    //1.2 Setup Detail For IOS
    const iosNotificatonDetail = DarwinNotificationDetails();

    //2. Detail Notification
    NotificationDetails notificationDetails = NotificationDetails(
      android: androidNotificationDetails,
      iOS: iosNotificatonDetail,
    );

    //3. Send Notification
    await notificationsPlugin.zonedSchedule(
      id,
      title,
      body,
      tz.TZDateTime.from(scheduledDate, tz.local),
      notificationDetails,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      //ข้อความแถมมั้ง
      payload: payload,
      //ไม่ต้องคำนึงถึงการปรับเวลาท้องถิ่น
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      //วันที่จะไม่ถูกนำมาใช้
      matchDateTimeComponents: DateTimeComponents.time,
    );
  }

  //TODO 3.1: Remove All Notification
  Future<void> stopAllNotifications() async {
    await notificationsPlugin.cancelAll();
  }

  //TODO 3.2: Remove Id Notification
  Future<void> stopNotifications({required int id}) async {
    await notificationsPlugin.cancel(id);
  }

  //TODO 4: Get Pending Notification
  Future<List<PendingNotificationRequest>> getPendingNotifications() async {
    tz.initializeTimeZones();
    List<PendingNotificationRequest> pendingNotifications =
        await notificationsPlugin.pendingNotificationRequests();
    return pendingNotifications;
  }

  //TODO 5: Get List Notification
  Future<List<NotificationModel>> getCurrentNotifications() async {
    tz.initializeTimeZones();
    List<PendingNotificationRequest> pendingNotifications =
        await getPendingNotifications();

    List<NotificationModel> notifications = pendingNotifications.map((request) {
      return NotificationModel(
        id: request.id,
        title: request.title ?? '',
        body: request.body ?? '',
        time: convertPayloadToTime(request.payload ?? ''),
      );
    }).toList();

    return notifications;
  }
}
