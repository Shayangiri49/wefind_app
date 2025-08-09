import 'package:flutter/material.dart';
import '../utils/app_colors.dart';
import '../utils/responsive_helper.dart';
import '../widgets/profile_edit_popup.dart'; // Import the new widget

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  // State variables for profile data
  String _name = 'Sarah Johnson';
  String _bio = 'Dog lover and proud owner of 2 Golden Retrievers.\nLove meeting new furry friends!';
  String _email = 'sarah.johnson@email.com';
  String _phone = '(555) 123-4567';
  String _location = 'Richmond Rd, KA';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: ResponsiveHelper.responsivePadding(
                    context,
                    mobile: const EdgeInsets.all(16.0),
                    tablet: const EdgeInsets.all(24.0),
                    desktop: const EdgeInsets.all(32.0),
                  ),
                  child: Column(
                    children: [
                      SizedBox(height: ResponsiveHelper.responsiveSpacing(context, mobile: 20)),
                      // Top AppBar Section
                      _buildAppBar(context),
                      SizedBox(height: ResponsiveHelper.responsiveSpacing(context, mobile: 20)),
                      // Profile Section
                      _buildProfileSection(context),
                      SizedBox(height: ResponsiveHelper.responsiveSpacing(context, mobile: 24)),
                      // Stats Row
                      _buildStatsRow(context),
                      SizedBox(height: ResponsiveHelper.responsiveSpacing(context, mobile: 24)),
                      // Contact Information Card
                      _buildContactCard(context),
                      SizedBox(height: ResponsiveHelper.responsiveSpacing(context, mobile: 16)),
                      // Rating & Reviews Card
                      _buildRatingCard(context),
                      SizedBox(height: ResponsiveHelper.responsiveSpacing(context, mobile: 24)),
                      // Buttons Section
                      _buildButtonsSection(context),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const SizedBox(width: 48), // Placeholder for alignment
        Text(
          'Profile',
          style: TextStyle(
            fontSize: ResponsiveHelper.responsiveFontSize(context, mobile: 20),
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        IconButton(
          onPressed: () async {
            final updatedData = await showDialog(
              context: context,
              builder: (BuildContext context) {
                return ProfileEditPopup(
                  currentName: _name,
                  currentBio: _bio,
                  currentEmail: _email,
                  currentPhone: _phone,
                  currentLocation: _location,
                );
              },
            );

            if (updatedData != null) {
              setState(() {
                _name = updatedData['name'];
                _bio = updatedData['bio'];
                _email = updatedData['email'];
                _phone = updatedData['phone'];
                _location = updatedData['location'];
              });
            }
          },
          icon: Icon(
            Icons.edit, 
            color: Colors.black,
            size: ResponsiveHelper.responsiveIconSize(context, mobile: 24),
          ),
        ),
      ],
    );
  }

  Widget _buildProfileSection(BuildContext context) {
    return Column(
      children: [
        // Profile Picture
        CircleAvatar(
          radius: ResponsiveHelper.responsiveValue(context, mobile: 50, tablet: 60, desktop: 70),
          backgroundColor: Colors.grey[300],
          child: Icon(
            Icons.person,
            size: ResponsiveHelper.responsiveIconSize(context, mobile: 60, tablet: 72, desktop: 84),
            color: Colors.grey,
          ),
        ),
        SizedBox(height: ResponsiveHelper.responsiveSpacing(context, mobile: 16)),
        
        // Name
        Text(
          _name,
          style: TextStyle(
            fontSize: ResponsiveHelper.responsiveFontSize(context, mobile: 20, tablet: 24, desktop: 28),
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        SizedBox(height: ResponsiveHelper.responsiveSpacing(context, mobile: 8)),
        
        // Bio
        Padding(
          padding: ResponsiveHelper.responsivePadding(
            context,
            mobile: const EdgeInsets.symmetric(horizontal: 16),
            tablet: const EdgeInsets.symmetric(horizontal: 32),
            desktop: const EdgeInsets.symmetric(horizontal: 64),
          ),
          child: Text(
            _bio,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: ResponsiveHelper.responsiveFontSize(context, mobile: 14, tablet: 16, desktop: 18),
              color: Colors.grey,
              height: 1.4,
            ),
          ),
        ),
        SizedBox(height: ResponsiveHelper.responsiveSpacing(context, mobile: 8)),
        
        // Membership
        Text(
          'Member since March 2023',
          style: TextStyle(
            fontSize: ResponsiveHelper.responsiveFontSize(context, mobile: 12, tablet: 14, desktop: 16),
            color: Colors.grey,
          ),
        ),
      ],
    );
  }

  Widget _buildStatsRow(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _buildStatCard(
            context,
            icon: Icons.favorite,
            number: '3',
            label: 'Pets Adopted',
          ),
        ),
        SizedBox(width: ResponsiveHelper.responsiveSpacing(context, mobile: 12)),
        Expanded(
          child: _buildStatCard(
            context,
            icon: Icons.shopping_bag,
            number: '12',
            label: 'Products Bought',
          ),
        ),
        SizedBox(width: ResponsiveHelper.responsiveSpacing(context, mobile: 12)),
        Expanded(
          child: _buildStatCard(
            context,
            icon: Icons.calendar_today,
            number: '8',
            label: 'Grooming Sessions',
          ),
        ),
      ],
    );
  }

  Widget _buildStatCard(
    BuildContext context, {
    required IconData icon,
    required String number,
    required String label,
  }) {
    return Container(
      height: ResponsiveHelper.responsiveValue(context, mobile: 130, tablet: 150, desktop: 170),
      padding: ResponsiveHelper.responsivePadding(
        context,
        mobile: const EdgeInsets.all(12),
        tablet: const EdgeInsets.all(16),
        desktop: const EdgeInsets.all(20),
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(
          ResponsiveHelper.responsiveBorderRadius(context, mobile: 12, tablet: 16, desktop: 20),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: AppColors.primaryOrange,
            size: ResponsiveHelper.responsiveIconSize(context, mobile: 22, tablet: 26, desktop: 30),
          ),
          SizedBox(height: ResponsiveHelper.responsiveSpacing(context, mobile: 6)),
          Text(
            number,
            style: TextStyle(
              fontSize: ResponsiveHelper.responsiveFontSize(context, mobile: 18, tablet: 22, desktop: 26),
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          SizedBox(height: ResponsiveHelper.responsiveSpacing(context, mobile: 2)),
          Flexible(
            child: Text(
              label,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: ResponsiveHelper.responsiveFontSize(context, mobile: 11, tablet: 13, desktop: 15),
                color: Colors.grey,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContactCard(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: ResponsiveHelper.responsivePadding(
        context,
        mobile: const EdgeInsets.all(20),
        tablet: const EdgeInsets.all(24),
        desktop: const EdgeInsets.all(28),
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(
          ResponsiveHelper.responsiveBorderRadius(context, mobile: 16, tablet: 20, desktop: 24),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildContactRow(context, Icons.email, _email),
          SizedBox(height: ResponsiveHelper.responsiveSpacing(context, mobile: 16)),
          _buildContactRow(context, Icons.phone, _phone),
          SizedBox(height: ResponsiveHelper.responsiveSpacing(context, mobile: 16)),
          _buildContactRow(context, Icons.location_on, _location),
        ],
      ),
    );
  }

  Widget _buildContactRow(BuildContext context, IconData icon, String text) {
    return Row(
      children: [
        Icon(
          icon,
          color: AppColors.primaryOrange,
          size: ResponsiveHelper.responsiveIconSize(context, mobile: 20, tablet: 24, desktop: 28),
        ),
        SizedBox(width: ResponsiveHelper.responsiveSpacing(context, mobile: 12)),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              fontSize: ResponsiveHelper.responsiveFontSize(context, mobile: 14, tablet: 16, desktop: 18),
              color: Colors.black,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildRatingCard(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: ResponsiveHelper.responsivePadding(
        context,
        mobile: const EdgeInsets.all(20),
        tablet: const EdgeInsets.all(24),
        desktop: const EdgeInsets.all(28),
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(
          ResponsiveHelper.responsiveBorderRadius(context, mobile: 16, tablet: 20, desktop: 24),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Rating & Reviews',
            style: TextStyle(
              fontSize: ResponsiveHelper.responsiveFontSize(context, mobile: 16, tablet: 18, desktop: 20),
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          SizedBox(height: ResponsiveHelper.responsiveSpacing(context, mobile: 12)),
          
          // Star Row
          Row(
            children: [
              Row(
                children: List.generate(5, (index) => Icon(
                  Icons.star,
                  color: AppColors.primaryOrange,
                  size: ResponsiveHelper.responsiveIconSize(context, mobile: 20, tablet: 24, desktop: 28),
                )),
              ),
              SizedBox(width: ResponsiveHelper.responsiveSpacing(context, mobile: 8)),
              Text(
                '4.9',
                style: TextStyle(
                  fontSize: ResponsiveHelper.responsiveFontSize(context, mobile: 16, tablet: 18, desktop: 20),
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(width: ResponsiveHelper.responsiveSpacing(context, mobile: 4)),
              Text(
                '(47 reviews)',
                style: TextStyle(
                  fontSize: ResponsiveHelper.responsiveFontSize(context, mobile: 14, tablet: 16, desktop: 18),
                  color: Colors.grey,
                ),
              ),
            ],
          ),
          SizedBox(height: ResponsiveHelper.responsiveSpacing(context, mobile: 12)),
          
          // Review Text
          Container(
            padding: ResponsiveHelper.responsivePadding(
              context,
              mobile: const EdgeInsets.all(12),
              tablet: const EdgeInsets.all(16),
              desktop: const EdgeInsets.all(20),
            ),
            decoration: BoxDecoration(
              color: Colors.grey[50],
              borderRadius: BorderRadius.circular(
                ResponsiveHelper.responsiveBorderRadius(context, mobile: 8, tablet: 12, desktop: 16),
              ),
            ),
            child: Text(
              '"Great pet owner! Very responsible and caring. Highly recommended for pet adoptions and services."',
              style: TextStyle(
                fontSize: ResponsiveHelper.responsiveFontSize(context, mobile: 13, tablet: 15, desktop: 17),
                color: Colors.grey,
                fontStyle: FontStyle.italic,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildButtonsSection(BuildContext context) {
    return Column(
      children: [
        // Settings Button
        Container(
          width: double.infinity,
          height: ResponsiveHelper.responsiveValue(context, mobile: 50, tablet: 56, desktop: 64),
          decoration: BoxDecoration(
            gradient: AppColors.orangeGradient,
            borderRadius: BorderRadius.circular(
              ResponsiveHelper.responsiveBorderRadius(context, mobile: 25, tablet: 28, desktop: 32),
            ),
          ),
          child: Center(
            child: Text(
              'Settings',
              style: TextStyle(
                color: Colors.white,
                fontSize: ResponsiveHelper.responsiveFontSize(context, mobile: 16, tablet: 18, desktop: 20),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        SizedBox(height: ResponsiveHelper.responsiveSpacing(context, mobile: 12)),
        
        // Logout Button
        Container(
          width: double.infinity,
          height: ResponsiveHelper.responsiveValue(context, mobile: 50, tablet: 56, desktop: 64),
          decoration: BoxDecoration(
            color: Colors.red[400],
            borderRadius: BorderRadius.circular(
              ResponsiveHelper.responsiveBorderRadius(context, mobile: 25, tablet: 28, desktop: 32),
            ),
          ),
          child: Center(
            child: Text(
              'Logout',
              style: TextStyle(
                color: Colors.white,
                fontSize: ResponsiveHelper.responsiveFontSize(context, mobile: 16, tablet: 18, desktop: 20),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
