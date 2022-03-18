import 'package:food_delivery/controllers/popular_product_controller.dart';
import 'package:food_delivery/controllers/recommend_product_controller.dart';
import 'package:food_delivery/data/repository/cart_repo.dart';
import 'package:food_delivery/models/cart_model.dart';
import 'package:food_delivery/models/product_model.dart';
import 'package:get/get.dart';

class CartController extends GetxController {
  final CartRepo cartRepo;
  CartController({required this.cartRepo});

  Map<int, CartModel> _item = {};
  Map<int, CartModel> get item => _item;

  var _totalQuantity = 0.obs;
  int get totalQuantity => _totalQuantity.value;

  void addItem(ProductModel product, int quantity) {
    //Check if contain
    if (_item.containsKey(product.id)) {
      //Check to remove item if quantity is zero
      if (_item[product.id]!.quantity! + quantity != 0) {
        _item.update(product.id!, (value) {
          return CartModel(
              id: value.id,
              name: value.name,
              price: value.price,
              img: value.img,
              quantity: value.quantity! + quantity,
              isExist: true,
              time: DateTime.now().toString(),
              product: product);
        });
      } else {
        _item.remove(product.id);
        //Reset Popular
        Get.find<PopularProductController>().initProduct(product);
        Get.find<PopularProductController>().update();
      }
    } else {
      _item.putIfAbsent(product.id!, () {
        return CartModel(
            id: product.id,
            name: product.name,
            price: product.price,
            img: product.img,
            quantity: quantity,
            isExist: true,
            time: DateTime.now().toString(),
            product: product);
      });
    }
    _item.forEach((key, value) {
      print('Cart Id $key quantity ${value.quantity} added ');
    });
    getTotalQuantity();
    update();
  }

  bool isItemExist(ProductModel product) {
    if (_item.containsKey(product.id)) {
      return true;
    } else {
      return false;
    }
  }

  int getInCartQuantity(ProductModel product) {
    var quantity;
    _item.forEach((key, value) {
      if (key == product.id) {
        quantity = value.quantity;
        return quantity;
      }
    });
    return quantity;
  }

  void getTotalQuantity() {
    _totalQuantity.value = 0;
    _item.forEach((key, value) {
      _totalQuantity += value.quantity!;
    });
  }

  List<CartModel> get getItem {
    return _item.entries.map((e) {
      return e.value;
    }).toList();
  }

  int get totalAmount {
    var total = 0;

    _item.forEach((key, value) {
      total += value.price! * value.quantity!;
    });

    return total;
  }
}
