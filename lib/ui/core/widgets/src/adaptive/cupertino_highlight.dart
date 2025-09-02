import 'package:flutter/material.dart';

// These widget are mainly a copy/paste of https://gist.github.com/DerhachevAndrii/9be18815be4bdeaa51e3ff0533032da4
// which is proposed as a workaround for the lack of [Inkwell] alternative for
// Cupertino widgets (see https://github.com/flutter/flutter/issues/48017).

class _CupertinoSplashFactory extends InteractiveInkFeatureFactory {
  const _CupertinoSplashFactory();

  @override
  InteractiveInkFeature create({
    required MaterialInkController controller,
    required RenderBox referenceBox,
    required Offset position,
    required Color color,
    required TextDirection textDirection,
    bool containedInkWell = false,
    RectCallback? rectCallback,
    BorderRadius? borderRadius,
    ShapeBorder? customBorder,
    double? radius,
    VoidCallback? onRemoved,
  }) {
    return CupertinoHighlight(
      controller: controller,
      referenceBox: referenceBox,
      color: color,
      textDirection: textDirection,
      rectCallback: rectCallback,
      borderRadius: borderRadius,
      radius: radius,
      onRemoved: onRemoved,
    );
  }
}

/// A splash factory designed to be used with [InkWell.splashFactory]. It
/// provides a more Cupertino-esque splash effect for iOS and macOS.
class CupertinoHighlight extends InteractiveInkFeature {
  static const InteractiveInkFeatureFactory splashFactory =
      _CupertinoSplashFactory();

  CupertinoHighlight({
    required super.controller,
    required super.referenceBox,
    required super.color,
    required TextDirection textDirection,
    BoxShape shape = BoxShape.rectangle,
    double? radius,
    BorderRadius? borderRadius,
    super.customBorder,
    RectCallback? rectCallback,
    super.onRemoved,
    Duration fadeDuration = const Duration(milliseconds: 200),
  }) : _shape = shape,
       _radius = radius,
       _borderRadius = borderRadius ?? BorderRadius.zero,
       _textDirection = textDirection,
       _rectCallback = rectCallback {
    _alphaController =
        AnimationController(duration: fadeDuration, vsync: controller.vsync)
          ..addListener(controller.markNeedsPaint)
          ..addStatusListener(_handleAlphaStatusChanged)
          ..forward();
    _alpha = _alphaController.drive(IntTween(begin: 0, end: color.alpha));

    controller.addInkFeature(this);
  }

  final BoxShape _shape;
  final double? _radius;
  final BorderRadius _borderRadius;
  final RectCallback? _rectCallback;
  final TextDirection _textDirection;

  late Animation<int> _alpha;
  late AnimationController _alphaController;

  bool get active => _active;
  bool _active = true;

  void activate() {
    _active = true;
    _alphaController.forward();
  }

  void deactivate() {
    _active = false;
    _alphaController.reverse();
  }

  void _handleAlphaStatusChanged(AnimationStatus status) {
    if (status == AnimationStatus.completed) {
      deactivate();
    } else if (status == AnimationStatus.dismissed && !_active) {
      dispose();
    }
  }

  @override
  void dispose() {
    _alphaController.dispose();
    super.dispose();
  }

  @override
  void paintFeature(Canvas canvas, Matrix4 transform) {
    final Paint paint = Paint()..color = color.withAlpha(_alpha.value);
    final Offset? originOffset = MatrixUtils.getAsTranslation(transform);
    final Rect rect =
        _rectCallback != null
            ? _rectCallback()
            : Offset.zero & referenceBox.size;
    if (originOffset == null) {
      canvas.save();
      canvas.transform(transform.storage);
      _paintHighlight(canvas, rect, paint);
      canvas.restore();
    } else {
      _paintHighlight(canvas, rect.shift(originOffset), paint);
    }
  }

  void _paintHighlight(Canvas canvas, Rect rect, Paint paint) {
    canvas.save();
    if (customBorder != null) {
      canvas.clipPath(
        customBorder!.getOuterPath(rect, textDirection: _textDirection),
      );
    }
    switch (_shape) {
      case BoxShape.circle:
        canvas.drawCircle(
          rect.center,
          _radius ?? Material.defaultSplashRadius,
          paint,
        );
      case BoxShape.rectangle:
        if (_borderRadius != BorderRadius.zero) {
          final RRect clipRRect = RRect.fromRectAndCorners(
            rect,
            topLeft: _borderRadius.topLeft,
            topRight: _borderRadius.topRight,
            bottomLeft: _borderRadius.bottomLeft,
            bottomRight: _borderRadius.bottomRight,
          );
          canvas.drawRRect(clipRRect, paint);
        } else {
          canvas.drawRect(rect, paint);
        }
    }
    canvas.restore();
  }
}

/// Returns the adapted splash factory for the given context.
/// On iOS and macOS, this is equivalent to [CupertinoHighlight.splashFactory].
/// On other platforms, this returns `null` to leave Flutter handle the default
/// splash effect.
InteractiveInkFeatureFactory? adaptiveSplashFactory(BuildContext context) {
  final platform = Theme.of(context).platform;
  return platform == TargetPlatform.iOS || platform == TargetPlatform.macOS
      ? CupertinoHighlight.splashFactory
      : null;
}
