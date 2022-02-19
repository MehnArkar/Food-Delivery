import 'package:food_delivery/data/repository/popular_product_repo.dart';
import 'package:food_delivery/data/repository/recommended_product_repo.dart';
import 'package:food_delivery/models/product_model.dart';
import 'package:get/get.dart';

class RecommendedProductController extends GetxController {
  final RecommendedProductRepo recommendedProductRepo;

  RecommendedProductController({required this.recommendedProductRepo});
  List<dynamic> _recommendedProductList = [];
  List<dynamic> get recommendedProductList => _recommendedProductList;
  bool _isloaded = false;
  bool get isloaded => _isloaded;

  Future<void> getRecommendedProductList() async {
    Response response =
        await recommendedProductRepo.getRecommendedproductList();
    print('getting data');
    if (response.statusCode == 200) {
      print('got data');
      _recommendedProductList = [];
      _recommendedProductList.addAll(Product.fromJson(response.body).products);
      print(_recommendedProductList.toString());
      _isloaded = true;
      update(); //like setState()
    } else {}
  }
}
