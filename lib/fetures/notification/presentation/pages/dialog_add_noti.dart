import 'package:flutter/material.dart';
import 'package:flutter_local_noti/fetures/notification/domain/providers/notification_provider.dart';
import 'package:flutter_local_noti/fetures/notification/presentation/widgets/time_pick.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../resources/font.dart';
import '../../data/services/notification_service.dart';

class AddNotification extends ConsumerStatefulWidget {
  const AddNotification({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _AddNotificationState();
}

class _AddNotificationState extends ConsumerState<AddNotification> {
  NotificationService notificationService = NotificationService();

  //TODO : Function Add Notificaion
  void addNotification({
    required int id,
    required TimeOfDay setTime,
  }) {
    //1. Send New Notification
    try {
      notificationService.secheduleNotificaion(
        id: id,
        title: 'Notification Everyday',
        body: 'Notification ID : $id',
        timeDay: setTime,
      );
    } catch (e) {
      throw Exception('Add Notification Error: $e');
    }
    //2. fetch data provider
    ref.read(notificationProvider.notifier).fetchData();
  }

  //======================================================================================================================
  @override
  Widget build(BuildContext context) {
    final timePick = ref.watch(timepickProvider);
    final data = ref.read(notificationProvider);
    int lastId = (data.isEmpty) ? 0 : data.last.id + 1; //id สำหรับสร้าง Noti

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: SizedBox(
        height: 268,
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              //TODO 1: Title Message
              FittedBox(child: Text('สร้างการแจ้งเตือน', style: textH2Medium)),
              const SizedBox(height: 8),

              //TODO 2: SubTitle
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.6,
                child: Text(
                  'เวลาแจ้งเตือน',
                  style: textDescription1,
                  textAlign: TextAlign.center,
                ),
              ),

              //TODO 3: Time Picker
              PickerTime(
                timeValue: timePick,
                firstTime: timePick,
                onSelect: (pickedTime) {
                  ref.read(timepickProvider.notifier).state = pickedTime;
                },
              ),
              const SizedBox(height: 24),

              //TODO 4: Button
              ElevatedButton(
                onPressed: () {
                  addNotification(id: lastId, setTime: timePick);
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  fixedSize: Size(MediaQuery.of(context).size.width, 52),
                  backgroundColor: Theme.of(context).primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                child: Text(
                  'เพิ่มแจ้งเตือน',
                  style: textButton(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
