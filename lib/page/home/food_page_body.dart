import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/controllers/popular_product_controller.dart';
import 'package:food_delivery/controllers/recommend_product_controller.dart';
import 'package:food_delivery/models/product_model.dart';
import 'package:food_delivery/routes/routes_helper.dart';
import 'package:food_delivery/utils/app_constants.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:food_delivery/utils/dimension.dart';
import 'package:food_delivery/widgets/app_colum.dart';
import 'package:food_delivery/widgets/big_text.dart';
import 'package:food_delivery/widgets/icon_and_text.dart';
import 'package:food_delivery/widgets/small_text.dart';
import 'package:get/get.dart';

class FoodPageBody extends StatefulWidget {
  const FoodPageBody({Key? key}) : super(key: key);

  @override
  _FoodPageBodyState createState() => _FoodPageBodyState();
}

class _FoodPageBodyState extends State<FoodPageBody> {
  PageController _pageController = PageController(viewportFraction: 0.85);
  var _currentPageValue = 0.0;
  double _scaleFactor = 0.8;
  double _height = Dimension.pageViewContainer;

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      setState(() {
        _currentPageValue = _pageController.page!;
      });
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //slider section
        GetBuilder<PopularProductController>(builder: (productController) {
          return productController.isloaded
              ? Container(
                  height: Dimension.pageView,
                  child: PageView.builder(
                      controller: _pageController,
                      itemCount: productController.popularProductList.length,
                      itemBuilder: (context, indext) => _buildFoodPage(indext,
                          productController.popularProductList[indext])),
                )
              : CircularProgressIndicator(
                  color: AppColors.mainColor,
                );
        }),

        //Dot indicator section
        GetBuilder<PopularProductController>(
            builder: (popularProductController) {
          return DotsIndicator(
            dotsCount: popularProductController.popularProductList.length <= 0
                ? 1
                : popularProductController.popularProductList.length,
            position: _currentPageValue,
            decorator: DotsDecorator(
              activeColor: AppColors.mainColor,
              size: const Size.square(9.0),
              activeSize: const Size(18.0, 9.0),
              activeShape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0)),
            ),
          );
        }),

        SizedBox(
          height: Dimension.height30,
        ),
        //Popular food pairing
        Container(
          margin: EdgeInsets.only(left: Dimension.width30),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              BigText(text: 'Recommended'),
              SizedBox(
                width: Dimension.width10,
              ),
              Container(
                  margin: EdgeInsets.only(bottom: 3),
                  child: BigText(
                    text: '.',
                    color: Colors.grey,
                  )),
              SizedBox(
                width: Dimension.width10,
              ),
              Container(
                  margin: EdgeInsets.only(bottom: 1),
                  child: SmallText(
                    text: 'Food Pairing',
                  )),
            ],
          ),
        ),
        SizedBox(
          height: Dimension.height30,
        ),
        //Recommended Food list
        GetBuilder<RecommendedProductController>(
            builder: (recommendedController) {
          return recommendedController.isloaded
              ? ListView.builder(
                  padding: EdgeInsets.zero,
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount:
                      recommendedController.recommendedProductList.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Get.toNamed(RouteHelper.getRecommendedDetail(index));
                      },
                      child: Container(
                        margin: EdgeInsets.only(
                            left: Dimension.width20,
                            right: Dimension.width20,
                            bottom: Dimension.height10),
                        child: Row(
                          children: [
                            //image section
                            Container(
                              width: Dimension.listViewImageSize,
                              height: Dimension.listViewImageSize,
                              decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.circular(Dimension.radius20),
                                  image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: NetworkImage(
                                          AppConstants.BASE_URL +
                                              '/uploads/' +
                                              recommendedController
                                                  .recommendedProductList[index]
                                                  .img))),
                            ),
                            Expanded(
                              child: Container(
                                padding: EdgeInsets.only(
                                    left: Dimension.width10,
                                    right: Dimension.width10,
                                    top: Dimension.height10,
                                    bottom: Dimension.height10),
                                height: Dimension.listViewTextContext,
                                decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.grey,
                                          blurRadius: 5.0,
                                          offset: Offset(5, 0)),
                                      BoxShadow(
                                          color: Colors.white,
                                          blurRadius: 10.0,
                                          offset: Offset(0, 5)),
                                      BoxShadow(
                                          color: Colors.white,
                                          blurRadius: 5.0,
                                          offset: Offset(0, -5)),
                                    ],
                                    color: Colors.white,
                                    borderRadius: BorderRadius.only(
                                      topRight:
                                          Radius.circular(Dimension.radius20),
                                      bottomRight:
                                          Radius.circular(Dimension.radius20),
                                    )),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    BigText(
                                        text: recommendedController
                                            .recommendedProductList[index]
                                            .name),
                                    Expanded(child: Container()),
                                    Text(
                                      recommendedController
                                          .recommendedProductList[index]
                                          .description,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                          color: Color(0xFF332d2b),
                                          fontSize: 12),
                                    ),
                                    Expanded(child: Container()),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        IconAndText(
                                            icon: Icons.circle_rounded,
                                            text: 'Normal',
                                            iconColor: AppColors.iconColor1),
                                        IconAndText(
                                            icon: Icons.location_on,
                                            text: '1.7km',
                                            iconColor: AppColors.mainColor),
                                        IconAndText(
                                            icon: Icons.watch_later_outlined,
                                            text: '32min',
                                            iconColor: Colors.redAccent),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  })
              : CircularProgressIndicator(
                  color: AppColors.mainColor,
                );
        })
      ],
    );
  }

  Widget _buildFoodPage(int indext, ProductModel popularProduct) {
    //For pageview swipe annimation
    Matrix4 matrix4 = new Matrix4.identity();
    if (indext == _currentPageValue.floor()) {
      var currScale = 1 - (_currentPageValue - indext) * (1 - _scaleFactor);
      var currTrans = _height * (1 - currScale) / 2;
      matrix4 = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else if (indext == _currentPageValue.floor() + 1) {
      var currScale =
          _scaleFactor + (_currentPageValue - indext + 1) * (1 - _scaleFactor);
      var currTrans = _height * (1 - currScale) / 2;
      matrix4 = Matrix4.diagonal3Values(1, currScale, 1);
      matrix4 = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else if (indext == _currentPageValue.floor() - 1) {
      var currScale = 1 - (_currentPageValue - indext) * (1 - _scaleFactor);
      var currTrans = _height * (1 - currScale) / 2;
      matrix4 = Matrix4.diagonal3Values(1, currScale, 1);
      matrix4 = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else {
      var currScale = 0.8;
      matrix4 = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, _height * (1 - _scaleFactor) / 2, 0);
    }

    return Transform(
      transform: matrix4,
      child: Stack(
        children: [
          GestureDetector(
            onTap: () {
              Get.toNamed(RouteHelper.getPopularDetail(indext));
            },
            child: Container(
              height: Dimension.pageViewContainer,
              margin: EdgeInsets.only(
                  left: Dimension.width10, right: Dimension.width10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimension.radius30),
                  color: indext.isEven ? Colors.amber : Colors.blueAccent,
                  image: DecorationImage(
                      image: NetworkImage(AppConstants.BASE_URL +
                          '/uploads/' +
                          popularProduct.img!),
                      fit: BoxFit.cover)),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: Dimension.pageViewTextContainer,
              margin: EdgeInsets.only(
                  left: Dimension.width30,
                  right: Dimension.width30,
                  bottom: Dimension.height30),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimension.radius20),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey,
                        blurRadius: 5.0,
                        offset: Offset(0, 5)),
                    BoxShadow(color: Colors.white, offset: Offset(5, 0)),
                    BoxShadow(color: Colors.white, offset: Offset(-5, 0))
                  ]),
              child: Container(
                padding: EdgeInsets.only(
                  left: Dimension.width15,
                  right: Dimension.width15,
                  top: Dimension.height15,
                ),
                child: AppColum(
                  text: popularProduct.name!,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
