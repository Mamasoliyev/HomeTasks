import 'package:flutter_test/flutter_test.dart';
import 'package:quiz_app/model/rim_raqam.dart';

void main() {
  test('123 should return CXXIII', () {
    Solution s = Solution();
    expect(s.romanToInt(123), 'CXXIII');
  });
}
