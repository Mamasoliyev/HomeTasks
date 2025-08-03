import 'dart:ui';

Color getInfoContainerColor(String condition) {
  switch (condition.toLowerCase()) {
    case 'rain':
      return const Color(0xFFB3CDE0); // Soft rainy blue
    case 'clear':
    case 'sunny':
      return const Color(0xFFFDDCC3); // Warm sunny peach
    case 'snow':
      return const Color(0xFFE0F7FA); // Cool icy blue
    case 'clouds':
    case 'cloudy':
      return const Color(0xFFDDE1E4); // Muted gray-blue
    default:
      return const Color(0xFFF0F0F0); // Neutral fallback
  }
}
