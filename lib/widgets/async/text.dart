import 'package:flutter/widgets.dart';

class AText extends StatelessWidget {
  const AText({super.key, required this.builder, this.style});

  final Future<String> Function(BuildContext) builder;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: builder(context),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return AnimatedEllipsis(style: style);
        }
        if (snapshot.hasError) {
          throw snapshot.error!;
        }
        return Text(snapshot.data!, style: style);
      },
    );
  }
}

class AnimatedEllipsis extends StatefulWidget {
  const AnimatedEllipsis({super.key, this.style});

  final TextStyle? style;

  @override
  State<AnimatedEllipsis> createState() => _AnimatedEllipsisState();
}

class _AnimatedEllipsisState extends State<AnimatedEllipsis>
    with TickerProviderStateMixin {
  final List<AnimationController> _controllers = [];
  final List<Animation<double>> _animations = [];
  final List<Widget> _dots = <Widget>[];

  @override
  void initState() {
    super.initState();

    for (var i = 0; i < 3; i++) {
      _registerAnimatedDot(i);
    }
    _controllers[0].forward();
  }

  void _registerAnimatedDot(int index) {
    _controllers.add(
      AnimationController(
        duration: const Duration(milliseconds: 200),
        vsync: this,
      ),
    );

    const tweenEnd = 8.0;
    _animations.add(
      Tween(begin: 0.0, end: tweenEnd).animate(_controllers[index])
        ..addStatusListener((status) {
          if (status == AnimationStatus.completed) {
            _controllers[index].reverse();
          }
          if (index == 2 && status == AnimationStatus.dismissed) {
            _controllers[0].forward();
          }
          if (_animations[index].value > tweenEnd / 2 && index < 2) {
            _controllers[index + 1].forward();
          }
        }),
    );

    _dots.add(_EllipseDot(listenable: _animations[index], style: widget.style));
  }

  @override
  void dispose() {
    for (final it in _controllers) {
      it.dispose();
    }

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final fontSize =
        widget.style?.fontSize ?? DefaultTextStyle.of(context).style.fontSize!;
    return SizedBox(
      height: fontSize * 1.5,
      child: Row(children: _dots),
    );
  }
}

class _EllipseDot extends AnimatedWidget {
  const _EllipseDot({required super.listenable, this.style});

  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    final animation = listenable as Animation<double>;
    final fontSize =
        style?.fontSize ?? DefaultTextStyle.of(context).style.fontSize!;
    return SizedBox(
      height: animation.value + fontSize,
      child: Text('.', style: style),
    );
  }
}
