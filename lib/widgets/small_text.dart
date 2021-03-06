import 'package:flutter/material.dart';
import 'package:food_delivery/utils/colors.dart';

class SmallText extends StatelessWidget {
  final String text;
  final Color? color;
  double size;
  double heigh;
  SmallText(
      {Key? key,
      required this.text,
      this.color = const Color(0xFF332d2b),
      this.size = 12,
      this.heigh = 1.2})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(fontSize: size, color: color, height: heigh),
    );
  }
}
