import 'dart:math';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  final Widget child;
  const SplashScreen({super.key, required this.child});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _loaderController;
  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;
  bool _showContent = false;

  @override
  void initState() {
    super.initState();
    _loaderController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    )..repeat();

    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(parent: _fadeController, curve: Curves.easeOut),
    );

    Future.delayed(const Duration(milliseconds: 3000), () {
      if (mounted) {
        _fadeController.forward().then((_) {
          if (mounted) setState(() => _showContent = true);
        });
      }
    });
  }

  @override
  void dispose() {
    _loaderController.dispose();
    _fadeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_showContent) return widget.child;

    return Scaffold(
      backgroundColor: const Color(0xFF0a0a0a),
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedBuilder(
                animation: _loaderController,
                builder: (context, child) {
                  return Stack(
                    alignment: Alignment.center,
                    children: [
                      CustomPaint(
                        painter: SegmentedCircularLoader(_loaderController.value),
                        size: const Size(100, 100),
                      ),
                      ClipOval(
                        child: Image.asset(
                          'assets/images/logo.jpg',
                          width: 70,
                          height: 70,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ],
                  );
                },
              ),
              const SizedBox(height: 24),
              _buildAnimatedText(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAnimatedText() {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: const Duration(milliseconds: 800),
      curve: Curves.easeOut,
      builder: (context, value, child) {
        return Opacity(
          opacity: value,
          child: Transform.translate(
            offset: Offset(0, 20 * (1 - value)),
            child: child,
          ),
        );
      },
      child: const Text(
        'Karthick Portfolio',
        style: TextStyle(
          color: Colors.white70,
          fontSize: 18,
          fontWeight: FontWeight.w300,
          letterSpacing: 2,
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
