import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomText extends StatelessWidget {
  final String? text;
  final Color? color;
  final double? size;

  const CustomText({super.key, this.text, this.color, this.size});

  @override
  Widget build(BuildContext context) {
    return Text(text!, style: GoogleFonts.roboto(color: color, fontSize: size));
  }
}
