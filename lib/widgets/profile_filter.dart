import 'package:flutter/material.dart';
import '../utils/responsive_helper.dart';
import '../utils/app_colors.dart';

class ProfileFilter extends StatefulWidget {
  final void Function(Map<String, dynamic> filters)? onFilterChanged;
  const ProfileFilter({Key? key, this.onFilterChanged}) : super(key: key);

  @override
  State<ProfileFilter> createState() => _ProfileFilterState();
}

class _ProfileFilterState extends State<ProfileFilter> {
  int selectedCategory = 0;
  Map<String, dynamic> selectedFilters = {};

  void _openFilterDialog() async {
    final result = await showDialog<Map<String, dynamic>>(
      context: context,
      builder: (context) {
        String? selectedBreed;
        String? selectedTag;
        int? selectedAge;
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
                  'Filter Dogs',
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
                    DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                        labelText: 'Breed',
                        filled: true,
                        fillColor: AppColors.cardBackground,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(ResponsiveHelper.responsiveBorderRadius(context, mobile: 12)),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      ),
                      items: const [
                        DropdownMenuItem(value: null, child: Text('Any')),
                        DropdownMenuItem(value: 'Golden Retriever', child: Text('Golden Retriever')),
                        DropdownMenuItem(value: 'Labrador', child: Text('Labrador')),
                        DropdownMenuItem(value: 'Beagle', child: Text('Beagle')),
                        DropdownMenuItem(value: 'Poodle', child: Text('Poodle')),
                      ],
                      onChanged: (v) => selectedBreed = v,
                    ),
                    SizedBox(height: ResponsiveHelper.responsiveSpacing(context, mobile: 16)),
                    DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                        labelText: 'Tag',
                        filled: true,
                        fillColor: AppColors.cardBackground,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(ResponsiveHelper.responsiveBorderRadius(context, mobile: 12)),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      ),
                      items: const [
                        DropdownMenuItem(value: null, child: Text('Any')),
                        DropdownMenuItem(value: 'Playful', child: Text('Playful')),
                        DropdownMenuItem(value: 'Friendly', child: Text('Friendly')),
                        DropdownMenuItem(value: 'Loyal', child: Text('Loyal')),
                        DropdownMenuItem(value: 'Smart', child: Text('Smart')),
                        DropdownMenuItem(value: 'Active', child: Text('Active')),
                        DropdownMenuItem(value: 'Intelligent', child: Text('Intelligent')),
                        DropdownMenuItem(value: 'Gentle', child: Text('Gentle')),
                        DropdownMenuItem(value: 'Loving', child: Text('Loving')),
                      ],
                      onChanged: (v) => selectedTag = v,
                    ),
                    SizedBox(height: ResponsiveHelper.responsiveSpacing(context, mobile: 16)),
                    DropdownButtonFormField<int>(
                      decoration: InputDecoration(
                        labelText: 'Age',
                        filled: true,
                        fillColor: AppColors.cardBackground,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(ResponsiveHelper.responsiveBorderRadius(context, mobile: 12)),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      ),
                      items: const [
                        DropdownMenuItem(value: null, child: Text('Any')),
                        DropdownMenuItem(value: 1, child: Text('1')),
                        DropdownMenuItem(value: 2, child: Text('2')),
                        DropdownMenuItem(value: 3, child: Text('3')),
                        DropdownMenuItem(value: 4, child: Text('4')),
                        DropdownMenuItem(value: 5, child: Text('5')),
                      ],
                      onChanged: (v) => selectedAge = v,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      style: TextButton.styleFrom(
                        foregroundColor: AppColors.primaryOrange,
                        textStyle: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      child: const Text('Cancel'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context, {
                          'breed': selectedBreed,
                          'tag': selectedTag,
                          'age': selectedAge,
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryOrange,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(ResponsiveHelper.responsiveBorderRadius(context, mobile: 12)),
                        ),
                        textStyle: const TextStyle(fontWeight: FontWeight.bold),
                        padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
                      ),
                      child: const Text('Apply'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
    if (result != null) {
      setState(() {
        selectedFilters = result;
      });
      widget.onFilterChanged?.call(selectedFilters);
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<String> avatars = [
      'assets/images/dog1.png',
      'assets/images/dog2.png',
      'assets/images/dog3.png',
      'assets/images/dog4.png',
    ];

    return Row(
      children: [
        // Filter icon
        GestureDetector(
          onTap: _openFilterDialog,
          child: Container(
            decoration: BoxDecoration(
              color: const Color(0xFFFFA726),
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFFFFA726).withOpacity(0.3),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            padding: const EdgeInsets.all(12),
            child: Icon(Icons.tune, color: Colors.white, size: ResponsiveHelper.responsiveIconSize(context, mobile: 20)),
          ),
        ),
        SizedBox(width: ResponsiveHelper.responsiveSpacing(context, mobile: 16)),
        // Pet category avatars
        Expanded(
          child: SizedBox(
            height: ResponsiveHelper.responsiveValue(context, mobile: 52),
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: avatars.length,
              separatorBuilder: (_, __) => SizedBox(width: ResponsiveHelper.responsiveSpacing(context, mobile: 12)),
              itemBuilder: (context, i) {
                final isSelected = i == selectedCategory;
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedCategory = i;
                    });
                    // Optionally, call filter for category
                  },
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: isSelected ? const Color(0xFFFFA726) : const Color(0xFFFFCC80),
                        width: isSelected ? 3 : 2,
                      ),
                      boxShadow: isSelected ? [
                        BoxShadow(
                          color: const Color(0xFFFFA726).withOpacity(0.3),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ] : null,
                    ),
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: ResponsiveHelper.responsiveValue(context, mobile: 22),
                      backgroundImage: AssetImage(avatars[i]),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
