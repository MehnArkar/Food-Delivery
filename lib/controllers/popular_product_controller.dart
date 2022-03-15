import 'package:flutter/material.dart';
import 'package:food_delivery/controllers/cart_controller.dart';
import 'package:food_delivery/data/repository/popular_product_repo.dart';
import 'package:food_delivery/models/cart_model.dart';
import 'package:food_delivery/models/product_model.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:get/get.dart';

class PopularProductController extends GetxController {
  final PopularProductRepo popularProductRepo;
  final CartController _cartController = Get.find<CartController>();

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
      } else {
        Get.snackbar('Max quantity is 20', 'You Cannot order more than 20',
            backgroundColor: AppColors.mainColor, colorText: Colors.white);
      }
    } else if (!isIncreate) {
      if (_quantity > 0) {
        _quantity--;
        print(_quantity);
      } else {
        Get.snackbar('Quantity is 0', 'Set quantity as least 1',
            backgroundColor: AppColors.mainColor, colorText: Colors.white);
      }
    }

    update();
  }

  void initProduct(ProductModel product) {
    _quantity.value = 0;
    bool isExist = false;
    isExist = _cartController.isItemExist(product);

    if (isExist) {
      _quantity.value = _cartController.getInCartQuantity(product);
    }
  }

  void addItem(ProductModel product) {
    if (quantity > 0) {
      _cartController.addItem(product, int.parse(quantity.toString()));
    } else {
      Get.snackbar('Quantity not set', 'please set a quantity',
          backgroundColor: AppColors.mainColor, colorText: Colors.white);
    }

    _cartController.getTotalQuantity();
  }

  List<CartModel> get getItem {
    return _cartController.getItem;
  }
}
