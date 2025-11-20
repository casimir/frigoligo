import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../config/dependencies.dart';

part '_g/repository_providers.g.dart';

@riverpod
ArticleRepository articleRepository(Ref ref) => dependencies.get();

@riverpod
QueryRepository queryRepository(Ref ref) => dependencies.get();

@riverpod
TagRepository tagRepository(Ref ref) => dependencies.get();
