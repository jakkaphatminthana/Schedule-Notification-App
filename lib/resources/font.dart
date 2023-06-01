import 'package:flutter/material.dart';
import 'package:flutter_local_noti/resources/theme.dart';
import 'package:google_fonts/google_fonts.dart';

final textAppbar = GoogleFonts.getFont(
  'Prompt',
  color: Colors.black,
  fontSize: 16,
);

TextStyle textButton({required Color color}) {
  return GoogleFonts.getFont(
    'Prompt',
    color: color,
    fontSize: 16,
    fontWeight: FontWeight.w500,
  );
}

final textH2Medium = GoogleFonts.getFont(
  'Prompt',
  color: Colors.black,
  fontSize: 18,
  fontWeight: FontWeight.w500,
);

final textTitleMedium = GoogleFonts.getFont(
  'Prompt',
  color: Colors.black,
  fontSize: 16,
  fontWeight: FontWeight.w500,
);

final textTitleSmall = GoogleFonts.getFont(
  'Prompt',
  color: const Color(0xFF8B8E95),
  fontSize: 14,
);

final textBodyMedium = GoogleFonts.getFont(
  'Prompt',
  color: Colors.black,
  fontSize: 16,
);

final textBody2 = GoogleFonts.getFont(
  'Prompt',
  color: const Color(0xFF8B8E95),
  fontSize: 14,
);

final textDescription1 = GoogleFonts.getFont(
  'Prompt',
  color: const Color(0xFF8B8E95),
  fontSize: 14,
);


final textDescription2 = GoogleFonts.getFont(
  'Prompt',
  color: const Color(0xFF8B8E95),
  fontSize: 12,
);



//-------------------------------------------------------------------------------------------------------------------------
final textTitleSmallError = GoogleFonts.getFont(
  'Prompt',
  color: Colors.redAccent,
  fontSize: 14,
);

final textTitlePrimary = GoogleFonts.getFont(
  'Prompt',
  color: theme.primaryColor,
  fontSize: 14,
);