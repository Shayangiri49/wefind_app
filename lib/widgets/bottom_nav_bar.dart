import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../utils/responsive_helper.dart';
import '../services/favorites_service.dart';
// Import CartService
import '../utils/app_colors.dart';

class BottomNavBar extends StatefulWidget {
  final int currentIndex;
  final ValueChanged<int> onTabChanged;
  final VoidCallback? onHomeTap;
  final VoidCallback? onDoctorTap;
  final VoidCallback? onProfileTap;
  final VoidCallback? onAddTap;

  const BottomNavBar({
    Key? key,
    required this.currentIndex,
    required this.onTabChanged,
    this.onHomeTap,
    this.onDoctorTap,
    this.onProfileTap,
    this.onAddTap,
  }) : super(key: key);

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      clipBehavior: Clip.none,
      children: [
        // Nav bar background
        ClipRRect(
          borderRadius: BorderRadius.circular(ResponsiveHelper.responsiveBorderRadius(context, mobile: 36)),
          child: Container(
            height: ResponsiveHelper.responsiveValue(context, mobile: 72),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(ResponsiveHelper.responsiveBorderRadius(context, mobile: 36)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.08),
                  blurRadius: 16,
                  offset: const Offset(0, -4),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Home
                Expanded(
                  child: _NavIcon(
                    icon: Icons.home,
                    isActive: widget.currentIndex == 0,
                    onTap: () {
                      widget.onTabChanged(0);
                      if (widget.onHomeTap != null) widget.onHomeTap!();
                    },
                  ),
                ),
                // Doctor
                Expanded(
                  child: _NavIcon(
                    icon: Icons.medical_services,
                    isActive: widget.currentIndex == 1,
                    onTap: () {
                      widget.onTabChanged(1);
                      if (widget.onDoctorTap != null) widget.onDoctorTap!();
                    },
                  ),
                ),
                // Space for FAB
                SizedBox(width: ResponsiveHelper.responsiveValue(context, mobile: 80)),
                // Favorites
                Expanded(
                  child: Consumer<FavoritesService>(
                    builder: (context, favoritesService, child) {
                      return Stack(
                        alignment: Alignment.center,
                        children: [
                          _NavIcon(
                            icon: Icons.favorite_border,
                            isActive: widget.currentIndex == 2,
                            onTap: () {
                              widget.onTabChanged(2);
                            },
                          ),
                          if (favoritesService.favoriteDogs.isNotEmpty)
                            Positioned(
                              top: 10,
                              right: 20,
                              child: Container(
                                padding: const EdgeInsets.all(2),
                                decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(
                                      ResponsiveHelper.responsiveBorderRadius(
                                          context,
                                          mobile: 10)),
                                ),
                                constraints: const BoxConstraints(
                                  minWidth: 16,
                                  minHeight: 16,
                                ),
                                child: Text(
                                  '${favoritesService.favoriteDogs.length}',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize:
                                        ResponsiveHelper.responsiveFontSize(
                                            context,
                                            mobile: 10),
                                    fontWeight: FontWeight.bold,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                        ],
                      );
                    },
                  ),
                ),
                
                // Profile
                Expanded(
                  child: _NavIcon(
                    icon: Icons.person_outline,
                    isActive: widget.currentIndex == 3, // Changed index to 3
                    onTap: () {
                      widget.onTabChanged(3); // Changed index to 3
                      if (widget.onProfileTap != null) widget.onProfileTap!();
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
        // Floating Action Button
        Positioned(
          top: -16,
          child: Container(
            width: ResponsiveHelper.responsiveValue(context, mobile: 64),
            height: ResponsiveHelper.responsiveValue(context, mobile: 64),
            decoration: BoxDecoration(
              color: AppColors.primaryOrange,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 20,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: GestureDetector(
              onTap: _showFabMenu,
              child: Center(
                child: Icon(
                  Icons.add,
                  color: Colors.white,
                  size: ResponsiveHelper.responsiveIconSize(context, mobile: 32),
                  weight: 600,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _showFabMenu() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(ResponsiveHelper.responsiveBorderRadius(context, mobile: 24))),
          backgroundColor: AppColors.background,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Colored header
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 24),
                decoration: BoxDecoration(
                  color: AppColors.primaryOrange,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(ResponsiveHelper.responsiveBorderRadius(context, mobile: 24)),
                    topRight: Radius.circular(ResponsiveHelper.responsiveBorderRadius(context, mobile: 24)),
                  ),
                ),
                child: Text(
                  'Quick Actions',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: ResponsiveHelper.responsiveFontSize(context, mobile: 20),
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 18),
                child: Column(
                  children: [
                    
                    _buildMenuOption(
                      icon: Icons.sell,
                      label: 'Sell Pet',
                      onTap: () {
                        Navigator.pop(context); // Close the quick actions dialog
                        Navigator.pushNamed(context, '/sell_pet'); // Navigate to SellPetScreen
                      },
                    ),
                    SizedBox(height: ResponsiveHelper.responsiveSpacing(context, mobile: 16)),
                    _buildMenuOption(
                      icon: Icons.content_cut,
                      label: 'Grooming',
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.pushNamed(context, '/grooming');
                      },
                    ),
                    SizedBox(height: ResponsiveHelper.responsiveSpacing(context, mobile: 16)),
                    _buildMenuOption(
                      icon: Icons.restaurant,
                      label: 'Food',
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.pushNamed(context, '/food');
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildMenuOption({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(ResponsiveHelper.responsiveBorderRadius(context, mobile: 12)),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: AppColors.cardBackground,
          borderRadius: BorderRadius.circular(ResponsiveHelper.responsiveBorderRadius(context, mobile: 12)),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: AppColors.primaryOrange,
              size: ResponsiveHelper.responsiveIconSize(context, mobile: 24),
            ),
            SizedBox(width: ResponsiveHelper.responsiveSpacing(context, mobile: 14)),
            Text(
              label,
              style: TextStyle(
                fontSize: ResponsiveHelper.responsiveFontSize(context, mobile: 16),
                fontWeight: FontWeight.w600,
                color: AppColors.darkText,
              ),
            ),
          ],
        ),
      ),
    );
  }

  

  void _showSellPetDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(ResponsiveHelper.responsiveBorderRadius(context, mobile: 20)),
          ),
          title: const Text('Sell Pet'),
          content: const Text('Would you like to list your pet for sale?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                _showSuccessDialog(context, 'Redirecting to sell pet form...');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryOrange,
                foregroundColor: Colors.white,
              ),
              child: const Text('List Pet'),
            ),
          ],
        );
      },
    );
  }

  void _showSuccessDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(ResponsiveHelper.responsiveBorderRadius(context, mobile: 20)),
          ),
          title: const Text('Success!'),
          content: Text(message),
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

class _NavIcon extends StatelessWidget {
  final IconData icon;
  final bool isActive;
  final VoidCallback? onTap;

  const _NavIcon({
    Key? key,
    required this.icon,
    this.isActive = false,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: ResponsiveHelper.responsiveValue(context, mobile: 72),
        decoration: isActive
            ? BoxDecoration(
                color: AppColors.primaryOrange.withOpacity(0.12),
                borderRadius: BorderRadius.circular(ResponsiveHelper.responsiveBorderRadius(context, mobile: 20)),
              )
            : null,
        child: Center(
          child: Icon(
            icon,
            color: isActive ? AppColors.primaryOrange : Colors.grey[600],
            size: ResponsiveHelper.responsiveIconSize(context, mobile: 26),
          ),
        ),
      ),
    );
  }
}
