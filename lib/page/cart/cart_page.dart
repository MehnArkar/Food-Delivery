import 'package:flutter/material.dart';
import 'package:food_delivery/controllers/cart_controller.dart';
import 'package:food_delivery/routes/routes_helper.dart';
import 'package:food_delivery/utils/app_constants.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:food_delivery/utils/dimension.dart';
import 'package:food_delivery/widgets/app_icon.dart';
import 'package:food_delivery/widgets/big_text.dart';
import 'package:food_delivery/widgets/small_text.dart';
import 'package:get/get.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        Positioned(
            top: Dimension.height20 * 3,
            right: Dimension.width20,
            left: Dimension.width20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () => Get.back(),
                  child: AppIcon(
                    icon: Icons.arrow_back_ios,
                    iconColor: Colors.white,
                    backgroundColor: AppColors.mainColor,
                    iconSize: Dimension.icon24,
                  ),
                ),
                const SizedBox(
                  width: 20 * 5,
                ),
                GestureDetector(
                  onTap: () {
                    Get.toNamed(RouteHelper.getInitial());
                  },
                  child: AppIcon(
                    icon: Icons.home_outlined,
                    iconColor: Colors.white,
                    backgroundColor: AppColors.mainColor,
                    iconSize: Dimension.icon24,
                  ),
                ),
                AppIcon(
                  icon: Icons.shopping_cart_outlined,
                  iconColor: Colors.white,
                  backgroundColor: AppColors.mainColor,
                  iconSize: Dimension.icon24,
                ),
              ],
            )),
        Positioned(
            top: Dimension.height20 * 5,
            left: Dimension.width20,
            right: Dimension.width20,
            bottom: 0,
            child: Container(
              margin: EdgeInsets.only(top: Dimension.height20),
              child: MediaQuery.removePadding(
                removeTop: true,
                context: context,
                child: GetBuilder<CartController>(builder: ((controller) {
                  var cartList = controller.getItem;
                  return ListView.builder(
                      itemCount: cartList.length,
                      itemBuilder: ((context, index) {
                        return Container(
                          margin: EdgeInsets.only(bottom: Dimension.height10),
                          height: Dimension.height20 * 5,
                          width: double.maxFinite,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              //img
                              Container(
                                width: Dimension.height20 * 5,
                                height: Dimension.height20 * 5,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                        Dimension.height20),
                                    image: DecorationImage(
                                        image: NetworkImage(
                                            AppConstants.BASE_URL +
                                                '/uploads/' +
                                                controller.getItem[index].img
                                                    .toString()),
                                        fit: BoxFit.cover)),
                              ),
                              SizedBox(
                                width: Dimension.width10,
                              ),

                              Expanded(
                                  child: Container(
                                height: Dimension.height20 * 5,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    BigText(
                                      text: controller.getItem[index].name
                                          .toString(),
                                      color: Colors.black54,
                                    ),
                                    SmallText(text: "Spicy"),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        BigText(
                                          text: "\$" +
                                              controller.getItem[index].price
                                                  .toString(),
                                          color: Colors.redAccent,
                                        ),

                                        //add remove
                                        Container(
                                          padding:
                                              EdgeInsets.all(Dimension.width10),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      Dimension.radius20),
                                              color: Colors.white),
                                          child: Row(children: [
                                            GestureDetector(
                                              onTap: () {
                                                //popularController.setQuantity(false);
                                              },
                                              child: Icon(
                                                Icons.remove,
                                                color: AppColors.signColor,
                                              ),
                                            ),
                                            SizedBox(
                                              width: Dimension.width10,
                                            ),
                                            BigText(
                                                text: cartList[index]
                                                    .quantity
                                                    .toString()),
                                            SizedBox(
                                              width: Dimension.width10,
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                //popularController.setQuantity(true);
                                              },
                                              child: Icon(
                                                Icons.add,
                                                color: AppColors.signColor,
                                              ),
                                            )
                                          ]),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              )),
                            ],
                          ),
                        );
                      }));
                })),
              ),
            ))
      ]),
    );
  }
}
