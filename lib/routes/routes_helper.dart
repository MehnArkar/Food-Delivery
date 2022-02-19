import 'package:food_delivery/page/food/popular_food_detail.dart';
import 'package:food_delivery/page/food/recommended_food_detail.dart';
import 'package:food_delivery/page/home/main_food_page.dart';
import 'package:get/get.dart';

class RouteHelper {
  static const String initial = "/";
  static const String popularDetail = "/popularDetail";
  static const String recommendedDetail = "/recommendedDetail";

  static String getInitial() => '$initial';
  static String getPopularDetail(int pageId) => '$popularDetail?pageId=$pageId';
  static String getRecommendedDetail(int pageId) =>
      '$recommendedDetail?pageId=$pageId';

  static List<GetPage> routes = [
    GetPage(name: initial, page: () => MainFoodPage()),
    GetPage(
        name: popularDetail,
        page: () {
          var pageId = Get.parameters['pageId'];
          return PopularFoodDetail(
            pageId: int.parse(pageId.toString()),
          );
        },
        transition: Transition.rightToLeftWithFade),
    GetPage(
        name: recommendedDetail,
        page: () {
          var pageId = Get.parameters['pageId'];
          return RecommendedFoodDetail(pageId: int.parse(pageId.toString()));
        },
        transition: Transition.fadeIn),
  ];
}
