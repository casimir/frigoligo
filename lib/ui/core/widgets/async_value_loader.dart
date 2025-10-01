import 'package:cadanse/components/widgets/error.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AsyncValueLoader<T> extends StatelessWidget {
  const AsyncValueLoader({
    super.key,
    required this.value,
    required this.builder,
  });

  final AsyncValue<T> value;
  final Widget Function(BuildContext context, T) builder;

  @override
  Widget build(BuildContext context) {
    return value.when(
      data: (data) => builder(context, data),
      error: (error, stackTrace) => ErrorScreen(error: error),
      loading: () => const Center(child: CircularProgressIndicator.adaptive()),
    );
  }
}
