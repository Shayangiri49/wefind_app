import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/product_card.dart';
import '../screens/product_detail_screen.dart';
import '../utils/app_colors.dart';
import '../services/cart_service.dart';

class FoodScreen extends StatefulWidget {
  const FoodScreen({Key? key}) : super(key: key);

  @override
  State<FoodScreen> createState() => _FoodScreenState();
}

class _FoodScreenState extends State<FoodScreen> {
  final int _currentIndex = 0;
  final List<Map<String, dynamic>> _foodProducts = [
    {
      'name': 'Royal Canin Adult',
      'price': 45.99,
      'image': 'https://images.unsplash.com/photo-1589924691995-400dc9ecc119?w=400&h=400&fit=crop&crop=center',
      'description': 'Premium dry food for adult dogs with balanced nutrition and essential vitamins.',
      'isFavorite': false,
      'rating': 4.7,
      'reviews': 89,
      'weight': 2.5,
    },
    {
      'name': 'Pedigree Puppy',
      'price': 32.50,
      'image': 'https://images.unsplash.com/photo-1589924691995-400dc9ecc119?w=400&h=400&fit=crop&crop=center',
      'description': 'Specially formulated for growing puppies with high protein content.',
      'isFavorite': false,
      'rating': 4.3,
      'reviews': 156,
      'weight': 1.5,
    },
    {
      'name': 'Purina Pro Plan',
      'price': 58.75,
      'image': 'https://images.unsplash.com/photo-1589924691995-400dc9ecc119?w=400&h=400&fit=crop&crop=center',
      'description': 'Advanced nutrition with real chicken as the first ingredient.',
      'isFavorite': false,
      'rating': 4.8,
      'reviews': 203,
      'weight': 3.0,
    },
    {
      'name': 'Hill\'s Science Diet',
      'price': 42.99,
      'image': 'https://images.unsplash.com/photo-1589924691995-400dc9ecc119?w=400&h=400&fit=crop&crop=center',
      'description': 'Veterinarian recommended nutrition for optimal health and vitality.',
      'isFavorite': false,
      'rating': 4.6,
      'reviews': 178,
      'weight': 2.0,
    },
    {
      'name': 'Blue Buffalo Life',
      'price': 65.25,
      'image': 'https://images.unsplash.com/photo-1589924691995-400dc9ecc119?w=400&h=400&fit=crop&crop=center',
      'description': 'Natural ingredients with real meat and wholesome grains.',
      'isFavorite': false,
      'rating': 4.9,
      'reviews': 267,
      'weight': 4.0,
    },
    {
      'name': 'Iams Proactive',
      'price': 38.99,
      'image': 'https://images.unsplash.com/photo-1589924691995-400dc9ecc119?w=400&h=400&fit=crop&crop=center',
      'description': 'Complete nutrition with essential nutrients for daily health.',
      'isFavorite': false,
      'rating': 4.4,
      'reviews': 134,
      'weight': 1.8,
    },
    {
      'name': 'Nutro Ultra',
      'price': 52.50,
      'image': 'https://images.unsplash.com/photo-1589924691995-400dc9ecc119?w=400&h=400&fit=crop&crop=center',
      'description': 'Premium blend with three proteins from chicken, lamb, and salmon.',
      'isFavorite': false,
      'rating': 4.7,
      'reviews': 189,
      'weight': 2.2,
    },
    {
      'name': 'Wellness Complete',
      'price': 48.75,
      'image': 'https://images.unsplash.com/photo-1589924691995-400dc9ecc119?w=400&h=400&fit=crop&crop=center',
      'description': 'Natural dry food with real meat and wholesome ingredients.',
      'isFavorite': false,
      'rating': 4.5,
      'reviews': 145,
      'weight': 2.8,
    },
    {
      'name': 'Merrick Grain Free',
      'price': 71.99,
      'image': 'https://images.unsplash.com/photo-1589924691995-400dc9ecc119?w=400&h=400&fit=crop&crop=center',
      'description': 'Grain-free formula with real deboned beef as the first ingredient.',
      'isFavorite': false,
      'rating': 4.8,
      'reviews': 223,
      'weight': 3.5,
    },
    {
      'name': 'Taste of the Wild',
      'price': 55.25,
      'image': 'https://images.unsplash.com/photo-1589924691995-400dc9ecc119?w=400&h=400&fit=crop&crop=center',
      'description': 'High-protein, grain-free formula inspired by your dog\'s ancestral diet.',
      'isFavorite': false,
      'rating': 4.6,
      'reviews': 167,
      'weight': 2.5,
    },
    {
      'name': 'Fromm Family',
      'price': 62.50,
      'image': 'https://images.unsplash.com/photo-1589924691995-400dc9ecc119?w=400&h=400&fit=crop&crop=center',
      'description': 'Premium nutrition with balanced proteins and essential fatty acids.',
      'isFavorite': false,
      'rating': 4.7,
      'reviews': 198,
      'weight': 3.2,
    },
    {
      'name': 'Acana Heritage',
      'price': 68.99,
      'image': 'https://images.unsplash.com/photo-1589924691995-400dc9ecc119?w=400&h=400&fit=crop&crop=center',
      'description': 'Biologically appropriate food with fresh regional ingredients.',
      'isFavorite': false,
      'rating': 4.9,
      'reviews': 245,
      'weight': 4.5,
    },
  ];

  void _openProductDetail(Map<String, dynamic> product) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProductDetailScreen(product: product),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.primaryOrange),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'Dog Food',
          style: TextStyle(
            color: AppColors.primaryOrange,
            fontWeight: FontWeight.w600,
            fontSize: 22,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.home, color: AppColors.primaryOrange),
            tooltip: 'Home',
            onPressed: () {
              Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
            },
          ),
          IconButton(
            icon: const Icon(Icons.medical_services, color: AppColors.primaryOrange),
            tooltip: 'Doctor',
            onPressed: () {
              Navigator.pushNamedAndRemoveUntil(context, '/doctor', (route) => false);
            },
          ),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFFFF8F0),
              Color(0xFFFFE0B2),
            ],
          ),
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(36)),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
            child: Column(
              children: [
                // Search bar
                Container(
                  margin: const EdgeInsets.only(bottom: 18),
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.search, color: Colors.grey, size: 22),
                      const SizedBox(width: 8),
                      Expanded(
                        child: TextField(
                          decoration: const InputDecoration(
                            hintText: 'Search dog food...',
                            border: InputBorder.none,
                            isDense: true,
                          ),
                          onChanged: (value) {
                            // Optionally implement search logic
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                // Food products grid
                Expanded(
                  child: GridView.builder(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.75,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 20,
                    ),
                    itemCount: _foodProducts.length,
                    itemBuilder: (context, index) {
                      final product = _foodProducts[index];
                      return ProductCard(
                        name: product['name'],
                        price: product['price'],
                        imageUrl: product['image'],
                        isFavorite: product['isFavorite'] ?? false,
                        onTap: () => _openProductDetail(product),
                        onFavoriteTap: () {
                          setState(() {
                            product['isFavorite'] = !(product['isFavorite'] ?? false);
                          });
                        },
                        onAddToCart: () {
                          final cartService = Provider.of<CartService>(context, listen: false);
                          cartService.addFoodItem(product);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('${product['name']} added to cart!'),
                              backgroundColor: AppColors.primaryOrange,
                              duration: const Duration(seconds: 2),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
