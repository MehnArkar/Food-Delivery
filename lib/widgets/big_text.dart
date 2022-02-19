import 'package:flutter/material.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:food_delivery/utils/dimension.dart';

class BigText extends StatelessWidget {
  final String text;
  final Color? color;
  TextOverflow textOverflow;
  double size;
  BigText(
      {Key? key,
      required this.text,
      this.color = const Color(0xFF332d2b),
      this.textOverflow = TextOverflow.ellipsis,
      this.size = 0})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: 1,
      overflow: textOverflow,
      style: TextStyle(
        fontSize: size == 0 ? Dimension.fontsize20 : size,
        fontWeight: FontWeight.w500,
        color: color,
      ),
    );
  }
}
