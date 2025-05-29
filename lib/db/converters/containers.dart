import 'dart:collection';
import 'dart:convert';

import 'package:drift/drift.dart';

class ListConverter<T> extends TypeConverter<List<T>, String> {
  const ListConverter();

  @override
  List<T> fromSql(String fromDb) =>
      _EquatableList(List.castFrom(jsonDecode(fromDb)));

  @override
  String toSql(List<T> value) => jsonEncode(value);
}

typedef StringListConverter = ListConverter<String>;

class _EquatableList<T> extends ListBase<T> {
  _EquatableList(this._inner);

  final List<T> _inner;

  @override
  int get length => _inner.length;

  @override
  set length(int value) => _inner.length = value;

  @override
  T operator [](int index) => _inner[index];

  @override
  void operator []=(int index, T value) => _inner[index] = value;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is _EquatableList<T> && this.hashCode == other.hashCode);

  @override
  int get hashCode => Object.hashAllUnordered(_inner);
}
