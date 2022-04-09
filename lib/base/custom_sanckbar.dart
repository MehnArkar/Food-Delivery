import 'package:flutter/material.dart';
import 'package:food_delivery/widgets/big_text.dart';
import 'package:food_delivery/widgets/small_text.dart';
import 'package:get/get.dart';

void showCustomSnackbar(String message,
    {bool isError = true, String title = "Error"}) {
  Get.snackbar(title, message,
      titleText: BigText(
        text: title,
        color: Colors.white,
      ),
      messageText: SmallText(
        text: message,
        color: Colors.white,
      ),
      backgroundColor: Colors.redAccent,
      snackPosition: SnackPosition.TOP,
      colorText: Colors.white);
}
