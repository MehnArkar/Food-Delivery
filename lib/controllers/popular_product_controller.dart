import 'package:food_delivery/data/repository/popular_product_repo.dart';
import 'package:food_delivery/models/product_model.dart';
import 'package:get/get.dart';

class PopularProductController extends GetxController {
  final PopularProductRepo popularProductRepo;

  PopularProductController({required this.popularProductRepo});
  List<dynamic> _popularProductList = [];
  List<dynamic> get popularProductList => _popularProductList;

  bool _isloaded = false;
  bool get isloaded => _isloaded;

  RxInt _quantity = 0.obs;
  RxInt get quantity => _quantity;

  Future<void> getPopularProductList() async {
    Response response = await popularProductRepo.getPopularproductList();
    print('getting data');
    if (response.statusCode == 200) {
      print('got data');
      _popularProductList = [];
      _popularProductList.addAll(Product.fromJson(response.body).products);
      print(_popularProductList.toString());
      _isloaded = true;
      update(); //like setState()
    } else {}
  }

  void setQuantity(bool isIncreate) {
    if (isIncreate) {
      if (_quantity < 20) {
        _quantity++;
        print(_quantity);
      }
    } else if (!isIncreate) {
      if (_quantity > 0) {
        _quantity--;
        print(_quantity);
      }
    }
  }

  void initProduct() {
    _quantity.value = 0;
  }
}
