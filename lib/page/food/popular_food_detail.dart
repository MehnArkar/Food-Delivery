import 'package:flutter/material.dart';
import 'package:food_delivery/controllers/popular_product_controller.dart';
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
    popularController.initProduct();
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
                  AppIcon(icon: Icons.shopping_cart_outlined)
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
      bottomNavigationBar: Container(
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
                Obx(() => BigText(text: popularController.quantity.toString())),
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
            Container(
              padding: EdgeInsets.all(Dimension.width20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimension.radius20),
                color: AppColors.mainColor,
              ),
              child: Text('\$ ${popularFood.price} | Add to cart'),
            )
          ],
        ),
      ),
    );
  }
}
