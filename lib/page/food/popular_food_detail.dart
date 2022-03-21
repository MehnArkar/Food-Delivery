import 'package:flutter/material.dart';
import 'package:food_delivery/controllers/cart_controller.dart';
import 'package:food_delivery/controllers/popular_product_controller.dart';
import 'package:food_delivery/models/product_model.dart';
import 'package:food_delivery/page/cart/cart_page.dart';
import 'package:food_delivery/routes/routes_helper.dart';
import 'package:food_delivery/utils/app_constants.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:food_delivery/utils/dimension.dart';
import 'package:food_delivery/widgets/app_colum.dart';
import 'package:food_delivery/widgets/app_icon.dart';
import 'package:food_delivery/widgets/big_text.dart';
import 'package:food_delivery/widgets/expended_text.dart';
import 'package:food_delivery/widgets/icon_and_text.dart';
import 'package:food_delivery/widgets/small_text.dart';
import 'package:get/get.dart';

class PopularFoodDetail extends StatefulWidget {
  final int pageId;
  const PopularFoodDetail({Key? key, required this.pageId}) : super(key: key);

  @override
  State<PopularFoodDetail> createState() => _PopularFoodDetailState();
}

class _PopularFoodDetailState extends State<PopularFoodDetail> {
  @override
  Widget build(BuildContext context) {
    var popularFood =
        Get.find<PopularProductController>().popularProductList[widget.pageId];
    PopularProductController popularController = Get.find();
    popularController.initProduct(popularFood);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Positioned(
            left: 0,
            right: 0,
            child: Container(
              width: double.maxFinite,
              height: Dimension.fooddetailimage,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(
                        AppConstants.BASE_URL + '/uploads/' + popularFood.img!),
                    fit: BoxFit.cover),
              ),
            ),
          ),
          Positioned(
              top: Dimension.height45,
              left: Dimension.width20,
              right: Dimension.width20,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                      onTap: () {
                        Get.back();
                      },
                      child: AppIcon(icon: Icons.arrow_back_ios)),
                  GetBuilder<CartController>(builder: ((controller) {
                    return GestureDetector(
                      onTap: () {
                        if (controller.totalQuantity >= 1) {
                          Get.toNamed(RouteHelper.getCart());
                        }
                      },
                      child: Stack(
                        children: [
                          const AppIcon(icon: Icons.shopping_cart_outlined),
                          controller.totalQuantity >= 1
                              ? Positioned(
                                  right: 0,
                                  top: 0,
                                  child: Container(
                                      width: 20,
                                      height: 20,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: AppColors.mainColor),
                                      child: Center(
                                        child: SmallText(
                                          text: controller.totalQuantity
                                              .toString(),
                                          color: Colors.white,
                                        ),
                                      )),
                                )
                              : Container(),
                        ],
                      ),
                    );
                  }))
                ],
              )),
          Positioned(
              top: Dimension.fooddetailimage - Dimension.height20,
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                  padding: EdgeInsets.only(
                      left: Dimension.width20,
                      right: Dimension.width20,
                      top: Dimension.height20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(Dimension.radius20),
                      topRight: Radius.circular(Dimension.radius20),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppColum(
                        text: popularFood.name,
                      ),
                      SizedBox(
                        height: Dimension.height20,
                      ),
                      BigText(text: 'Introduce'),
                      SizedBox(
                        height: Dimension.height10,
                      ),
                      Expanded(
                          child: SingleChildScrollView(
                              child: ExpendedText(
                        text: popularFood.description,
                      )))
                    ],
                  )))
        ],
      ),
      bottomNavigationBar:
          GetBuilder<PopularProductController>(builder: (controller) {
        return Container(
          padding: EdgeInsets.only(
              top: Dimension.height30,
              bottom: Dimension.height30,
              left: Dimension.width20,
              right: Dimension.width20),
          height: Dimension.height120,
          width: double.maxFinite,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(Dimension.radius20 * 2),
            color: AppColors.buttonBackgroundColor,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.all(Dimension.width20),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Dimension.radius20),
                    color: Colors.white),
                child: Row(children: [
                  GestureDetector(
                    onTap: () {
                      popularController.setQuantity(false);
                    },
                    child: Icon(
                      Icons.remove,
                      color: AppColors.signColor,
                    ),
                  ),
                  SizedBox(
                    width: Dimension.width10,
                  ),
                  BigText(text: controller.quantity.toString()),
                  SizedBox(
                    width: Dimension.width10,
                  ),
                  GestureDetector(
                    onTap: () {
                      popularController.setQuantity(true);
                    },
                    child: Icon(
                      Icons.add,
                      color: AppColors.signColor,
                    ),
                  )
                ]),
              ),
              GestureDetector(
                onTap: () {
                  popularController.addItem(popularFood);
                },
                child: Container(
                  padding: EdgeInsets.all(Dimension.width20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Dimension.radius20),
                    color: AppColors.mainColor,
                  ),
                  child: Text(
                    '\$ ${popularFood.price * controller.quantity.value} | Add to cart',
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              )
            ],
          ),
        );
      }),
    );
  }
}
