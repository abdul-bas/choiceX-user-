import 'package:coice/data/models/cart_model/cart_model.dart';
import 'package:coice/data/repository/auth_repository.dart';
import 'package:flutter/material.dart';
class CartState extends ChangeNotifier {
  final AuthRepository authRepository = AuthRepository();

  List<CartModel> _items = [];
  List<CartModel> get items => _items;

 
  double get subTotal =>
      _items.fold(0, (sum, cart) => sum + cart.discountPrice * cart.quantity);

  double get total =>
      _items.fold(0, (sum, cart) => sum + cart.price * cart.quantity);

  
  double get deductedAmount =>
      total - subTotal;

  double get totalSavings =>
      _items.fold(0, (sum, cart) => sum + cart.savedAmount);

  void setCartItems(List<CartModel> carts) {
    _items = carts;
    notifyListeners();
  }

  void clearAll() {
    _items.clear();
    notifyListeners();
  }
}