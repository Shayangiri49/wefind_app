import 'package:flutter/material.dart';
import '../utils/app_colors.dart';

class DoctorDetailScreen extends StatelessWidget {
  final Map<String, dynamic> doctor;
  const DoctorDetailScreen({Key? key, required this.doctor}) : super(key: key);

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
                      // Top bar with back and favorite
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
                                doctor['available'] ? Icons.verified : Icons.block,
                                color: doctor['available'] ? Colors.green : Colors.red,
                                size: 28,
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Doctor image with creative background
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
                            CircleAvatar(
                              radius: 60,
                              backgroundImage: NetworkImage(doctor['image']),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      // Doctor name and specialty
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              doctor['name'],
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: AppColors.darkText,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 6),
                            Text(
                              doctor['specialty'],
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
                      // Rating and experience
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.star, color: AppColors.starYellow, size: 22),
                            const SizedBox(width: 4),
                            Text(
                              '${doctor['rating']}',
                              style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                            ),
                            const SizedBox(width: 12),
                            const Icon(Icons.work, color: AppColors.primaryOrange, size: 20),
                            const SizedBox(width: 4),
                            Text(
                              doctor['experience'],
                              style: const TextStyle(fontSize: 15, color: AppColors.lightText),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 18),
                      // Bio/Description
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'About',
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: AppColors.darkText),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Dr. ${doctor['name']} is a specialist in ${doctor['specialty'].toString().toLowerCase()} with ${doctor['experience']} of experience. Highly rated by pet owners for compassion and expertise.',
                              style: const TextStyle(color: AppColors.lightText, fontSize: 15, height: 1.5),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 28),
                      // Contact/Book button
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: SizedBox(
                          width: double.infinity,
                          height: 52,
                          child: ElevatedButton.icon(
                            onPressed: doctor['available'] ? () {} : null,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primaryOrange,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                              elevation: 2,
                            ),
                            icon: const Icon(Icons.phone, color: Colors.white),
                            label: Text(
                              doctor['available'] ? 'Contact Doctor' : 'Unavailable',
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
