import 'package:flutter/material.dart';
import 'package:food_delivery/controllers/popular_product_controller.dart';
import 'package:food_delivery/controllers/recommend_product_controller.dart';
import 'package:food_delivery/page/food/popular_food_detail.dart';
import 'package:food_delivery/page/food/recommended_food_detail.dart';
import 'package:food_delivery/page/home/food_page_body.dart';
import 'package:food_delivery/page/home/main_food_page.dart';
import 'package:food_delivery/routes/routes_helper.dart';
import 'package:get/get.dart';
import 'package:food_delivery/helper/dependencies.dart' as dep;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dep.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Get.find<PopularProductController>().getPopularProductList();
    Get.find<RecommendedProductController>().getRecommendedProductList();
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MainFoodPage(),
      initialRoute: RouteHelper.getInitial(),
      getPages: RouteHelper.routes,
    );
  }
}
