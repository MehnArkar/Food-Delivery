import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/base/custom_sanckbar.dart';
import 'package:food_delivery/models/signup_body_model.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:food_delivery/utils/dimension.dart';
import 'package:food_delivery/widgets/app_text_field.dart';
import 'package:food_delivery/widgets/big_text.dart';
import 'package:get/get.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    var nameController = TextEditingController();
    var phoneController = TextEditingController();

    var imageList = ['g.png', 'f.png', 't.png'];

    void _register() {
      var name = nameController.text;
      var email = emailController.text;
      var phone = phoneController.text;
      var password = passwordController.text;

      if (name.isEmpty) {
        showCustomSnackbar('Please enter your name');
      } else if (phone.isEmpty) {
        showCustomSnackbar('Please enter your phone');
      } else if (!GetUtils.isEmail(email)) {
        showCustomSnackbar('Please enter your email');
      } else if (password.isEmpty) {
        showCustomSnackbar('Please set password');
      } else if (!(password.length >= 6)) {
        showCustomSnackbar('Passwor must have at least 6 character');
      } else {
        showCustomSnackbar('Registration in process', title: 'Perfect!');
        var signUpBody = SignUpBody(
            name: name, phone: phone, email: email, password: password);
        print(signUpBody.name.toString());
      }
    }

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
            SizedBox(
              height: Dimension.height30,
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
              height: Dimension.height20,
            ),
            //Phone
            AppTextField(
                textController: phoneController,
                icon: Icons.phone,
                hintText: 'Phone'),
            SizedBox(
              height: Dimension.height20,
            ),
            //Name
            AppTextField(
                textController: nameController,
                icon: Icons.person,
                hintText: 'Name'),
            SizedBox(
              height: Dimension.height30,
            ),
            //Sign Up btn
            GestureDetector(
              onTap: () {
                _register();
              },
              child: Container(
                width: Dimension.screenWidth / 2,
                height: Dimension.screenHeight / 13,
                decoration: BoxDecoration(
                  color: AppColors.mainColor,
                  borderRadius: BorderRadius.circular(Dimension.radius30),
                ),
                child: Center(
                  child: BigText(
                    text: "Sign Up",
                    color: Colors.white,
                    size: Dimension.fontsize20 + Dimension.fontsize20 / 2,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: Dimension.height10,
            ),
            //Sign in text
            RichText(
                text: TextSpan(
                    recognizer: TapGestureRecognizer()
                      ..onTap = () => Get.back(),
                    text: "Already have an account?",
                    style: TextStyle(
                        color: Colors.grey[500],
                        fontSize: Dimension.fontsize20))),
            SizedBox(
              height: Dimension.height30,
            ),
            //tag line
            RichText(
                text: TextSpan(
                    text: "Sign up using one of the following methods",
                    style: TextStyle(
                        color: Colors.grey[500],
                        fontSize: Dimension.fontsize16))),
            Wrap(
              children: List.generate(
                  3,
                  (index) => Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CircleAvatar(
                          radius: Dimension.radius30,
                          backgroundImage:
                              AssetImage('assets/image/' + imageList[index]),
                        ),
                      )),
            )
          ],
        ),
      ),
    );
  }
}
