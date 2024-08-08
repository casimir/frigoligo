import 'package:cadanse/components/widgets/error.dart';
import 'package:flutter/material.dart';

typedef WrapperBuilder = Widget Function(BuildContext context, Widget child);
typedef AIndexedWidgetBuilder = Future<Widget> Function(BuildContext, int);

const Widget spinner = Center(child: CircularProgressIndicator.adaptive());

class AListView extends StatelessWidget {
  const AListView({
    super.key,
    required this.itemCount,
    required this.itemBuilder,
    this.itemExtent,
    this.separatorBuilder,
    this.create,
    this.emptyBuilder,
  });

  final Future<int> itemCount;
  final IndexedWidgetBuilder itemBuilder;
  final double? itemExtent;
  final IndexedWidgetBuilder? separatorBuilder;
  final WrapperBuilder? create;
  final WidgetBuilder? emptyBuilder;

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
            itemExtent: itemExtent,
            itemCount: count,
            itemBuilder: (context, index) => itemBuilder(context, index),
          );
        } else {
          list = ListView.separated(
            itemCount: count,
            itemBuilder: (context, index) => itemBuilder(context, index),
            separatorBuilder: (context, index) =>
                separatorBuilder!(context, index),
          );
        }
        return create != null ? create!(context, list) : list;
      },
    );
  }

  factory AListView.builder({
    Key? key,
    required Future<int> itemCount,
    required AIndexedWidgetBuilder itemBuilder,
    double? itemExtent,
    WrapperBuilder? create,
    WidgetBuilder? emptyBuilder,
  }) {
    return AListView(
      key: key,
      itemCount: itemCount,
      itemBuilder: (context, index) => AListItemBuilder(
        builder: itemBuilder,
        index: index,
      ),
      itemExtent: itemExtent,
      create: create,
      emptyBuilder: emptyBuilder,
    );
  }

  factory AListView.separated({
    Key? key,
    required Future<int> itemCount,
    required AIndexedWidgetBuilder itemBuilder,
    double? itemHeight,
    required IndexedWidgetBuilder separatorBuilder,
    WrapperBuilder? create,
    WidgetBuilder? emptyBuilder,
  }) {
    return AListView(
      key: key,
      itemCount: itemCount,
      itemBuilder: (context, index) => AListItemBuilder(
        builder: itemBuilder,
        index: index,
        height: itemHeight,
      ),
      separatorBuilder: separatorBuilder,
      create: create,
      emptyBuilder: emptyBuilder,
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
