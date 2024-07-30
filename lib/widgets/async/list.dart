import 'package:cadanse/components/widgets/error.dart';
import 'package:flutter/material.dart';

const Widget spinner = Center(child: CircularProgressIndicator.adaptive());

class AListView extends StatelessWidget {
  const AListView({
    super.key,
    required this.itemCount,
    required this.itemBuilder,
    this.itemHeight,
    this.separatorBuilder,
    this.create,
    this.emptyBuilder,
  });

  final Future<int> itemCount;
  final Widget Function(BuildContext context, int index) itemBuilder;
  final double? itemHeight;
  final Widget Function(BuildContext context, int index)? separatorBuilder;
  final Widget Function(BuildContext context, Widget child)? create;
  final Widget Function(BuildContext context)? emptyBuilder;

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
    required AItemBuilderFunc itemBuilder,
    double? itemHeight,
    Widget Function(BuildContext, Widget)? create,
    Widget Function(BuildContext)? emptyBuilder,
  }) {
    return AListView(
      key: key,
      itemCount: itemCount,
      itemBuilder: (context, index) => AListItemBuilder(
        builder: itemBuilder,
        index: index,
        height: itemHeight,
      ),
      itemHeight: itemHeight,
      create: create,
      emptyBuilder: emptyBuilder,
    );
  }

  factory AListView.separated({
    Key? key,
    required Future<int> itemCount,
    required AItemBuilderFunc itemBuilder,
    double? itemHeight,
    required Widget Function(BuildContext, int) separatorBuilder,
    Widget Function(BuildContext, Widget)? create,
    Widget Function(BuildContext)? emptyBuilder,
  }) {
    return AListView(
      key: key,
      itemCount: itemCount,
      itemBuilder: (context, index) => AListItemBuilder(
        builder: itemBuilder,
        index: index,
        height: itemHeight,
      ),
      itemHeight: itemHeight,
      separatorBuilder: separatorBuilder,
      create: create,
      emptyBuilder: emptyBuilder,
    );
  }
}

typedef AItemBuilderFunc = Future<Widget> Function(BuildContext, int);

class AListItemBuilder extends StatelessWidget {
  const AListItemBuilder({
    super.key,
    required this.builder,
    required this.index,
    this.height,
  });

  final AItemBuilderFunc builder;
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
