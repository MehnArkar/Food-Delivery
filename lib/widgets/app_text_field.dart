import 'package:flutter/material.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:food_delivery/utils/dimension.dart';

class AppTextField extends StatelessWidget {
  final TextEditingController textController;
  IconData icon;
  String hintText;
  AppTextField(
      {Key? key,
      required this.textController,
      required this.icon,
      required this.hintText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Dimension.height10 * 7,
      margin:
          EdgeInsets.only(left: Dimension.height20, right: Dimension.height20),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(Dimension.height10 * 7 / 2),
          boxShadow: [
            BoxShadow(
                offset: const Offset(1, 8),
                blurRadius: 8,
                spreadRadius: 6,
                color: Colors.grey.withOpacity(0.2)),
          ]),
      child: TextField(
        controller: textController,
        decoration: InputDecoration(
          prefixIcon: Icon(
            icon,
            color: Colors.amber,
          ),
          hintText: hintText,
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(Dimension.radius30),
              borderSide: const BorderSide(
                width: 1.0,
                color: Colors.white,
              )),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(Dimension.radius30),
              borderSide: const BorderSide(
                width: 1.0,
                color: Colors.white,
              )),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(Dimension.radius30),
              borderSide: const BorderSide(
                width: 1.0,
                color: Colors.white,
              )),
        ),
      ),
    );
  }
}
