import 'package:flutter_test/flutter_test.dart';

void main() {
  test(
    'Sum tow numbers',
    () {
      final num1 = 1;
      final num2 = 3;
      final sum = num2 + num1;

      expect(num1, isPositive);
      expect(sum, isNonNegative);
      expect(num2, 3);
    },
  );
}
