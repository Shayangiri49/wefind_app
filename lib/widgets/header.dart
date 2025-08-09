import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../services/cart_service.dart';
import '../utils/app_colors.dart';
import '../utils/responsive_helper.dart';

class Header extends StatefulWidget {
  final bool showLocation;
  
  const Header({
    Key? key, 
    this.showLocation = true,
  }) : super(key: key);

  @override
  State<Header> createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
  bool _isLoggingOut = false;

  // Enhanced logout functionality (same as profile screen)
  void _handleLogout(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false, // Prevent dismissing by tapping outside
      builder: (BuildContext dialogContext) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              title: Row(
                children: [
                  Icon(
                    Icons.logout,
                    color: Colors.red[400],
                    size: 24,
                  ),
                  const SizedBox(width: 8),
                  const Text(
                    'Logout',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Are you sure you want to logout?',
                    style: TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'You will need to sign in again to access your account.',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                  if (_isLoggingOut) ...[
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation<Color>(
                              Colors.red[400]!,
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        const Text(
                          'Logging out...',
                          style: TextStyle(fontSize: 14),
                        ),
                      ],
                    ),
                  ],
                ],
              ),
              actions: _isLoggingOut
                  ? []
                  : [
                      TextButton(
                        onPressed: () {
                          Navigator.of(dialogContext).pop(); // Close dialog
                        },
                        child: Text(
                          'Cancel',
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 16,
                          ),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          setState(() {
                            _isLoggingOut = true;
                          });

                          // Simulate logout process (you can add actual logout logic here)
                          await _performLogout();

                          // Close dialog
                          if (Navigator.of(dialogContext).canPop()) {
                            Navigator.of(dialogContext).pop();
                          }

                          // Navigate to onboarding screen and clear navigation stack
                          Navigator.pushNamedAndRemoveUntil(
                            context,
                            '/onboarding',
                            (route) => false,
                          );

                          // Show success message
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: const Row(
                                children: [
                                  Icon(
                                    Icons.check_circle,
                                    color: Colors.white,
                                    size: 20,
                                  ),
                                  SizedBox(width: 8),
                                  Text('Successfully logged out'),
                                ],
                              ),
                              backgroundColor: Colors.green,
                              duration: const Duration(seconds: 2),
                              behavior: SnackBarBehavior.floating,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red[400],
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 10,
                          ),
                        ),
                        child: const Text(
                          'Logout',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
            );
          },
        );
      },
    );
  }

  // Simulate logout process - you can replace this with actual logout logic
  Future<void> _performLogout() async {
    // Add a small delay to show the loading state
    await Future.delayed(const Duration(milliseconds: 1500));
    
    // Here you can add actual logout logic such as:
    // - Clear user session/tokens from SharedPreferences
    // - Clear cached user data
    // - Reset app state
    // - Call logout API endpoint
    
    // Example of clearing user data (uncomment if you have SharedPreferences):
    // final prefs = await SharedPreferences.getInstance();
    // await prefs.clear();
    
    // Reset the logging out state
    setState(() {
      _isLoggingOut = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Top bar with profile picture and menu
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Profile Picture (top-left)
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, '/profile');
              },
              child: Container(
                width: ResponsiveHelper.responsiveValue(context, mobile: 48),
                height: ResponsiveHelper.responsiveValue(context, mobile: 48),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: const LinearGradient(
                    colors: [Color(0xFFFFF176), Color(0xFFFFECB3)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: ResponsiveHelper.responsiveValue(context, mobile: 22),
                  child: Icon(
                    Icons.person,
                    color: Colors.grey[600],
                    size: ResponsiveHelper.responsiveIconSize(context, mobile: 28),
                  ),
                ),
              ),
            ),
            // Menu icons
            Builder(
              builder: (context) {
                return Row(
                  children: [
                    Consumer<CartService>(
                      builder: (context, cartService, child) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, '/cart');
                          },
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.8),
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.05),
                                  blurRadius: 4,
                                  offset: const Offset(0, 1),
                                ),
                              ],
                            ),
                            child: Stack(
                              alignment: Alignment.center,
                              clipBehavior: Clip.none,
                              children: [
                                Icon(
                                  Icons.shopping_cart_outlined,
                                  color: Colors.grey[700],
                                  size: ResponsiveHelper.responsiveIconSize(context, mobile: 24),
                                ),
                                if (cartService.totalItems > 0)
                                  Positioned(
                                    top: -4,
                                    right: -4,
                                    child: Container(
                                      padding: const EdgeInsets.all(2),
                                      decoration: const BoxDecoration(
                                        color: AppColors.primaryOrange,
                                        shape: BoxShape.circle,
                                      ),
                                      constraints: const BoxConstraints(
                                        minWidth: 16,
                                        minHeight: 16,
                                      ),
                                      child: Text(
                                        '${cartService.totalItems}',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: ResponsiveHelper.responsiveFontSize(context, mobile: 10),
                                          fontWeight: FontWeight.bold,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                    SizedBox(width: ResponsiveHelper.responsiveSpacing(context, mobile: 8)),
                    // 3-dot menu (top-right)
                    GestureDetector(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return Dialog(
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(ResponsiveHelper.responsiveBorderRadius(context, mobile: 20))),
                              backgroundColor: Colors.white,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                    width: double.infinity,
                                    padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 24),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFFFA726),
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(ResponsiveHelper.responsiveBorderRadius(context, mobile: 20)),
                                        topRight: Radius.circular(ResponsiveHelper.responsiveBorderRadius(context, mobile: 20)),
                                      ),
                                    ),
                                    child: Text(
                                      'Menu',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: ResponsiveHelper.responsiveFontSize(context, mobile: 18),
                                        fontWeight: FontWeight.bold,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  _buildMenuOption(context, Icons.settings, 'Settings', () {
                                    Navigator.pop(context);
                                    // TODO: Navigate to settings
                                  }),
                                  _buildMenuOption(context, Icons.help_outline, 'Help', () {
                                    Navigator.pop(context);
                                    // TODO: Navigate to help
                                  }),
                                  _buildMenuOption(context, Icons.logout, 'Logout', () {
                                    Navigator.pop(context);
                                    _handleLogout(context);
                                  }),
                                ],
                              ),
                            );
                          },
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.8),
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              blurRadius: 4,
                              offset: const Offset(0, 1),
                            ),
                          ],
                        ),
                        child: Icon(
                          Icons.more_vert,
                          color: Colors.grey[700],
                          size: ResponsiveHelper.responsiveIconSize(context, mobile: 24),
                        ),
                      ),
                    ),
                  ],
                );
              }
            ),
          ],
        ),
        // Location (centered below top bar) - only show if showLocation is true
        if (widget.showLocation) ...[
          SizedBox(height: ResponsiveHelper.responsiveSpacing(context, mobile: 16)),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Location',
                  style: GoogleFonts.poppins(
                    color: Colors.grey[600],
                    fontSize: ResponsiveHelper.responsiveFontSize(context, mobile: 12),
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Richmond, KA',
                  style: GoogleFonts.poppins(
                    color: Colors.black87,
                    fontSize: ResponsiveHelper.responsiveFontSize(context, mobile: 24),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildMenuOption(BuildContext context, IconData icon, String label, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(ResponsiveHelper.responsiveBorderRadius(context, mobile: 12)),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        decoration: BoxDecoration(
          color: Colors.grey[50],
          borderRadius: BorderRadius.circular(ResponsiveHelper.responsiveBorderRadius(context, mobile: 12)),
        ),
        child: Row(
          children: [
            Icon(icon, color: const Color(0xFFFFA726), size: ResponsiveHelper.responsiveIconSize(context, mobile: 22)),
            SizedBox(width: ResponsiveHelper.responsiveSpacing(context, mobile: 14)),
            Text(
              label,
              style: TextStyle(
                fontSize: ResponsiveHelper.responsiveFontSize(context, mobile: 15),
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
