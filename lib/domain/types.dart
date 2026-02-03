/// Wrapper to distinguish "absent" from "present with value".
///
/// Use when `null` is a valid value:
/// - `null` means "absent" (don't change)
/// - `Some(null)` means "present with null value"
/// - `Some(value)` means "present with value"
class Some<T> {
  const Some(this.value);

  final T value;

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is Some<T> && value == other.value;

  @override
  int get hashCode => value.hashCode;

  @override
  String toString() => 'Some($value)';
}

/// Optional value: either `Some(value)` or `null` (absent).
typedef Option<T> = Some<T>?;
