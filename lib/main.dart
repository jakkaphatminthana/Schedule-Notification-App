import 'package:flutter/material.dart';
import 'package:flutter_local_noti/fetures/notification/data/services/notification_service.dart';
import 'package:flutter_local_noti/fetures/notification/presentation/pages/notification_list_screen.dart';
import 'package:flutter_local_noti/resources/theme.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NotificationService().initNotification(); //Inject Notification
  runApp(const ProviderScope(child: MyApp())); //Inject Riverpod
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Local_notifications',
      theme: theme,
      debugShowCheckedModeBanner: false,
      home: const NotificationListScreen(),
    );
  }
}
