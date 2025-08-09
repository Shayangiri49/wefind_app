import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wefind_app/utils/responsive_helper.dart';

class Header extends StatelessWidget {
  final bool showLocation;
  
  const Header({
    Key? key, 
    this.showLocation = true,
  }) : super(key: key);

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
                            // TODO: Implement logout
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
        ),
        // Location (centered below top bar) - only show if showLocation is true
        if (showLocation) ...[
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
