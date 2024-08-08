import 'dart:convert';

import 'package:drift/drift.dart';

class ListConverter<T> extends TypeConverter<List<T>, String> {
  const ListConverter();

  @override
  List<T> fromSql(String fromDb) => List.castFrom(jsonDecode(fromDb));

  @override
  String toSql(List<T> value) => jsonEncode(value);
}

typedef StringListConverter = ListConverter<String>;
