import '../models/dog_model.dart';

class CartItem {
  final Dog dog;
  int quantity;

  CartItem({
    required this.dog,
    this.quantity = 1,
  });

  double get totalPrice => dog.price * quantity;

  // Method to create a CartItem from a JSON map
  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      dog: Dog.fromJson(json['dog']),
      quantity: json['quantity'],
    );
  }

  // Method to convert a CartItem to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'dog': dog.toJson(),
      'quantity': quantity,
    };
  }
}
