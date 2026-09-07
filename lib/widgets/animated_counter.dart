import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';

/// An animated number counter that smoothly ticks upwards from 0 to the target value
/// when scrolled into view.
class AnimatedCounter extends StatefulWidget {
  final int targetValue;
  final String suffix;
  final String prefix;
  final TextStyle style;
  final Duration duration;
  final Curve curve;
  final Gradient? gradient;

  const AnimatedCounter({
    super.key,
    required this.targetValue,
    this.suffix = '',
    this.prefix = '',
    required this.style,
    this.duration = const Duration(milliseconds: 1600),
    this.curve = Curves.easeOutCubic,
    this.gradient,
  });

  @override
  State<AnimatedCounter> createState() => _AnimatedCounterState();
}

class _AnimatedCounterState extends State<AnimatedCounter>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  bool _hasTriggered = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    );
    _animation = Tween<double>(
      begin: 0,
      end: widget.targetValue.toDouble(),
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: widget.curve,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onVisibilityChanged(VisibilityInfo info) {
    if (!_hasTriggered && info.visibleFraction > 0.2) {
      _hasTriggered = true;
      if (mounted) {
        _controller.forward();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: Key('counter_${widget.targetValue}_${widget.suffix}_${widget.hashCode}'),
      onVisibilityChanged: _onVisibilityChanged,
      child: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          final currentValue = _animation.value.round();
          final displayText = '${widget.prefix}$currentValue${widget.suffix}';

          if (widget.gradient != null) {
            return ShaderMask(
              shaderCallback: (bounds) => widget.gradient!.createShader(bounds),
              child: Text(
                displayText,
                style: widget.style.copyWith(color: Colors.white),
              ),
            );
          }

          return Text(
            displayText,
            style: widget.style,
          );
        },
      ),
    );
  }
}
