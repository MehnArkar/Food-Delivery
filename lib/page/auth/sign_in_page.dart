import 'dart:ui';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/page/auth/sign_up_page.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:food_delivery/utils/dimension.dart';
import 'package:food_delivery/widgets/app_text_field.dart';
import 'package:food_delivery/widgets/big_text.dart';
import 'package:get/get.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();

    var imageList = ['g.png', 'f.png', 't.png'];
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: Dimension.screenHeight * 0.05,
            ),
            Container(
              height: Dimension.screenHeight * 0.25,
              child: const Center(
                child: CircleAvatar(
                  backgroundImage: AssetImage('assets/image/logo part 1.png'),
                  radius: 80,
                  backgroundColor: Colors.white,
                ),
              ),
            ),
            //Hello Tags
            Container(
              width: double.maxFinite,
              margin: EdgeInsets.only(left: Dimension.height20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Hello',
                    style: TextStyle(
                        fontSize: Dimension.height10 * 7,
                        fontWeight: FontWeight.bold,
                        color: AppColors.mainBlackColor),
                  ),
                  Text(
                    'Sign into your account',
                    style: TextStyle(
                        fontSize: Dimension.fontsize20,
                        color: Colors.grey[500]),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: Dimension.height20,
            ),
            //email
            AppTextField(
                textController: emailController,
                icon: Icons.mail,
                hintText: 'Email'),
            SizedBox(
              height: Dimension.height20,
            ),
            //passwored
            AppTextField(
                textController: passwordController,
                icon: Icons.password_outlined,
                hintText: 'Password'),
            SizedBox(
              height: Dimension.screenHeight * 0.05,
            ),

            //Sign In btn
            Container(
              width: Dimension.screenWidth / 2,
              height: Dimension.screenHeight / 13,
              decoration: BoxDecoration(
                color: AppColors.mainColor,
                borderRadius: BorderRadius.circular(Dimension.radius30),
              ),
              child: Center(
                child: BigText(
                  text: "Sign In",
                  color: Colors.white,
                  size: Dimension.fontsize20 + Dimension.fontsize20 / 2,
                ),
              ),
            ),

            SizedBox(
              height: Dimension.screenHeight * 0.05,
            ),
            //tag line
            RichText(
              text: TextSpan(
                  text: "Don't have an account? ",
                  style: TextStyle(
                      color: Colors.grey[500], fontSize: Dimension.fontsize20),
                  children: [
                    TextSpan(
                        text: 'Create',
                        recognizer: TapGestureRecognizer()
                          ..onTap = () => Get.to(() => SignUpPage(),
                              transition: Transition.fade),
                        style: TextStyle(
                            color: AppColors.mainBlackColor,
                            fontSize: Dimension.fontsize20,
                            fontWeight: FontWeight.bold)),
                  ]),
            ),
          ],
        ),
      ),
    );
  }
}
