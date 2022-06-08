import 'package:get/get.dart';
import 'package:pamm2/src/models/product_detail.dart';

class CartController extends GetxController {
  final List<dynamic> _cartItems = [];

  List<dynamic> get cartItems => _cartItems;

  void addToCart(dynamic cartItem) {
    if (_cartItems.contains(cartItem)) {
      print('Item already exists');
      return;
    }

    print('Item added to cart');
    _cartItems.add(cartItem);

    update();
  }

  String getCartLength () => cartItems.length.toString();
}