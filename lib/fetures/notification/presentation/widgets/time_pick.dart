import 'package:flutter/material.dart';
import 'package:flutter_local_noti/resources/font.dart';

class PickerTime extends StatefulWidget {
  const PickerTime({
    super.key,
    required this.timeValue,
    required this.firstTime,
    required this.onSelect,
  });
  final TimeOfDay timeValue;
  final TimeOfDay firstTime;
  final ValueSetter<TimeOfDay> onSelect;

  @override
  State<StatefulWidget> createState() => _PickerDateState();
}

class _PickerDateState extends State<PickerTime> {
  //TODO : Function Time Picker
  void _presentTimePicker({
    required ValueSetter<TimeOfDay> onSelect,
  }) {
    showTimePicker(
      context: context,
      initialTime: widget.firstTime,
      builder: (context, childWidget) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
          child: childWidget!,
        );
      },
    ).then((pickerTime) {
      if (pickerTime == null) return;
      onSelect(pickerTime); //อัปเดตค่า
    });
  }

//===========================================================================================================================
  @override
  Widget build(BuildContext context) {
    final hour = widget.timeValue.hour.toString().padLeft(2, '0');
    final minute = widget.timeValue.minute.toString().padLeft(2, '0');

    return GestureDetector(
      onTap: () => _presentTimePicker(onSelect: widget.onSelect),
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.6,
        height: 82,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            //TODO : Continer Pick
            Container(
              width: MediaQuery.of(context).size.width,
              height: 52,
              padding: const EdgeInsets.symmetric(
                vertical: 16,
                horizontal: 16,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
                border: Border.all(
                  width: 1,
                  color: const Color(0xFFDEDEDE),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: Text('$hour:$minute'),
                  ),
                  const Icon(
                    Icons.timelapse,
                    color: Color(0xFF8B8E95),
                    size: 20,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
