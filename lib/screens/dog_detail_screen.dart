import 'package:flutter/material.dart';
import '../models/dog_model.dart';
import '../utils/app_colors.dart';

class DogDetailScreen extends StatefulWidget {
  final Dog dog;
  const DogDetailScreen({Key? key, required this.dog}) : super(key: key);

  @override
  State<DogDetailScreen> createState() => _DogDetailScreenState();
}

class _DogDetailScreenState extends State<DogDetailScreen> {
  String? selectedSize;

  @override
  void initState() {
    super.initState();
    // Default to first available size
    if (widget.dog.availableSizes.isNotEmpty) {
      selectedSize = widget.dog.availableSizes.first;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Top bar
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back),
                      onPressed: () => Navigator.pop(context),
                    ),
                    const Text(
                      'Products',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    Stack(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.shopping_cart_outlined),
                          onPressed: () {},
                        ),
                        Positioned(
                          right: 8,
                          top: 8,
                          child: Container(
                            width: 8,
                            height: 8,
                            decoration: const BoxDecoration(
                              color: Colors.red,
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                // Dog image - restored height
                Center(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(24),
                    child: Image.network(
                      widget.dog.imageUrl,
                      height: 220, // Restored to original
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(height: 20), // Increased space between image and heading
                // Name and price
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        '${widget.dog.breed} - ${widget.dog.name}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: Colors.green[200],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        '\$${widget.dog.price.toStringAsFixed(2)}',
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                // Rating
                Row(
                  children: [
                    const Text('Rate: ', style: TextStyle(fontWeight: FontWeight.w500)),
                    const Icon(Icons.star, color: Colors.amber, size: 18),
                    Text('${widget.dog.rating}/5', style: const TextStyle(fontWeight: FontWeight.w500)),
                  ],
                ),
                const SizedBox(height: 12),
                // Size options - now clickable
                Row(
                  children: [
                    const Text('Size: ', style: TextStyle(fontWeight: FontWeight.w500)),
                    ...widget.dog.availableSizes.map((size) => Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedSize = size;
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: selectedSize == size ? Colors.orange : Colors.orange[50],
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: selectedSize == size ? Colors.orange : Colors.orange[200]!,
                              width: 1,
                            ),
                          ),
                          child: Text(
                            size,
                            style: TextStyle(
                              color: selectedSize == size ? Colors.white : Colors.black,
                              fontWeight: selectedSize == size ? FontWeight.bold : FontWeight.normal,
                            ),
                          ),
                        ),
                      ),
                    )),
                  ],
                ),
                const SizedBox(height: 16),
                // Enhanced description
                const Text('Description:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                const SizedBox(height: 8),
                Text(
                  'Meet ${widget.dog.name}, a ${widget.dog.age}-year-old ${widget.dog.breed} with a wonderful personality. ${widget.dog.description}',
                  style: const TextStyle(color: Colors.black87, fontSize: 14, height: 1.4),
                ),
                const SizedBox(height: 12),
                // Additional details
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.grey[50],
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey[200]!),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Additional Details:',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          const Icon(Icons.pets, size: 16, color: Colors.orange),
                          const SizedBox(width: 8),
                          Text('Age: ${widget.dog.age} years old', style: const TextStyle(fontSize: 13)),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          const Icon(Icons.star, size: 16, color: Colors.amber),
                          const SizedBox(width: 8),
                          Text('Rating: ${widget.dog.rating}/5', style: const TextStyle(fontSize: 13)),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          const Icon(Icons.label, size: 16, color: Colors.blue),
                          const SizedBox(width: 8),
                          Text('Tags: ${widget.dog.tags.join(", ")}', style: const TextStyle(fontSize: 13)),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 32),
                // Add to Cart button
                Center(
                  child: SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryOrange,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      onPressed: () {},
                      child: const Text(
                        'Add to Cart',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                    ),
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
