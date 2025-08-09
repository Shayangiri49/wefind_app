import 'package:flutter/material.dart';
import '../utils/app_colors.dart';
import '../widgets/grooming_card.dart';
import 'grooming_detail_screen.dart';

class GroomingScreen extends StatefulWidget {
  const GroomingScreen({Key? key}) : super(key: key);

  @override
  State<GroomingScreen> createState() => _GroomingScreenState();
}

class _GroomingScreenState extends State<GroomingScreen> {
    final List<Map<String, dynamic>> _groomingServices = [
    {
      'name': 'Full Grooming',
      'description': 'Complete wash, cut, and styling',
      'duration': '2-3 hours',
      'price': 75.00,
      'rating': 4.8,
      'image': 'https://images.unsplash.com/photo-1516734212186-a967f81ad0d7?w=200&h=200&fit=crop',
      'available': true,
    },
    {
      'name': 'Bath & Brush',
      'description': 'Wash and brush only',
      'duration': '1 hour',
      'price': 35.00,
      'rating': 4.6,
      'image': 'https://images.unsplash.com/photo-1516734212186-a967f81ad0d7?w=200&h=200&fit=crop',
      'available': true,
    },
    {
      'name': 'Nail Trim',
      'description': 'Nail trimming and filing',
      'duration': '30 min',
      'price': 15.00,
      'rating': 4.5,
      'image': 'https://images.unsplash.com/photo-1516734212186-a967f81ad0d7?w=200&h=200&fit=crop',
      'available': true,
    },
    {
      'name': 'Haircut & Style',
      'description': 'Professional haircut and styling',
      'duration': '1.5 hours',
      'price': 55.00,
      'rating': 4.7,
      'image': 'https://images.unsplash.com/photo-1516734212186-a967f81ad0d7?w=200&h=200&fit=crop',
      'available': false,
    },
    {
      'name': 'Puppy Grooming',
      'description': 'Gentle grooming for puppies',
      'duration': '1 hour',
      'price': 45.00,
      'rating': 4.9,
      'image': 'https://images.unsplash.com/photo-1516734212186-a967f81ad0d7?w=200&h=200&fit=crop',
      'available': true,
    },
    {
      'name': 'Spa Treatment',
      'description': 'Luxury spa with massage',
      'duration': '2 hours',
      'price': 95.00,
      'rating': 4.9,
      'image': 'https://images.unsplash.com/photo-1516734212186-a967f81ad0d7?w=200&h=200&fit=crop',
      'available': true,
    },
  ];

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
          'Grooming',
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
                            hintText: 'Search grooming services...',
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
                // Grooming services list
                Expanded(
                  child: ListView.builder(
                    itemCount: _groomingServices.length,
                    itemBuilder: (context, index) {
                      final service = _groomingServices[index];
                      return GroomingCard(
                        service: service,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => GroomingDetailScreen(service: service),
                            ),
                          );
                        },
                        onBook: service['available']
                            ? () => _showBookingDialog(context, service)
                            : null,
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

  void _showBookingDialog(BuildContext context, Map<String, dynamic> service) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: Text('Book ${service['name']}?'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Book ${service['name']} for \$${service['price']}?'),
              const SizedBox(height: 10),
              Text(
                'Duration: ${service['duration']}',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Cancel'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      _showSuccessDialog(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryOrange,
                      foregroundColor: Colors.white,
                    ),
                    child: const Text('Confirm'),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  void _showSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: const Text('Appointment Booked!'),
          content: const Text('Your grooming appointment has been successfully booked. You will receive a confirmation shortly.'),
          actions: [
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryOrange,
                foregroundColor: Colors.white,
              ),
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
