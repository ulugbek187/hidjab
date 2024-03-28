import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../utils/colors/app_colors.dart';
import '../../../utils/styles/app_text_style.dart';

class CategoryButton extends StatelessWidget {
  const CategoryButton({
    super.key,
    required this.title,
    required this.onTap,
    required this.isActive,
  });

  final String title;
  final VoidCallback onTap;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 8.w,
      ),
      child: TextButton(
        onPressed: onTap,
        style: TextButton.styleFrom(
          padding: EdgeInsets.symmetric(
            horizontal: 20.w,
          ),
          backgroundColor: isActive ? AppColors.c06070D : Colors.grey,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              15.r,
            ),
          ),
        ),
        child: Text(
          title,
          style: AppTextStyle.interSemiBold.copyWith(
            color: isActive ? AppColors.white : Colors.black,
          ),
        ),
      ),
    );
  }
}
