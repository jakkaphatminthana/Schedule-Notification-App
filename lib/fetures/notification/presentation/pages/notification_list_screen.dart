import 'package:flutter/material.dart';
import 'package:flutter_local_noti/fetures/notification/domain/providers/notification_provider.dart';
import 'package:flutter_local_noti/fetures/notification/presentation/widgets/check_console.dart';
import 'package:flutter_local_noti/fetures/notification/presentation/pages/dialog_add_noti.dart';
import 'package:flutter_local_noti/fetures/notification/presentation/widgets/notification.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/services/notification_service.dart';

class NotificationListScreen extends ConsumerStatefulWidget {
  const NotificationListScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _NotificationListScreenState();
}

class _NotificationListScreenState
    extends ConsumerState<NotificationListScreen> {
  NotificationService notificationService = NotificationService();
  bool isLoading = true;

  //TODO : Function Fetch Data
  void fetchData() async {
    ref.read(notificationProvider.notifier).fetchData();
    setState(() {
      isLoading = false;
    });
  }

  //TODO : Widget Loading
  Widget loading = const Center(
    child: CircularProgressIndicator(),
  );

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  //========================================================================================================================
  @override
  Widget build(BuildContext context) {
    final notiList = ref.watch(notificationProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Notification'),
        centerTitle: true,
        backgroundColor: Theme.of(context).primaryColor,
        actions: [
          //TODO 1.1: Add Notification
          IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => const AddNotification(),
              );
            },
            icon: const Icon(Icons.add),
          ),
          //TODO 1.2: Show console
          ShowConsole(notificationService: notificationService),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: (isLoading)
            ? loading
            : (notiList.isEmpty)
                //TODO 2: Data Empty
                ? const Center(
                    child: Text('No Notification'),
                  )
                //TODO 3: Show List Data Notification
                : ListView.builder(
                    itemCount: notiList.length,
                    itemBuilder: (context, index) {
                      return NotificationCard(
                        noti: notiList[index],
                        notificationService: notificationService,
                      );
                    },
                  ),
      ),
    );
  }
}
