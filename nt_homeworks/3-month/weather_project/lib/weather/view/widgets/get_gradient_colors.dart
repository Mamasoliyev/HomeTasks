import 'dart:ui';

List<Color> getGradientColors(String condition) {
  switch (condition.toLowerCase()) {
    case 'rain':
      return [
        const Color(0xFF4A637D),
        const Color(0xFF3C5067),
        const Color(0xFF1D2B3A),
      ]; // Dark blue-gray tones
    case 'clear':
    case 'sunny':
      return [
        const Color(0xFFFEEBCF),
        const Color(0xFFF9B989),
        const Color(0xFFF59D4C),
      ]; // Sunny orange-yellow tones
    case 'snow':
      return [
        const Color(0xFFE0F7FA),
        const Color(0xFFB2EBF2),
        const Color(0xFF80DEEA),
      ]; // Icy blue tones
    case 'clouds':
    case 'cloudy':
      return [
        const Color(0xFFB0BEC5),
        const Color(0xFF90A4AE),
        const Color(0xFF78909C),
      ]; // Gray cloudy tones
    default:
      return [
        const Color(0xFFCCCCCC),
        const Color(0xFFAAAAAA),
        const Color(0xFF888888),
      ]; // Default gray
  }
}
