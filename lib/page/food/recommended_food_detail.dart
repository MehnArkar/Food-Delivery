import 'package:flutter/material.dart';
import 'package:food_delivery/controllers/cart_controller.dart';
import 'package:food_delivery/controllers/popular_product_controller.dart';
import 'package:food_delivery/controllers/recommend_product_controller.dart';
import 'package:food_delivery/models/product_model.dart';
import 'package:food_delivery/page/cart/cart_page.dart';
import 'package:food_delivery/routes/routes_helper.dart';
import 'package:food_delivery/utils/app_constants.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:food_delivery/utils/dimension.dart';
import 'package:food_delivery/widgets/app_icon.dart';
import 'package:food_delivery/widgets/big_text.dart';
import 'package:food_delivery/widgets/expended_text.dart';
import 'package:food_delivery/widgets/small_text.dart';
import 'package:get/get.dart';

class RecommendedFoodDetail extends StatelessWidget {
  final int pageId;
  RecommendedFoodDetail({Key? key, required this.pageId}) : super(key: key);
  PopularProductController popularProductController = Get.find();

  @override
  Widget build(BuildContext context) {
    ProductModel recommendedFood =
        Get.find<RecommendedProductController>().recommendedProductList[pageId];
    popularProductController.initProduct(recommendedFood);
    return Scaffold(
        backgroundColor: Colors.white,
        body: CustomScrollView(slivers: [
          SliverAppBar(
            automaticallyImplyLeading: false,
            toolbarHeight: 70,
            pinned: true,
            backgroundColor: AppColors.yellowColor,
            expandedHeight: Dimension.fooddetailimage,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.network(
                AppConstants.BASE_URL + '/uploads/' + recommendedFood.img!,
                fit: BoxFit.cover,
                width: double.maxFinite,
              ),
            ),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: AppIcon(icon: Icons.arrow_back_ios)),
                Obx(() {
                  return GestureDetector(
                    onTap: () {
                      if (Get.find<CartController>().totalQuantity >= 1) {
                        Get.toNamed(RouteHelper.getCart());
                      }
                    },
                    child: Stack(
                      children: [
                        AppIcon(icon: Icons.shopping_cart_outlined),
                        Get.find<CartController>().totalQuantity >= 1
                            ? Positioned(
                                right: 0,
                                top: 0,
                                child: Container(
                                    width: 20,
                                    height: 20,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: AppColors.mainColor),
                                    child: Center(
                                      child: SmallText(
                                        text: Get.find<CartController>()
                                            .totalQuantity
                                            .toString(),
                                        color: Colors.white,
                                      ),
                                    )),
                              )
                            : Container(),
                      ],
                    ),
                  );
                })
              ],
            ),
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(Dimension.height20),
              child: Container(
                padding: EdgeInsets.only(
                    top: Dimension.height10 / 2, bottom: Dimension.height10),
                child: Center(
                    child: BigText(
                  text: recommendedFood.name!,
                  size: Dimension.fontsize26,
                )),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(Dimension.height20),
                      topRight: Radius.circular(Dimension.height20),
                    )),
              ),
            ),
          ),
          SliverToBoxAdapter(
              child: Column(
            children: [
              Container(
                color: Colors.white,
                padding: EdgeInsets.only(
                    left: Dimension.width20, right: Dimension.width20),
                child: ExpendedText(text: recommendedFood.description!),
              ),
            ],
          ))
        ]),
        bottomNavigationBar:
            GetBuilder<PopularProductController>(builder: (controller) {
          return Column(mainAxisSize: MainAxisSize.min, children: [
            Container(
              padding: EdgeInsets.only(
                  left: Dimension.fontsize20 * 2.5,
                  right: Dimension.fontsize20 * 2.5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      popularProductController.setQuantity(false);
                    },
                    child: AppIcon(
                        iconSize: Dimension.icon24,
                        icon: Icons.remove,
                        iconColor: Colors.white,
                        backgroundColor: AppColors.mainColor),
                  ),
                  BigText(
                    text: '\$${recommendedFood.price}' +
                        ' X ' +
                        controller.quantity.toString(),
                    size: Dimension.fontsize26,
                    color: AppColors.mainBlackColor,
                  ),
                  GestureDetector(
                    onTap: () {
                      popularProductController.setQuantity(true);
                    },
                    child: AppIcon(
                        iconSize: Dimension.icon24,
                        icon: Icons.add,
                        iconColor: Colors.white,
                        backgroundColor: AppColors.mainColor),
                  ),
                ],
              ),
            ),
            Container(
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
                    child: Icon(
                      Icons.favorite,
                      color: AppColors.mainColor,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      popularProductController.addItem(recommendedFood);
                    },
                    child: Container(
                      padding: EdgeInsets.all(Dimension.width20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(Dimension.radius20),
                        color: AppColors.mainColor,
                      ),
                      child: Text('\$ ${recommendedFood.price} | Add to cart'),
                    ),
                  )
                ],
              ),
            ),
          ]);
        }));
  }
}
