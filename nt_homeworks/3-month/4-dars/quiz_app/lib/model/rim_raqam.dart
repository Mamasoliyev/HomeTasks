import 'dart:io';

class Solution {
  int romanToInt(String s) {
    int son = 0;
    final List<String> roman = [
      'M',
      'CM',
      'D',
      'CD',
      'C',
      'XC',
      'L',
      'XL',
      'X',
      'IX',
      'V',
      'IV',
      'I',
    ];
    final List<int> arabic = [
      1000,
      900,
      500,
      400,
      100,
      90,
      50,
      40,
      10,
      9,
      5,
      4,
      1,
    ];

    for (int i = 0; i < roman.length; i++) {
      while()
    }
  }
}

void main(List<String> args) {
  while (true) {
    Solution solution = Solution();
    print(solution.romanToInt('C'));
  }
}
