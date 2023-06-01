import 'package:intl/intl.dart';
import 'package:timezone/timezone.dart' as tz;

// Function to convert UTC time to Thailand time and format it
String convertPayloadToTime(String dateTimeString) {
  final thailandTimeZone = tz.getLocation('Asia/Bangkok');
  final dateFormat = DateFormat('yyyy-MM-dd HH:mm:ss');

  if (dateTimeString == '') return 'something wrong';

  final DateTime utcDateTime = dateFormat.parse(dateTimeString);
  final thailandDateTime = tz.TZDateTime.from(utcDateTime, thailandTimeZone)
      .add(const Duration(hours: 7));

  //Date and Time
  final formattedDateTime =
      DateFormat('yyyy-MM-dd HH:mm:ss').format(thailandDateTime);

  //Time Only
  final formattedTime = DateFormat('HH:mm').format(thailandDateTime);

  return formattedTime;
}
