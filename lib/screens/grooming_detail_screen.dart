import 'package:flutter/material.dart';
import '../utils/app_colors.dart';

class GroomingDetailScreen extends StatelessWidget {
  final Map<String, dynamic> service;
  const GroomingDetailScreen({Key? key, required this.service}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Card-like container
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [AppColors.primaryOrange.withOpacity(0.08), Colors.white],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(28),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.07),
                        blurRadius: 18,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Top bar with back and status
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.arrow_back, color: AppColors.darkText),
                              onPressed: () => Navigator.pop(context),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.08),
                                    blurRadius: 4,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                              ),
                              padding: const EdgeInsets.all(10),
                              child: Icon(
                                service['available'] ? Icons.check_circle : Icons.block,
                                color: service['available'] ? Colors.green : Colors.red,
                                size: 28,
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Service image with creative background
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Container(
                              height: 140,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [AppColors.primaryOrange.withOpacity(0.15), Colors.white],
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                ),
                                borderRadius: BorderRadius.circular(24),
                              ),
                            ),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Image.network(
                                service['image'],
                                width: 120,
                                height: 120,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return Container(
                                    width: 120,
                                    height: 120,
                                    color: Colors.grey[300],
                                    child: const Center(
                                      child: Icon(
                                        Icons.content_cut,
                                        size: 40,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      // Service name and description
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              service['name'],
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: AppColors.darkText,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 6),
                            Text(
                              service['description'],
                              style: const TextStyle(
                                fontSize: 16,
                                color: AppColors.primaryOrange,
                                fontWeight: FontWeight.w600,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 12),
                      // Duration, rating, and price
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.access_time, color: AppColors.lightText, size: 20),
                            const SizedBox(width: 4),
                            Text(
                              service['duration'],
                              style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
                            ),
                            const SizedBox(width: 12),
                            const Icon(Icons.star, color: AppColors.starYellow, size: 22),
                            const SizedBox(width: 4),
                            Text(
                              '${service['rating']}',
                              style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                            ),
                            const SizedBox(width: 12),
                            const Icon(Icons.attach_money, color: AppColors.primaryOrange, size: 20),
                            const SizedBox(width: 2),
                            Text(
                              service['price'].toStringAsFixed(2),
                              style: const TextStyle(fontSize: 15, color: AppColors.primaryOrange, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 18),
                      // Details section
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Details',
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: AppColors.darkText),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Enjoy our ${service['name'].toString().toLowerCase()}: ${service['description']}. Duration: ${service['duration']}. Highly rated by pet owners for quality and care.',
                              style: const TextStyle(color: AppColors.lightText, fontSize: 15, height: 1.5),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 28),
                      // Book button
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: SizedBox(
                          width: double.infinity,
                          height: 52,
                          child: ElevatedButton.icon(
                            onPressed: service['available'] ? () {} : null,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primaryOrange,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                              elevation: 2,
                            ),
                            icon: const Icon(Icons.cut, color: Colors.white),
                            label: Text(
                              service['available'] ? 'Book Now' : 'Unavailable',
                              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),
                    ],
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
