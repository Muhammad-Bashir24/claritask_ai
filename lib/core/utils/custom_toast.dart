import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

enum ToastType { success, error, info }

class CustomToast {
  static void show({
    required BuildContext context,
    required String message,
    ToastType type = ToastType.info,
  }) {
    Color backgroundColor;
    IconData icon;

    switch (type) {
      case ToastType.success:
        backgroundColor = const Color(0xFF10B981); // Emerald 500
        icon = Icons.check_circle_outline;
        break;
      case ToastType.error:
        backgroundColor = const Color(0xFFEF4444); // Red 500
        icon = Icons.error_outline;
        break;
      case ToastType.info:
      default:
        backgroundColor = const Color(0xFF3B82F6); // Blue 500
        icon = Icons.info_outline;
        break;
    }

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          elevation: 0,
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.transparent,
          content: Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.circular(12.r),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 10,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: Row(
              children: [
                Icon(icon, color: Colors.white, size: 24.sp),
                SizedBox(width: 12.w),
                Expanded(
                  child: Text(
                    message,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
          margin: EdgeInsets.only(bottom: 24.h, left: 24.w, right: 24.w),
        ),
      );
  }
}
