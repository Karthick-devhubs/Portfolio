import 'dart:math';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  final Widget child;
  const SplashScreen({super.key, required this.child});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  bool _showContent = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    )..repeat();

    Future.delayed(const Duration(milliseconds: 2500), () {
      if (mounted) {
        setState(() => _showContent = true);
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 600),
      child: _showContent
          ? widget.child
          : Scaffold(
              backgroundColor: const Color(0xFF0a0a0a),
              body: Center(
                child: AnimatedBuilder(
                  animation: _controller,
                  builder: (context, child) {
                    return CustomPaint(
                      painter: SegmentedCircularLoader(_controller.value),
                      size: const Size(100, 100),
                    );
                  },
                ),
              ),
            ),
    );
  }
}

class SegmentedCircularLoader extends CustomPainter {
  final double progress;

  SegmentedCircularLoader(this.progress);

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;
    final strokeWidth = 5.0;
    final rotation = progress * 2 * pi;

    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    // Arc length and gap
    final arcLength = pi * 0.4; // ~72 degrees
    final gap = (2 * pi - 3 * arcLength) / 3; // Equal gaps

    // Top-right arc (Red)
    paint.color = const Color(0xFFE74C3C);
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -pi / 2 + rotation,
      arcLength,
      false,
      paint,
    );

    // Bottom arc (Orange)
    paint.color = const Color(0xFFE67E22);
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -pi / 2 + arcLength + gap + rotation,
      arcLength,
      false,
      paint,
    );

    // Left arc (White)
    paint.color = Colors.white;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -pi / 2 + 2 * (arcLength + gap) + rotation,
      arcLength,
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(SegmentedCircularLoader oldDelegate) => true;
}
