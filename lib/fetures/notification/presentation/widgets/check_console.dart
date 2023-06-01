import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import '../../../../utils/convert_payload.dart';
import '../../data/services/notification_service.dart';

class ShowConsole extends StatelessWidget {
  ShowConsole({super.key, required this.notificationService});

  NotificationService notificationService = NotificationService();

  //TODO : ไว้ใช้ดูว่า Notification ยังอยู่ไหม? เพื่อความแน่ใจ 
  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () async {
        List<PendingNotificationRequest> result =
            await notificationService.getPendingNotifications();

        if (result.isEmpty) {
          log('No Pending Notification');
          return;
        }

        for (final noti in result) {
          log('id: ${noti.id}');
          log('title: ${noti.title}');
          log('body: ${noti.body}');

          final formattedTime = convertPayloadToTime(noti.payload ?? '');
          log('scheduledDate: $formattedTime');
          log('----------------------------------');
        }
        log('');
      },
      icon: const Icon(Icons.visibility),
    );
  }
}
