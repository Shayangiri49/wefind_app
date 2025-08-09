import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/cart_service.dart';
import '../utils/app_colors.dart';
import '../utils/responsive_helper.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Cart'),
        backgroundColor: AppColors.primaryOrange,
        foregroundColor: Colors.white,
      ),
      body: Consumer<CartService>(
        builder: (context, cartService, child) {
          if (cartService.items.isEmpty && cartService.foodItems.isEmpty) {
            return Center(
              child: Text(
                'Your cart is empty.',
                style: TextStyle(
                  fontSize: ResponsiveHelper.responsiveFontSize(context, mobile: 18),
                  color: AppColors.darkText,
                ),
              ),
            );
          }
          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: cartService.items.length + cartService.foodItems.length,
                  itemBuilder: (context, index) {
                    if (index < cartService.items.length) {
                      // Dog items
                      final item = cartService.items[index];
                      return Card(
                        margin: EdgeInsets.symmetric(
                          vertical: ResponsiveHelper.responsiveSpacing(context, mobile: 8),
                          horizontal: ResponsiveHelper.responsiveSpacing(context, mobile: 16),
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(ResponsiveHelper.responsiveBorderRadius(context, mobile: 12)),
                        ),
                        elevation: 2,
                        child: Padding(
                          padding: EdgeInsets.all(ResponsiveHelper.responsiveSpacing(context, mobile: 12)),
                          child: Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(ResponsiveHelper.responsiveBorderRadius(context, mobile: 8)),
                                child: Image.network(
                                  item.dog.imageUrl,
                                  width: ResponsiveHelper.responsiveValue(context, mobile: 80),
                                  height: ResponsiveHelper.responsiveValue(context, mobile: 80),
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) {
                                    return Container(
                                      width: ResponsiveHelper.responsiveValue(context, mobile: 80),
                                      height: ResponsiveHelper.responsiveValue(context, mobile: 80),
                                      color: Colors.grey[300],
                                      child: const Icon(Icons.pets, color: Colors.grey),
                                    );
                                  },
                                ),
                              ),
                              SizedBox(width: ResponsiveHelper.responsiveSpacing(context, mobile: 12)),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      item.dog.name,
                                      style: TextStyle(
                                        fontSize: ResponsiveHelper.responsiveFontSize(context, mobile: 16),
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.darkText,
                                      ),
                                    ),
                                    SizedBox(height: ResponsiveHelper.responsiveSpacing(context, mobile: 4)),
                                    Text(
                                      '\$${item.dog.price.toStringAsFixed(2)}',
                                      style: TextStyle(
                                        fontSize: ResponsiveHelper.responsiveFontSize(context, mobile: 14),
                                        color: AppColors.primaryOrange,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    SizedBox(height: ResponsiveHelper.responsiveSpacing(context, mobile: 8)),
                                    Row(
                                      children: [
                                        IconButton(
                                          icon: const Icon(Icons.remove_circle_outline),
                                          onPressed: () => cartService.decreaseQuantity(item),
                                          color: AppColors.primaryOrange,
                                        ),
                                        Text(
                                          '${item.quantity}',
                                          style: TextStyle(
                                            fontSize: ResponsiveHelper.responsiveFontSize(context, mobile: 16),
                                            fontWeight: FontWeight.bold,
                                            color: AppColors.darkText,
                                          ),
                                        ),
                                        IconButton(
                                          icon: const Icon(Icons.add_circle_outline),
                                          onPressed: () => cartService.increaseQuantity(item),
                                          color: AppColors.primaryOrange,
                                        ),
                                        const Spacer(),
                                        IconButton(
                                          icon: const Icon(Icons.delete_outline),
                                          onPressed: () => cartService.removeItem(item),
                                          color: Colors.red,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    } else {
                      // Food items
                      final foodIndex = index - cartService.items.length;
                      final foodItem = cartService.foodItems[foodIndex];
                      final product = foodItem['product'];
                      final quantity = foodItem['quantity'];
                      
                      return Card(
                        margin: EdgeInsets.symmetric(
                          vertical: ResponsiveHelper.responsiveSpacing(context, mobile: 8),
                          horizontal: ResponsiveHelper.responsiveSpacing(context, mobile: 16),
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(ResponsiveHelper.responsiveBorderRadius(context, mobile: 12)),
                        ),
                        elevation: 2,
                        child: Padding(
                          padding: EdgeInsets.all(ResponsiveHelper.responsiveSpacing(context, mobile: 12)),
                          child: Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(ResponsiveHelper.responsiveBorderRadius(context, mobile: 8)),
                                child: Image.network(
                                  product['image'],
                                  width: ResponsiveHelper.responsiveValue(context, mobile: 80),
                                  height: ResponsiveHelper.responsiveValue(context, mobile: 80),
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) {
                                    return Container(
                                      width: ResponsiveHelper.responsiveValue(context, mobile: 80),
                                      height: ResponsiveHelper.responsiveValue(context, mobile: 80),
                                      color: Colors.grey[300],
                                      child: const Icon(Icons.restaurant, color: Colors.grey),
                                    );
                                  },
                                ),
                              ),
                              SizedBox(width: ResponsiveHelper.responsiveSpacing(context, mobile: 12)),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      product['name'],
                                      style: TextStyle(
                                        fontSize: ResponsiveHelper.responsiveFontSize(context, mobile: 16),
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.darkText,
                                      ),
                                    ),
                                    SizedBox(height: ResponsiveHelper.responsiveSpacing(context, mobile: 4)),
                                    Text(
                                      '\$${product['price'].toStringAsFixed(2)}',
                                      style: TextStyle(
                                        fontSize: ResponsiveHelper.responsiveFontSize(context, mobile: 14),
                                        color: AppColors.primaryOrange,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    SizedBox(height: ResponsiveHelper.responsiveSpacing(context, mobile: 8)),
                                    Row(
                                      children: [
                                        IconButton(
                                          icon: const Icon(Icons.remove_circle_outline),
                                          onPressed: () => cartService.decreaseFoodQuantity(foodItem),
                                          color: AppColors.primaryOrange,
                                        ),
                                        Text(
                                          '${quantity}kg',
                                          style: TextStyle(
                                            fontSize: ResponsiveHelper.responsiveFontSize(context, mobile: 16),
                                            fontWeight: FontWeight.bold,
                                            color: AppColors.darkText,
                                          ),
                                        ),
                                        IconButton(
                                          icon: const Icon(Icons.add_circle_outline),
                                          onPressed: () => cartService.increaseFoodQuantity(foodItem),
                                          color: AppColors.primaryOrange,
                                        ),
                                        const Spacer(),
                                        IconButton(
                                          icon: const Icon(Icons.delete_outline),
                                          onPressed: () => cartService.removeFoodItem(foodItem),
                                          color: Colors.red,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.all(ResponsiveHelper.responsiveSpacing(context, mobile: 16)),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Total:',
                          style: TextStyle(
                            fontSize: ResponsiveHelper.responsiveFontSize(context, mobile: 20),
                            fontWeight: FontWeight.bold,
                            color: AppColors.darkText,
                          ),
                        ),
                        Text(
                          '\$${cartService.totalPrice.toStringAsFixed(2)}',
                          style: TextStyle(
                            fontSize: ResponsiveHelper.responsiveFontSize(context, mobile: 20),
                            fontWeight: FontWeight.bold,
                            color: AppColors.primaryOrange,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: ResponsiveHelper.responsiveSpacing(context, mobile: 16)),
                    ElevatedButton(
                      onPressed: () {
                        // Implement checkout logic here
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Proceeding to checkout...')),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryOrange,
                        foregroundColor: Colors.white,
                        minimumSize: Size(double.infinity, ResponsiveHelper.responsiveValue(context, mobile: 50)),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(ResponsiveHelper.responsiveBorderRadius(context, mobile: 12)),
                        ),
                      ),
                      child: Text(
                        'Proceed to Checkout',
                        style: TextStyle(
                          fontSize: ResponsiveHelper.responsiveFontSize(context, mobile: 18),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
