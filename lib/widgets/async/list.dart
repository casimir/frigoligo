import 'package:cadanse/components/widgets/error.dart';
import 'package:flutter/material.dart';

typedef WrapperBuilder = Widget Function(BuildContext context, Widget child);
typedef AIndexedWidgetBuilder = Future<Widget> Function(BuildContext, int);

const Widget spinner = Center(child: CircularProgressIndicator.adaptive());

class AListView extends StatelessWidget {
  const AListView({
    super.key,
    this.controller,
    required this.itemCount,
    required this.itemBuilder,
    this.itemExtent,
    this.separatorBuilder,
    this.create,
    this.emptyBuilder,
    this.restorationId,
  });

  final ScrollController? controller;
  final Future<int> itemCount;
  final IndexedWidgetBuilder itemBuilder;
  final double? itemExtent;
  final IndexedWidgetBuilder? separatorBuilder;
  final WrapperBuilder? create;
  final WidgetBuilder? emptyBuilder;
  final String? restorationId;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<int>(
      future: itemCount,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // TODO center vertically
          return spinner;
        }

        if (snapshot.hasError) {
          // TODO center vertically
          return Center(child: ErrorScreen(error: snapshot.error!));
        }

        final count = snapshot.data!;
        if (count == 0 && emptyBuilder != null) {
          return emptyBuilder!(context);
        }
        late final ListView list;
        if (separatorBuilder == null) {
          list = ListView.builder(
            controller: controller,
            itemExtent: itemExtent,
            itemCount: count,
            itemBuilder: (context, index) => itemBuilder(context, index),
            restorationId: restorationId,
          );
        } else {
          list = ListView.separated(
            controller: controller,
            itemCount: count,
            itemBuilder: (context, index) => itemBuilder(context, index),
            separatorBuilder: (context, index) =>
                separatorBuilder!(context, index),
            restorationId: restorationId,
          );
        }
        return create != null ? create!(context, list) : list;
      },
    );
  }

  factory AListView.builder({
    Key? key,
    ScrollController? controller,
    required Future<int> itemCount,
    required AIndexedWidgetBuilder itemBuilder,
    double? itemExtent,
    WrapperBuilder? create,
    WidgetBuilder? emptyBuilder,
    String? restorationId,
  }) {
    return AListView(
      key: key,
      controller: controller,
      itemCount: itemCount,
      itemBuilder: (context, index) =>
          AListItemBuilder(builder: itemBuilder, index: index),
      itemExtent: itemExtent,
      create: create,
      emptyBuilder: emptyBuilder,
      restorationId: restorationId,
    );
  }

  factory AListView.separated({
    Key? key,
    ScrollController? controller,
    required Future<int> itemCount,
    required AIndexedWidgetBuilder itemBuilder,
    double? itemHeight,
    required IndexedWidgetBuilder separatorBuilder,
    WrapperBuilder? create,
    WidgetBuilder? emptyBuilder,
    String? restorationId,
  }) {
    return AListView(
      key: key,
      controller: controller,
      itemCount: itemCount,
      itemBuilder: (context, index) => AListItemBuilder(
        builder: itemBuilder,
        index: index,
        height: itemHeight,
      ),
      separatorBuilder: separatorBuilder,
      create: create,
      emptyBuilder: emptyBuilder,
      restorationId: restorationId,
    );
  }
}

class AListItemBuilder extends StatelessWidget {
  const AListItemBuilder({
    super.key,
    required this.builder,
    required this.index,
    this.height,
  });

  final AIndexedWidgetBuilder builder;
  final int index;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Widget>(
      future: builder(context, index),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return SizedBox(height: height, child: spinner);
        }

        if (snapshot.hasError) {
          return SizedBox(
            height: height,
            child: Center(child: ErrorScreen(error: snapshot.error!)),
          );
        }

        return snapshot.data!;
      },
    );
  }
}
