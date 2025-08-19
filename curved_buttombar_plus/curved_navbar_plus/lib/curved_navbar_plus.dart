library curved_nav_bar;

import 'package:flutter/material.dart';

class CurvedNavBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;
  final List<IconData> icons;
  final List<String> labels;

  const CurvedNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
    required this.icons,
    required this.labels,
  });

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    final Color bgColor = isDark
        ? Colors.black.withOpacity(0.85)
        : Colors.white;
    final Color iconColor = isDark ? Colors.white60 : Colors.black54;
    final Color selectedColor = Colors.blueAccent;

    return SafeArea(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: isDark ? Colors.white10 : Colors.black12,
              blurRadius: 8,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: List.generate(icons.length, (index) {
            final bool isSelected = currentIndex == index;
            return GestureDetector(
              onTap: () => onTap(index),
              behavior: HitTestBehavior.opaque,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    AnimatedSwitcher(
                      duration: const Duration(milliseconds: 300),
                      transitionBuilder: (child, animation) =>
                          ScaleTransition(scale: animation, child: child),
                      child: isSelected
                          ? Column(
                              key: ValueKey('selected$index'),
                              children: [
                                Text(
                                  labels[index],
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: selectedColor,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Container(
                                  width: 6,
                                  height: 6,
                                  decoration: BoxDecoration(
                                    color: selectedColor,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                              ],
                            )
                          : Icon(icons[index], color: iconColor, size: 28),
                    ),
                  ],
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}

/*
Sunnat Amirov, [8/7/2025 10:05 AM]
`
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:uzfit/core/app/extensions/context_ext.dart';
import 'package:uzfit/core/app/resources/styles/app_colors.dart';
import 'package:uzfit/generated/locale_keys.g.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const CustomBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final items = [
      {'icon': Icons.home, 'label': LocaleKeys.home.tr()},
      {'icon': Icons.fastfood, 'label': LocaleKeys.food.tr()},
      {'icon': Icons.bar_chart, 'label': LocaleKeys.stats.tr()},
      {'icon': Icons.person, 'label': LocaleKeys.profile.tr()},
    ];
    final isDark = context.isDarkMode;
    final Color bgColor = isDark
        ? AppColors.blackTextColor.withValues(alpha: 0.85)
        : AppColors.whiteColor;
    final Color iconColor = isDark ? Colors.white60 : Colors.black54;
    final Color selectedColor = AppColors.blueColor;

Sunnat Amirov, [8/7/2025 10:05 AM]
return SafeArea(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.all(Radius.circular(20.r)),
          boxShadow: [
            if (!isDark)
              BoxShadow(
                color: Colors.black12,
                blurRadius: 8,
                offset: Offset(0, -2),
              )
            else
              BoxShadow(
                color: AppColors.whiteColor.withValues(alpha: 0.05),
                blurRadius: 8,
                offset: Offset(0, -2),
              ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: List.generate(items.length, (index) {
            final isSelected = currentIndex == index;
            return GestureDetector(
              onTap: () => onTap(index),
              behavior: HitTestBehavior.opaque,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                padding: EdgeInsets.symmetric(horizontal: 12.w),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    AnimatedSwitcher(
                      duration: const Duration(milliseconds: 300),
                      transitionBuilder: (child, animation) =>
                          ScaleTransition(scale: animation, child: child),
                      child: isSelected
                          ? Column(
                              key: ValueKey('selected$index'),
                              children: [
                                FittedBox(
                                  child: Text(
                                    items[index]['label'] as String,
                                    style: TextStyle(
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w600,
                                      color: selectedColor,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 4.h),
                                Container(
                                  width: 6.w,
                                  height: 6.h,
                                  decoration: BoxDecoration(
                                    color: selectedColor,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                              ],
                            )
                          : TweenAnimationBuilder<Color?>(
                              key: ValueKey('icon$index'),
                              duration: const Duration(milliseconds: 300),
                              tween: ColorTween(
                                begin: selectedColor,
                                end: iconColor,
                              ),
                              builder: (context, color, _) => Icon(
                                items[index]['icon'] as IconData,
                                color: color,
                                size: 28.sp,
                              ),
                            ),
                    ),
                  ],
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
*/