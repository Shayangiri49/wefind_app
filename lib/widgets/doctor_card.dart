import 'package:flutter/material.dart';
import 'package:wefind_app/utils/responsive_helper.dart';
import '../utils/app_colors.dart';

class DoctorCard extends StatelessWidget {
  final Map<String, dynamic> doctor;
  final VoidCallback? onTap;
  final VoidCallback? onBook;

  const DoctorCard({
    Key? key,
    required this.doctor,
    this.onTap,
    this.onBook,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(bottom: ResponsiveHelper.responsiveValue(context, mobile: 16)),
        padding: EdgeInsets.all(ResponsiveHelper.responsiveValue(context, mobile: 16)),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(ResponsiveHelper.responsiveBorderRadius(context, mobile: 16)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            // Doctor image
            CircleAvatar(
              radius: ResponsiveHelper.responsiveValue(context, mobile: 30),
              backgroundImage: NetworkImage(doctor['image']),
            ),
            SizedBox(width: ResponsiveHelper.responsiveSpacing(context, mobile: 16)),
            // Doctor info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    doctor['name'],
                    style: TextStyle(
                      fontSize: ResponsiveHelper.responsiveFontSize(context, mobile: 18),
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: ResponsiveHelper.responsiveSpacing(context, mobile: 4)),
                  Text(
                    doctor['specialty'],
                    style: TextStyle(
                      fontSize: ResponsiveHelper.responsiveFontSize(context, mobile: 14),
                      color: Colors.grey[600],
                    ),
                  ),
                  SizedBox(height: ResponsiveHelper.responsiveSpacing(context, mobile: 4)),
                  Row(
                    children: [
                      Icon(
                        Icons.star,
                        size: ResponsiveHelper.responsiveIconSize(context, mobile: 16),
                        color: Colors.amber[600],
                      ),
                      SizedBox(width: ResponsiveHelper.responsiveSpacing(context, mobile: 4)),
                      Text(
                        '${doctor['rating']}',
                        style: TextStyle(
                          fontSize: ResponsiveHelper.responsiveFontSize(context, mobile: 14),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(width: ResponsiveHelper.responsiveSpacing(context, mobile: 8)),
                      Flexible(
                        child: Text(
                          '${doctor['experience']} exp.',
                          style: TextStyle(
                            fontSize: ResponsiveHelper.responsiveFontSize(context, mobile: 12),
                            color: Colors.grey[500],
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // Book button
            ElevatedButton(
              onPressed: onBook,
              style: ElevatedButton.styleFrom(
                backgroundColor: doctor['available']
                    ? AppColors.primaryOrange
                    : Colors.grey[300],
                foregroundColor: doctor['available']
                    ? Colors.white
                    : Colors.grey[600],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(ResponsiveHelper.responsiveBorderRadius(context, mobile: 20)),
                ),
                padding: EdgeInsets.symmetric(
                  horizontal: ResponsiveHelper.responsiveValue(context, mobile: 20),
                  vertical: ResponsiveHelper.responsiveValue(context, mobile: 12),
                ),
              ),
              child: Text(
                doctor['available'] ? 'Book' : 'Unavailable',
                style: TextStyle(fontSize: ResponsiveHelper.responsiveFontSize(context, mobile: 14)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

