// library curved_nav_bar;

// import 'package:flutter/material.dart';

// class CurvedNavBar extends StatelessWidget {
//   final int currentIndex;
//   final ValueChanged<int> onTap;
//   final List<IconData> icons;
//   final List<String> labels;

//   const CurvedNavBar({
//     super.key,
//     required this.currentIndex,
//     required this.onTap,
//     required this.icons,
//     required this.labels,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final bool isDark = Theme.of(context).brightness == Brightness.dark;
//     final Color bgColor = isDark
//         ? Colors.black.withOpacity(0.85)
//         : Colors.white;
//     final Color iconColor = isDark ? Colors.white60 : Colors.black54;
//     final Color selectedColor = Colors.blueAccent;

//     return SafeArea(
//       child: Container(
//         margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
//         padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
//         decoration: BoxDecoration(
//           color: bgColor,
//           borderRadius: BorderRadius.circular(20),
//           boxShadow: [
//             BoxShadow(
//               color: isDark ? Colors.white10 : Colors.black12,
//               blurRadius: 8,
//               offset: const Offset(0, -2),
//             ),
//           ],
//         ),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceAround,
//           children: List.generate(icons.length, (index) {
//             final bool isSelected = currentIndex == index;
//             return GestureDetector(
//               onTap: () => onTap(index),
//               behavior: HitTestBehavior.opaque,
//               child: AnimatedContainer(
//                 duration: const Duration(milliseconds: 300),
//                 padding: const EdgeInsets.symmetric(horizontal: 12),
//                 child: Column(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     AnimatedSwitcher(
//                       duration: const Duration(milliseconds: 300),
//                       transitionBuilder: (child, animation) =>
//                           ScaleTransition(scale: animation, child: child),
//                       child: isSelected
//                           ? Column(
//                               key: ValueKey('selected$index'),
//                               children: [
//                                 Text(
//                                   labels[index],
//                                   style: TextStyle(
//                                     fontSize: 12,
//                                     fontWeight: FontWeight.w600,
//                                     color: selectedColor,
//                                   ),
//                                 ),
//                                 const SizedBox(height: 4),
//                                 Container(
//                                   width: 6,
//                                   height: 6,
//                                   decoration: BoxDecoration(
//                                     color: selectedColor,
//                                     shape: BoxShape.circle,
//                                   ),
//                                 ),
//                               ],
//                             )
//                           : Icon(icons[index], color: iconColor, size: 28),
//                     ),
//                   ],
//                 ),
//               ),
//             );
//           }),
//         ),
//       ),
//     );
//   }
// }
