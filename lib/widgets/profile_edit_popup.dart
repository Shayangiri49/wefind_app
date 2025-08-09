import 'package:flutter/material.dart';
import '../utils/app_colors.dart';
import '../utils/responsive_helper.dart';

class ProfileEditPopup extends StatefulWidget {
  final String currentName;
  final String currentBio;
  final String currentEmail;
  final String currentPhone;
  final String currentLocation;

  const ProfileEditPopup({
    Key? key,
    required this.currentName,
    required this.currentBio,
    required this.currentEmail,
    required this.currentPhone,
    required this.currentLocation,
  }) : super(key: key);

  @override
  State<ProfileEditPopup> createState() => _ProfileEditPopupState();
}

class _ProfileEditPopupState extends State<ProfileEditPopup> {
  late TextEditingController _nameController;
  late TextEditingController _bioController;
  late TextEditingController _emailController;
  late TextEditingController _phoneController;
  late TextEditingController _locationController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.currentName);
    _bioController = TextEditingController(text: widget.currentBio);
    _emailController = TextEditingController(text: widget.currentEmail);
    _phoneController = TextEditingController(text: widget.currentPhone);
    _locationController = TextEditingController(text: widget.currentLocation);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _bioController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _locationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(ResponsiveHelper.responsiveBorderRadius(context, mobile: 20, tablet: 25, desktop: 30)),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: SingleChildScrollView(
        child: Container(
          padding: ResponsiveHelper.responsivePadding(context, mobile: const EdgeInsets.all(24), tablet: const EdgeInsets.all(32), desktop: const EdgeInsets.all(40)),
          decoration: BoxDecoration(
            color: AppColors.cardBackground,
            borderRadius: BorderRadius.circular(ResponsiveHelper.responsiveBorderRadius(context, mobile: 20, tablet: 25, desktop: 30)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Edit Profile',
                style: TextStyle(
                  fontSize: ResponsiveHelper.responsiveFontSize(context, mobile: 22, tablet: 26, desktop: 30),
                  fontWeight: FontWeight.bold,
                  color: AppColors.darkText,
                ),
              ),
              SizedBox(height: ResponsiveHelper.responsiveSpacing(context, mobile: 24)),
              _buildTextField(context, 'Name', _nameController, Icons.person),
              SizedBox(height: ResponsiveHelper.responsiveSpacing(context, mobile: 16)),
              _buildTextField(context, 'Bio', _bioController, Icons.description, maxLines: 3),
              SizedBox(height: ResponsiveHelper.responsiveSpacing(context, mobile: 16)),
              _buildTextField(context, 'Email', _emailController, Icons.email, keyboardType: TextInputType.emailAddress),
              SizedBox(height: ResponsiveHelper.responsiveSpacing(context, mobile: 16)),
              _buildTextField(context, 'Phone', _phoneController, Icons.phone, keyboardType: TextInputType.phone),
              SizedBox(height: ResponsiveHelper.responsiveSpacing(context, mobile: 16)),
              _buildTextField(context, 'Location', _locationController, Icons.location_on),
              SizedBox(height: ResponsiveHelper.responsiveSpacing(context, mobile: 32)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    child: _buildActionButton(
                      context,
                      'Cancel',
                      AppColors.subtleGray,
                      () => Navigator.of(context).pop(),
                    ),
                  ),
                  SizedBox(width: ResponsiveHelper.responsiveSpacing(context, mobile: 16)),
                  Expanded(
                    child: _buildActionButton(
                      context,
                      'Save',
                      AppColors.primaryOrange,
                      () {
                        // Implement save logic here
                        // For now, just pop with updated data
                        Navigator.of(context).pop({
                          'name': _nameController.text,
                          'bio': _bioController.text,
                          'email': _emailController.text,
                          'phone': _phoneController.text,
                          'location': _locationController.text,
                        });
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(BuildContext context, String label, TextEditingController controller, IconData icon, {int maxLines = 1, TextInputType keyboardType = TextInputType.text}) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      keyboardType: keyboardType,
      style: TextStyle(
        fontSize: ResponsiveHelper.responsiveFontSize(context, mobile: 16, tablet: 18, desktop: 20),
        color: AppColors.darkText,
      ),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: AppColors.lightText),
        prefixIcon: Icon(icon, color: AppColors.primaryOrange),
        filled: true,
        fillColor: AppColors.inputFill,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(ResponsiveHelper.responsiveBorderRadius(context, mobile: 12, tablet: 15, desktop: 18)),
          borderSide: const BorderSide(color: AppColors.inputBorder),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(ResponsiveHelper.responsiveBorderRadius(context, mobile: 12, tablet: 15, desktop: 18)),
          borderSide: const BorderSide(color: AppColors.inputBorder),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(ResponsiveHelper.responsiveBorderRadius(context, mobile: 12, tablet: 15, desktop: 18)),
          borderSide: const BorderSide(color: AppColors.primaryOrange, width: 2),
        ),
        contentPadding: ResponsiveHelper.responsivePadding(context, mobile: const EdgeInsets.symmetric(vertical: 14, horizontal: 16)),
      ),
    );
  }

  Widget _buildActionButton(BuildContext context, String text, Color color, VoidCallback onPressed) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(ResponsiveHelper.responsiveBorderRadius(context, mobile: 15, tablet: 18, desktop: 20)),
        ),
        padding: ResponsiveHelper.responsivePadding(context, mobile: const EdgeInsets.symmetric(vertical: 14, horizontal: 20)),
        elevation: 5,
        shadowColor: color.withOpacity(0.3),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: Colors.white,
          fontSize: ResponsiveHelper.responsiveFontSize(context, mobile: 16, tablet: 18, desktop: 20),
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
