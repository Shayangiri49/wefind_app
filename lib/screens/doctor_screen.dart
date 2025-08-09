import 'package:flutter/material.dart';
import 'package:wefind_app/utils/responsive_helper.dart';
import '../utils/app_colors.dart';
import '../widgets/doctor_card.dart';
import 'doctor_detail_screen.dart';

class DoctorScreen extends StatefulWidget {
  const DoctorScreen({Key? key}) : super(key: key);

  @override
  State<DoctorScreen> createState() => _DoctorScreenState();
}

class _DoctorScreenState extends State<DoctorScreen> {
  final int _currentIndex = 1;
  final List<Map<String, dynamic>> _doctors = [
    {
      'name': 'Dr. Sarah Johnson',
      'specialty': 'General Veterinary',
      'experience': '8 years',
      'rating': 4.8,
      'image': 'https://images.unsplash.com/photo-1559839734-2b71ea197ec2?w=150&h=150&fit=crop&crop=face',
      'available': true,
    },
    {
      'name': 'Dr. Michael Chen',
      'specialty': 'Surgery Specialist',
      'experience': '12 years',
      'rating': 4.9,
      'image': 'https://images.unsplash.com/photo-1612349317150-e413f6a5b16d?w=150&h=150&fit=crop&crop=face',
      'available': true,
    },
    {
      'name': 'Dr. Emily Rodriguez',
      'specialty': 'Dermatology',
      'experience': '6 years',
      'rating': 4.7,
      'image': 'https://images.unsplash.com/photo-1594824475544-9d5c2c8c0f8c?w=150&h=150&fit=crop&crop=face',
      'available': false,
    },
    {
      'name': 'Dr. James Wilson',
      'specialty': 'Emergency Care',
      'experience': '15 years',
      'rating': 4.9,
      'image': 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=150&h=150&fit=crop&crop=face',
      'available': true,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFE0B2),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFFFEEDC), // soft peach top
              Color(0xFFFFF8EC), // creamy middle
              Color(0xFFFFFFFF), // white at bottom
            ],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: ResponsiveHelper.responsiveValue(context, mobile: 20.0),
              vertical: ResponsiveHelper.responsiveValue(context, mobile: 12.0),
            ),
            child: Column(
              children: [
                // Search bar at the top
                Padding(
                  padding: EdgeInsets.only(bottom: ResponsiveHelper.responsiveValue(context, mobile: 20)),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Search doctors...',
                      prefixIcon: const Icon(Icons.search, color: AppColors.primaryOrange),
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(ResponsiveHelper.responsiveBorderRadius(context, mobile: 16)),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    onChanged: (value) {
                      // TODO: Implement search logic
                    },
                  ),
                ),
                // Title
                Row(
                  children: [
                    Icon(
                      Icons.medical_services,
                      color: AppColors.primaryOrange,
                      size: ResponsiveHelper.responsiveIconSize(context, mobile: 28),
                    ),
                    SizedBox(width: ResponsiveHelper.responsiveSpacing(context, mobile: 12)),
                    Text(
                      'Veterinarians',
                      style: TextStyle(
                        fontSize: ResponsiveHelper.responsiveFontSize(context, mobile: 24),
                        fontWeight: FontWeight.w600,
                        color: AppColors.primaryOrange,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: ResponsiveHelper.responsiveSpacing(context, mobile: 20)),
                // Doctors list
                Expanded(
                  child: ListView.builder(
                    itemCount: _doctors.length,
                    itemBuilder: (context, index) {
                      final doctor = _doctors[index];
                      return DoctorCard(
                        doctor: doctor,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DoctorDetailScreen(doctor: doctor),
                            ),
                          );
                        },
                        onBook: doctor['available']
                            ? () => _showBookingDialog(context, doctor)
                            : null,
                      );
                    },
                  ),
                ),
                SizedBox(height: ResponsiveHelper.responsiveSpacing(context, mobile: 16)),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showBookingDialog(BuildContext context, Map<String, dynamic> doctor) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(ResponsiveHelper.responsiveBorderRadius(context, mobile: 20)),
          ),
          title: const Text('Book Appointment'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Book appointment with ${doctor['name']}?'),
              SizedBox(height: ResponsiveHelper.responsiveSpacing(context, mobile: 20)),
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
            borderRadius: BorderRadius.circular(ResponsiveHelper.responsiveBorderRadius(context, mobile: 20)),
          ),
          title: const Text('Appointment Booked!'),
          content: const Text('Your appointment has been successfully booked. You will receive a confirmation shortly.'),
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
