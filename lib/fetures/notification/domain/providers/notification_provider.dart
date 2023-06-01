import 'package:flutter/material.dart';
import 'package:flutter_local_noti/fetures/notification/data/models/notification_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/services/notification_service.dart';

class NotificationNotifier extends StateNotifier<List<NotificationModel>> {
  NotificationNotifier() : super([]);

  //Notification service
  NotificationService notificationService = NotificationService();

  //TODO 1: Fetch Data Pending
  Future<bool> fetchData() async {
    //1. Get PendingNotificationRequest
    List<NotificationModel> currentNotification =
        await notificationService.getCurrentNotifications();

    //2. Set Data
    state = [...currentNotification];
    return true;
  }

  //TODO 2: Remove by Id
  void removeData({required int notiId}) {
    state = state.where((noti) => noti.id != notiId).toList();
  }
}

//=======================================================================================================================
final notificationProvider =
    StateNotifierProvider<NotificationNotifier, List<NotificationModel>>(
  (ref) => NotificationNotifier(),
);

final timepickProvider = StateProvider.autoDispose<TimeOfDay>(
  (ref) => TimeOfDay.now(),
);
