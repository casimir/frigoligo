import 'package:cadanse/components/widgets/error.dart';
import 'package:flutter/material.dart';

class FutureLoader<T> extends StatelessWidget {
  const FutureLoader({
    super.key,
    required this.future,
    required this.builder,
    this.loadingBuilder,
    this.errorBuilder,
  });

  final Future<T> future;
  final Widget Function(BuildContext context, T) builder;
  final WidgetBuilder? loadingBuilder;
  final Widget Function(BuildContext context, Object error)? errorBuilder;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: future,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return loadingBuilder != null
              ? loadingBuilder!(context)
              : const Center(child: CircularProgressIndicator.adaptive());
        }

        if (snapshot.hasError) {
          return errorBuilder != null
              ? errorBuilder!(context, snapshot.error!)
              : Center(child: ErrorScreen(error: snapshot.error!));
        }

        return builder(context, snapshot.data as T);
      },
    );
  }
}
