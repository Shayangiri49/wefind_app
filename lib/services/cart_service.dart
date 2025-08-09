import 'package:flutter/material.dart';
import '../models/cart_item.dart';
import '../models/dog_model.dart';

class CartService extends ChangeNotifier {
  final List<CartItem> _items = [];
  final List<Map<String, dynamic>> _foodItems = [];

  List<CartItem> get items => _items;
  List<Map<String, dynamic>> get foodItems => _foodItems;

  void addItem(Dog dog) {
    int index = _items.indexWhere((item) => item.dog.name == dog.name);
    if (index != -1) {
      _items[index].quantity++;
    } else {
      _items.add(CartItem(dog: dog));
    }
    notifyListeners();
  }

  void addFoodItem(Map<String, dynamic> foodProduct, {int quantity = 1}) {
    int index = _foodItems.indexWhere((item) => item['product']['name'] == foodProduct['name']);
    if (index != -1) {
      _foodItems[index]['quantity'] += quantity;
    } else {
      _foodItems.add({
        'product': foodProduct,
        'quantity': quantity,
      });
    }
    notifyListeners();
  }

  void removeItem(CartItem item) {
    _items.remove(item);
    notifyListeners();
  }

  void removeFoodItem(Map<String, dynamic> foodItem) {
    _foodItems.remove(foodItem);
    notifyListeners();
  }

  void increaseQuantity(CartItem item) {
    item.quantity++;
    notifyListeners();
  }

  void increaseFoodQuantity(Map<String, dynamic> foodItem) {
    foodItem['quantity']++;
    notifyListeners();
  }

  void decreaseQuantity(CartItem item) {
    if (item.quantity > 1) {
      item.quantity--;
    } else {
      _items.remove(item);
    }
    notifyListeners();
  }

  void decreaseFoodQuantity(Map<String, dynamic> foodItem) {
    if (foodItem['quantity'] > 1) {
      foodItem['quantity']--;
    } else {
      _foodItems.remove(foodItem);
    }
    notifyListeners();
  }

  double get totalPrice {
    double dogTotal = _items.fold(0.0, (total, current) => total + current.totalPrice);
    double foodTotal = _foodItems.fold(0.0, (total, current) => 
        total + (current['product']['price'] * current['quantity']));
    return dogTotal + foodTotal;
  }

  int get totalItems {
    int dogItems = _items.fold(0, (total, current) => total + current.quantity);
    int foodItemsCount = _foodItems.fold(0, (total, current) => total + current['quantity'] as int);
    return dogItems + foodItemsCount;
  }

  void clearCart() {
    _items.clear();
    _foodItems.clear();
    notifyListeners();
  }
}
