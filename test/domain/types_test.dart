import 'package:frigoligo/domain/types.dart';
import 'package:test/test.dart';

void main() {
  group('Some', () {
    test('Some wraps a value', () {
      final opt = Some(42);
      expect(opt.value, 42);
    });

    test('Some wraps null', () {
      final opt = Some<int?>(null);
      expect(opt.value, isNull);
    });

    test('equality compares by value', () {
      expect(Some(42), equals(Some(42)));
      expect(Some('hello'), equals(Some('hello')));
      expect(Some(42), isNot(equals(Some(43))));
    });

    test('equality works with null values', () {
      expect(Some<int?>(null), equals(Some<int?>(null)));
    });

    test('toString returns readable format', () {
      expect(Some(42).toString(), 'Some(42)');
      expect(Some<int?>(null).toString(), 'Some(null)');
    });
  });
}
