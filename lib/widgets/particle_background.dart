import 'dart:math';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import '../utils/app_colors.dart';

/// A unique, decent, and ultra-sleek animated background featuring:
/// - Floating organic Aurora energy waves (Electric Blue, Violet, Amber)
/// - Subtle interactive Dot Matrix Grid that reacts to cursor/touch
/// - Rich twinkling cosmic micro-stardust with depth parallax
/// - Frequent, multi-trajectory shooting stars with Astra gradient streaks
class ParticleBackground extends StatefulWidget {
  const ParticleBackground({super.key});

  @override
  State<ParticleBackground> createState() => _ParticleBackgroundState();
}

class _ParticleBackgroundState extends State<ParticleBackground>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final List<StarParticle> _stars = [];
  final List<ShootingStar> _shootingStars = [];
  final Random _random = Random();

  Offset _targetMousePos = const Offset(-500, -500);
  Offset _currentMousePos = const Offset(-500, -500);
  double _lastShootingStarTime = 0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 20),
    )..repeat();

    _initStars();
  }

  void _initStars() {
    // Increased particle count for a richer, more luminous cosmos
    for (int i = 0; i < 85; i++) {
      _stars.add(StarParticle(
        x: _random.nextDouble(),
        y: _random.nextDouble(),
        baseSize: _random.nextDouble() * 2.2 + 0.8,
        twinkleSpeed: _random.nextDouble() * 3.0 + 1.2,
        twinklePhase: _random.nextDouble() * pi * 2,
        driftSpeedX: (_random.nextDouble() - 0.5) * 0.0005,
        driftSpeedY: (_random.nextDouble() - 0.5) * 0.0005,
        color: _random.nextDouble() > 0.65
            ? AppColors.secondary
            : (_random.nextDouble() > 0.4
                ? AppColors.primaryLight
                : (_random.nextDouble() > 0.2
                    ? AppColors.accentLight
                    : Colors.white)),
      ));
    }
  }

  void _triggerShootingStars(double t, Size size) {
    // Spawn shooting stars more frequently (~every 1.5 - 2.2 seconds)
    if (t - _lastShootingStarTime > 1.6 && _shootingStars.length < 3) {
      if (_random.nextDouble() < 0.12) {
        _lastShootingStarTime = t;
        final startX = _random.nextDouble() * size.width * 0.9;
        final startY = _random.nextDouble() * size.height * 0.55;
        _shootingStars.add(ShootingStar(
          start: Offset(startX, startY),
          length: 130.0 + _random.nextDouble() * 90.0,
          angle: pi / 4 + (_random.nextDouble() - 0.5) * 0.35, // ~35 to 55 deg
          progress: 0.0,
          speed: 0.022 + _random.nextDouble() * 0.016,
        ));
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onHover: (event) {
        setState(() {
          _targetMousePos = event.localPosition;
        });
      },
      onExit: (_) {
        setState(() {
          _targetMousePos = const Offset(-500, -500);
        });
      },
      child: GestureDetector(
        onPanUpdate: (details) {
          setState(() {
            _targetMousePos = details.localPosition;
          });
        },
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            // Smooth mouse cursor interpolation
            _currentMousePos = Offset(
              ui.lerpDouble(_currentMousePos.dx, _targetMousePos.dx, 0.08) ?? 0,
              ui.lerpDouble(_currentMousePos.dy, _targetMousePos.dy, 0.08) ?? 0,
            );

            final t = _controller.value * 20.0;

            // Update star positions with gentle wrapping drift
            for (var star in _stars) {
              star.x = (star.x + star.driftSpeedX) % 1.0;
              star.y = (star.y + star.driftSpeedY) % 1.0;
              if (star.x < 0) star.x += 1.0;
              if (star.y < 0) star.y += 1.0;
            }

            // Update active shooting stars
            for (int i = _shootingStars.length - 1; i >= 0; i--) {
              _shootingStars[i].progress += _shootingStars[i].speed;
              if (_shootingStars[i].progress >= 1.0) {
                _shootingStars.removeAt(i);
              }
            }

            return CustomPaint(
              painter: CelestialAuroraPainter(
                time: t,
                stars: _stars,
                shootingStars: _shootingStars,
                mousePos: _currentMousePos,
                onCheckShootingStars: (size) => _triggerShootingStars(t, size),
              ),
              size: Size.infinite,
            );
          },
        ),
      ),
    );
  }
}

class StarParticle {
  double x, y;
  final double baseSize;
  final double twinkleSpeed;
  final double twinklePhase;
  final double driftSpeedX;
  final double driftSpeedY;
  final Color color;

  StarParticle({
    required this.x,
    required this.y,
    required this.baseSize,
    required this.twinkleSpeed,
    required this.twinklePhase,
    required this.driftSpeedX,
    required this.driftSpeedY,
    required this.color,
  });
}

class ShootingStar {
  final Offset start;
  final double length;
  final double angle;
  final double speed;
  double progress;

  ShootingStar({
    required this.start,
    required this.length,
    required this.angle,
    required this.speed,
    required this.progress,
  });
}

class CelestialAuroraPainter extends CustomPainter {
  final double time;
  final List<StarParticle> stars;
  final List<ShootingStar> shootingStars;
  final Offset mousePos;
  final Function(Size) onCheckShootingStars;

  CelestialAuroraPainter({
    required this.time,
    required this.stars,
    required this.shootingStars,
    required this.mousePos,
    required this.onCheckShootingStars,
  });

  @override
  void paint(Canvas canvas, Size size) {
    onCheckShootingStars(size);

    // 1. Draw Deep Atmospheric Aurora Glows
    _drawAuroraGlows(canvas, size);

    // 2. Draw Subtle Tech Dot Matrix Grid
    _drawDotMatrixGrid(canvas, size);

    // 3. Draw Cosmic Twinkling Stars
    _drawStars(canvas, size);

    // 4. Draw Shooting Stars (frequent & luminous)
    for (var star in shootingStars) {
      _drawShootingStar(canvas, size, star);
    }

    // 5. Draw Interactive Cursor Light Aura
    if (mousePos.dx > 0 && mousePos.dy > 0) {
      _drawCursorAura(canvas, size);
    }
  }

  void _drawAuroraGlows(Canvas canvas, Size size) {
    final paint = Paint()..style = PaintingStyle.fill;

    // Aurora Center 1: Electric Blue (Top-Right)
    final x1 = size.width * (0.65 + 0.15 * sin(time * 0.3));
    final y1 = size.height * (0.25 + 0.10 * cos(time * 0.25));
    final r1 = size.width < 600 ? 240.0 : 380.0;

    paint.shader = ui.Gradient.radial(
      Offset(x1, y1),
      r1,
      [
        AppColors.primary.withValues(alpha: 0.16 + 0.04 * sin(time * 0.5)),
        AppColors.primary.withValues(alpha: 0.05),
        Colors.transparent,
      ],
      [0.0, 0.5, 1.0],
    );
    canvas.drawCircle(Offset(x1, y1), r1, paint);

    // Aurora Center 2: Astra Violet (Left / Middle)
    final x2 = size.width * (0.25 + 0.12 * cos(time * 0.35));
    final y2 = size.height * (0.55 + 0.12 * sin(time * 0.28));
    final r2 = size.width < 600 ? 220.0 : 340.0;

    paint.shader = ui.Gradient.radial(
      Offset(x2, y2),
      r2,
      [
        AppColors.secondary.withValues(alpha: 0.13 + 0.03 * cos(time * 0.4)),
        AppColors.secondary.withValues(alpha: 0.04),
        Colors.transparent,
      ],
      [0.0, 0.55, 1.0],
    );
    canvas.drawCircle(Offset(x2, y2), r2, paint);

    // Aurora Center 3: Amber Golden Star Glow (Bottom-Right)
    final x3 = size.width * (0.75 + 0.10 * sin(time * 0.4));
    final y3 = size.height * (0.80 + 0.08 * cos(time * 0.32));
    final r3 = size.width < 600 ? 180.0 : 280.0;

    paint.shader = ui.Gradient.radial(
      Offset(x3, y3),
      r3,
      [
        AppColors.accent.withValues(alpha: 0.09 + 0.02 * sin(time * 0.6)),
        AppColors.accent.withValues(alpha: 0.02),
        Colors.transparent,
      ],
      [0.0, 0.6, 1.0],
    );
    canvas.drawCircle(Offset(x3, y3), r3, paint);
  }

  void _drawDotMatrixGrid(Canvas canvas, Size size) {
    const spacing = 42.0;
    final dotPaint = Paint()..style = PaintingStyle.fill;

    final cols = (size.width / spacing).ceil() + 1;
    final rows = (size.height / spacing).ceil() + 1;

    for (int i = 0; i < cols; i++) {
      for (int j = 0; j < rows; j++) {
        final px = i * spacing;
        final py = j * spacing;

        double opacity = 0.04;

        if (mousePos.dx > 0 && mousePos.dy > 0) {
          final dx = mousePos.dx - px;
          final dy = mousePos.dy - py;
          final dist = sqrt(dx * dx + dy * dy);
          if (dist < 140) {
            opacity += (1.0 - dist / 140) * 0.18;
          }
        }

        dotPaint.color = Colors.white.withValues(alpha: opacity.clamp(0.0, 1.0));
        canvas.drawCircle(Offset(px, py), 1.0, dotPaint);
      }
    }
  }

  void _drawStars(Canvas canvas, Size size) {
    final starPaint = Paint()..style = PaintingStyle.fill;

    for (var star in stars) {
      final sx = star.x * size.width;
      final sy = star.y * size.height;

      final twinkle = (sin(time * star.twinkleSpeed + star.twinklePhase) + 1.0) / 2.0;
      final currentSize = star.baseSize * (0.65 + 0.35 * twinkle);
      final alpha = (0.2 + 0.65 * twinkle).clamp(0.0, 1.0);

      // Star core
      starPaint.color = star.color.withValues(alpha: alpha);
      canvas.drawCircle(Offset(sx, sy), currentSize, starPaint);

      // Star soft aura for larger luminous stars
      if (star.baseSize > 1.8 && twinkle > 0.5) {
        starPaint.color = star.color.withValues(alpha: (twinkle * 0.22).clamp(0.0, 1.0));
        canvas.drawCircle(Offset(sx, sy), currentSize * 2.6, starPaint);
      }
    }
  }

  void _drawShootingStar(Canvas canvas, Size size, ShootingStar star) {
    final curX = star.start.dx + cos(star.angle) * (star.length * star.progress * 2.8);
    final curY = star.start.dy + sin(star.angle) * (star.length * star.progress * 2.8);
    final tailX = curX - cos(star.angle) * star.length;
    final tailY = curY - sin(star.angle) * star.length;

    final alpha = (sin(star.progress * pi) * 0.9).clamp(0.0, 1.0);

    // Astra Tri-color streak trail (Blue -> Violet -> Amber -> White)
    final linePaint = Paint()
      ..strokeWidth = 1.8
      ..strokeCap = StrokeCap.round
      ..shader = ui.Gradient.linear(
        Offset(tailX, tailY),
        Offset(curX, curY),
        [
          Colors.transparent,
          AppColors.primary.withValues(alpha: alpha * 0.4),
          AppColors.secondary.withValues(alpha: alpha * 0.75),
          AppColors.accentLight.withValues(alpha: alpha * 0.9),
          Colors.white.withValues(alpha: alpha),
        ],
        [0.0, 0.3, 0.65, 0.9, 1.0],
      );

    canvas.drawLine(Offset(tailX, tailY), Offset(curX, curY), linePaint);

    // Glowing head
    final headPaint = Paint()
      ..color = Colors.white.withValues(alpha: alpha)
      ..style = PaintingStyle.fill;
    canvas.drawCircle(Offset(curX, curY), 2.2, headPaint);

    // Head subtle glow aura
    final glowPaint = Paint()
      ..color = AppColors.secondary.withValues(alpha: alpha * 0.4)
      ..style = PaintingStyle.fill;
    canvas.drawCircle(Offset(curX, curY), 4.5, glowPaint);
  }

  void _drawCursorAura(Canvas canvas, Size size) {
    final auraPaint = Paint()..style = PaintingStyle.fill;
    auraPaint.shader = ui.Gradient.radial(
      mousePos,
      160.0,
      [
        AppColors.primary.withValues(alpha: 0.10),
        AppColors.secondary.withValues(alpha: 0.03),
        Colors.transparent,
      ],
      [0.0, 0.4, 1.0],
    );
    canvas.drawCircle(mousePos, 160.0, auraPaint);
  }

  @override
  bool shouldRepaint(CelestialAuroraPainter oldDelegate) => true;
}
