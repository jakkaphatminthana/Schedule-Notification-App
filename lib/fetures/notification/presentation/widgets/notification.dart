import 'package:flutter/material.dart';
import 'package:flutter_local_noti/fetures/notification/data/models/notification_model.dart';
import 'package:flutter_local_noti/fetures/notification/domain/providers/notification_provider.dart';
import 'package:flutter_local_noti/resources/font.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/services/notification_service.dart';

class NotificationCard extends ConsumerWidget {
  NotificationCard({
    super.key,
    required this.noti,
    required this.notificationService,
  });

  NotificationModel noti;
  NotificationService notificationService;

  //TODO : Remove Notification
  void removeNotification({required int id}) {
    notificationService.stopNotifications(id: id);
  }

//=======================================================================================================================
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 80,
      child: Card(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        color: Colors.white,
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Row(
            children: [
              //TODO 1: Icon front
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.15,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.access_time,
                      color: Theme.of(context).primaryColor,
                      size: 24,
                    ),
                    FittedBox(
                      child: Text(noti.time, style: textTitlePrimary),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),

              //TODO 2: Content title
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      noti.title,
                      style: textTitleMedium,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      noti.body,
                      style: textDescription1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),

              //TODO 3: IconButton Delete
              IconButton(
                onPressed: () {
                  removeNotification(id: noti.id);
                  ref
                      .read(notificationProvider.notifier)
                      .removeData(notiId: noti.id);
                },
                icon: const Icon(
                  Icons.delete,
                  color: Color(0xFFFB5761),
                  size: 24,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
