import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:food_delivery/base/no_data_page.dart';
import 'package:food_delivery/controllers/cart_controller.dart';
import 'package:food_delivery/models/cart_model.dart';
import 'package:food_delivery/routes/routes_helper.dart';
import 'package:food_delivery/utils/app_constants.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:food_delivery/utils/dimension.dart';
import 'package:food_delivery/widgets/big_text.dart';
import 'package:food_delivery/widgets/small_text.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class CartHistory extends StatefulWidget {
  const CartHistory({Key? key}) : super(key: key);

  @override
  State<CartHistory> createState() => _CartHistoryState();
}

class _CartHistoryState extends State<CartHistory> {
  var getCartHistoryList =
      Get.find<CartController>().getCartHistoryList().reversed.toList();

  @override
  Widget build(BuildContext context) {
    Map<String, int> cartItemPerOrder = Map();

    for (var i = 0; i < getCartHistoryList.length; i++) {
      if (cartItemPerOrder.containsKey(getCartHistoryList[i].time)) {
        cartItemPerOrder.update(
            getCartHistoryList[i].time!, (value) => ++value);
      } else {
        cartItemPerOrder.putIfAbsent(getCartHistoryList[i].time!, () => 1);
      }
    }

    List<int> cartItemPerOrderToList() {
      return cartItemPerOrder.entries.map((e) => e.value).toList();
    }

    List<String> cartOrderTimeToList() {
      return cartItemPerOrder.entries.map((e) => e.key).toList();
    }

    List<int> itemPerOrder = cartItemPerOrderToList();

    var listCounter = 0;

    Widget timeWidget(int index) {
      var outputDate = DateTime.now().toString();
      if (index < getCartHistoryList.length) {
        var parseDate = DateFormat("yyyy-MM-dd HH:mm:ss")
            .parse(getCartHistoryList[listCounter].time!);
        var inputDate = DateTime.parse(parseDate.toString());
        var outputFormat = DateFormat("dd-MM-yyyy hh:mm a");
        outputDate = outputFormat.format(inputDate);
      }
      return BigText(
        text: outputDate,
        color: AppColors.titleColor,
      );
    }

    return Scaffold(
      body: Column(
        children: [
          //App Bar
          Container(
            width: double.maxFinite,
            height: Dimension.height20 * 3 + 25,
            padding: EdgeInsets.only(top: 25),
            color: AppColors.mainColor,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                BigText(
                  text: 'Cart History',
                  color: Colors.white,
                ),
                const Icon(
                  Icons.shopping_cart_outlined,
                  size: 25,
                  color: Colors.white,
                ),
              ],
            ),
          ),
          //Item List
          GetBuilder<CartController>(builder: (controller) {
            return controller.getCartHistoryList().length > 0
                ? Expanded(
                    child: Container(
                        child: MediaQuery.removePadding(
                    removeTop: true,
                    context: context,
                    child: ListView(
                      padding: EdgeInsets.only(
                          top: Dimension.height20,
                          left: Dimension.width20,
                          right: Dimension.width20),
                      children: [
                        for (int i = 0; i < itemPerOrder.length; i++)
                          Container(
                            margin: EdgeInsets.only(bottom: Dimension.height20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                //Time
                                timeWidget(listCounter),
                                //Image item list
                                Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Wrap(
                                        direction: Axis.horizontal,
                                        children: List.generate(itemPerOrder[i],
                                            (index) {
                                          if (listCounter <
                                              getCartHistoryList.length) {
                                            listCounter++;
                                          }
                                          return index <= 2
                                              ? Container(
                                                  width: Dimension.height20 * 5,
                                                  height:
                                                      Dimension.height20 * 5,
                                                  margin: const EdgeInsets.only(
                                                      right: 5),
                                                  decoration: BoxDecoration(
                                                      borderRadius: BorderRadius
                                                          .circular(Dimension
                                                                  .height15 /
                                                              2),
                                                      image: DecorationImage(
                                                          image: NetworkImage(AppConstants
                                                                  .BASE_URL +
                                                              AppConstants
                                                                  .IMG_URL +
                                                              getCartHistoryList[
                                                                      listCounter -
                                                                          1]
                                                                  .img!),
                                                          fit: BoxFit.cover)),
                                                )
                                              : Container();
                                        }),
                                      ),
                                      Container(
                                        height: Dimension.height20 * 5,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            SmallText(text: 'Total'),
                                            BigText(
                                              text: itemPerOrder[i].toString() +
                                                  " items",
                                              color: AppColors.titleColor,
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                var orderTime =
                                                    cartOrderTimeToList();
                                                Map<int, CartModel> cartItem =
                                                    {};
                                                for (int j = 0;
                                                    j <
                                                        getCartHistoryList
                                                            .length;
                                                    j++) {
                                                  if (getCartHistoryList[j]
                                                          .time ==
                                                      orderTime[i]) {
                                                    cartItem.putIfAbsent(
                                                        getCartHistoryList[j]
                                                            .id!,
                                                        () => CartModel.fromJson(
                                                            jsonDecode(jsonEncode(
                                                                getCartHistoryList[
                                                                    j]))));
                                                  }
                                                }

                                                Get.find<CartController>()
                                                    .setItem = cartItem;
                                                Get.find<CartController>()
                                                    .addToCartList();
                                                Get.toNamed(
                                                    RouteHelper.getCart());
                                              },
                                              child: Container(
                                                padding: EdgeInsets.symmetric(
                                                    vertical:
                                                        Dimension.height10 / 2,
                                                    horizontal:
                                                        Dimension.height10),
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          Dimension.height15 /
                                                              2),
                                                  border: Border.all(
                                                      width: 1,
                                                      color:
                                                          AppColors.mainColor),
                                                ),
                                                child: SmallText(
                                                  text: 'one more',
                                                  color: AppColors.mainColor,
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      )
                                    ]),
                              ],
                            ),
                          )
                      ],
                    ),
                  )))
                : SizedBox(
                    height: MediaQuery.of(context).size.height / 1.5,
                    child: const NoDataPage(
                      text: "You don't buy anything so far !",
                      imagePath: "assets/image/empty_box.png",
                    ),
                  );
          })
        ],
      ),
    );
  }
}
