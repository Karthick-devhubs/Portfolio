import 'dart:math';
import 'package:flutter/material.dart';

class ParticleBackground extends StatefulWidget {
  const ParticleBackground({super.key});

  @override
  State<ParticleBackground> createState() => _ParticleBackgroundState();
}

class _ParticleBackgroundState extends State<ParticleBackground>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final List<Particle> _particles = [];
  Offset _mousePosition = Offset.zero;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();
    _initParticles();
  }

  void _initParticles() {
    final random = Random();
    for (int i = 0; i < 80; i++) {
      _particles.add(Particle(
        x: random.nextDouble(),
        y: random.nextDouble(),
        vx: (random.nextDouble() - 0.5) * 0.002,
        vy: (random.nextDouble() - 0.5) * 0.002,
        size: random.nextDouble() * 3 + 1,
      ));
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
          _mousePosition = event.localPosition;
        });
      },
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          _updateParticles();
          return CustomPaint(
            painter: ParticlePainter(_particles, _mousePosition),
            size: Size.infinite,
          );
        },
      ),
    );
  }

  void _updateParticles() {
    for (var particle in _particles) {
      particle.x += particle.vx;
      particle.y += particle.vy;

      if (particle.x < 0 || particle.x > 1) particle.vx *= -1;
      if (particle.y < 0 || particle.y > 1) particle.vy *= -1;
    }
  }
}

class Particle {
  double x, y, vx, vy, size;
  Particle({required this.x, required this.y, required this.vx, required this.vy, required this.size});
}

class ParticlePainter extends CustomPainter {
  final List<Particle> particles;
  final Offset mousePosition;

  ParticlePainter(this.particles, this.mousePosition);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..style = PaintingStyle.fill;

    for (var particle in particles) {
      final px = particle.x * size.width;
      final py = particle.y * size.height;
      final dx = mousePosition.dx - px;
      final dy = mousePosition.dy - py;
      final distance = sqrt(dx * dx + dy * dy);
      final maxDistance = 150.0;

      if (distance < maxDistance) {
        final opacity = (1 - distance / maxDistance) * 0.6;
        paint.color = Color.fromRGBO(99, 102, 241, opacity);
        canvas.drawCircle(Offset(px, py), particle.size * 1.5, paint);
      } else {
        paint.color = const Color.fromRGBO(99, 102, 241, 0.3);
        canvas.drawCircle(Offset(px, py), particle.size, paint);
      }
    }

    // Draw connections
    final linePaint = Paint()..strokeWidth = 0.5;
    for (int i = 0; i < particles.length; i++) {
      for (int j = i + 1; j < particles.length; j++) {
        final p1 = particles[i];
        final p2 = particles[j];
        final dx = (p1.x - p2.x) * size.width;
        final dy = (p1.y - p2.y) * size.height;
        final distance = sqrt(dx * dx + dy * dy);

        if (distance < 120) {
          final opacity = (1 - distance / 120) * 0.2;
          linePaint.color = Color.fromRGBO(99, 102, 241, opacity);
          canvas.drawLine(
            Offset(p1.x * size.width, p1.y * size.height),
            Offset(p2.x * size.width, p2.y * size.height),
            linePaint,
          );
        }
      }
    }
  }

  @override
  bool shouldRepaint(ParticlePainter oldDelegate) => true;
}
