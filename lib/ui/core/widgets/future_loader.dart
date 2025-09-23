import 'package:cadanse/components/widgets/error.dart';
import 'package:flutter/material.dart';

class FutureLoader<T> extends StatelessWidget {
  const FutureLoader({super.key, required this.future, required this.builder});

  final Future<T> future;
  final Widget Function(BuildContext context, T) builder;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: future,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator.adaptive());
        }

        if (snapshot.hasError) {
          return Center(child: ErrorScreen(error: snapshot.error!));
        }

        return builder(context, snapshot.data as T);
      },
    );
  }
}
