import 'package:flutter/material.dart';
import 'package:food_delivery/page/account/account_widget.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:food_delivery/utils/dimension.dart';
import 'package:food_delivery/widgets/app_icon.dart';
import 'package:food_delivery/widgets/big_text.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.mainColor,
        title: BigText(
          text: 'Profile',
          size: 24,
          color: Colors.white,
        ),
      ),
      body: Container(
        width: double.maxFinite,
        margin: EdgeInsets.only(top: Dimension.height30),
        child: Column(
          children: [
            AppIcon(
              icon: Icons.person,
              iconColor: Colors.white,
              backgroundColor: AppColors.mainColor,
              size: Dimension.height15 * 10,
              iconSize: Dimension.height30 + Dimension.height45,
            ),
            SizedBox(
              height: Dimension.height30,
            ),
            Expanded(
                child: SingleChildScrollView(
              child: Column(
                children: [
                  //Name
                  AccountWidget(
                      appIcon: AppIcon(
                        icon: Icons.person,
                        iconColor: Colors.white,
                        backgroundColor: AppColors.mainColor,
                        size: Dimension.height10 * 5,
                        iconSize: Dimension.height10 * 5 / 2,
                      ),
                      bigText: BigText(text: 'Arkar Min')),
                  SizedBox(
                    height: Dimension.height20,
                  ),
                  //Phone
                  AccountWidget(
                      appIcon: AppIcon(
                        icon: Icons.phone,
                        iconColor: Colors.white,
                        backgroundColor: Colors.amber,
                        size: Dimension.height10 * 5,
                        iconSize: Dimension.height10 * 5 / 2,
                      ),
                      bigText: BigText(text: '09255905973')),
                  SizedBox(
                    height: Dimension.height20,
                  ),
                  //Email
                  AccountWidget(
                      appIcon: AppIcon(
                        icon: Icons.email,
                        iconColor: Colors.white,
                        backgroundColor: Colors.amber,
                        size: Dimension.height10 * 5,
                        iconSize: Dimension.height10 * 5 / 2,
                      ),
                      bigText: BigText(text: 'Arkar Min')),
                  SizedBox(
                    height: Dimension.height20,
                  ),
                  //Address
                  AccountWidget(
                      appIcon: AppIcon(
                        icon: Icons.location_on_outlined,
                        iconColor: Colors.white,
                        backgroundColor: Colors.amber,
                        size: Dimension.height10 * 5,
                        iconSize: Dimension.height10 * 5 / 2,
                      ),
                      bigText: BigText(text: 'Arkar Min')),
                  SizedBox(
                    height: Dimension.height20,
                  ),
                  //Message
                  AccountWidget(
                      appIcon: AppIcon(
                        icon: Icons.message,
                        iconColor: Colors.white,
                        backgroundColor: Colors.redAccent,
                        size: Dimension.height10 * 5,
                        iconSize: Dimension.height10 * 5 / 2,
                      ),
                      bigText: BigText(text: 'Arkar Min')),
                  SizedBox(
                    height: Dimension.height20,
                  ),
                  //logout
                  AccountWidget(
                      appIcon: AppIcon(
                        icon: Icons.logout,
                        iconColor: Colors.white,
                        backgroundColor: Colors.redAccent,
                        size: Dimension.height10 * 5,
                        iconSize: Dimension.height10 * 5 / 2,
                      ),
                      bigText: BigText(text: 'Arkar Min')),
                  SizedBox(
                    height: Dimension.height20,
                  ),
                ],
              ),
            ))
          ],
        ),
      ),
    );
  }
}
