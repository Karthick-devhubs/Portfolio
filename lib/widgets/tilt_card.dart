import 'dart:math';
import 'package:flutter/material.dart';
import '../utils/app_colors.dart';

/// A 3D perspective tilt card that dynamically rotates in 3D space
/// based on mouse/pointer position and renders a smooth specular glare beam.
class TiltCard extends StatefulWidget {
  final Widget child;
  final double maxTiltAngle;
  final double borderRadius;
  final VoidCallback? onTap;
  final bool enableGlare;
  final EdgeInsetsGeometry padding;

  const TiltCard({
    super.key,
    required this.child,
    this.maxTiltAngle = 10.0,
    this.borderRadius = 16.0,
    this.onTap,
    this.enableGlare = true,
    this.padding = EdgeInsets.zero,
  });

  @override
  State<TiltCard> createState() => _TiltCardState();
}

class _TiltCardState extends State<TiltCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _resetController;
  late Animation<Offset> _resetAnimation;

  Offset _pointerPosition = Offset.zero;
  bool _isHovered = false;
  Size _cardSize = Size.zero;

  @override
  void initState() {
    super.initState();
    _resetController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 350),
    );

    _resetAnimation = Tween<Offset>(
      begin: Offset.zero,
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _resetController,
        curve: Curves.easeOutCubic,
      ),
    );

    _resetController.addListener(() {
      setState(() {
        _pointerPosition = _resetAnimation.value;
      });
    });
  }

  @override
  void dispose() {
    _resetController.dispose();
    super.dispose();
  }

  void _onPointerMove(PointerEvent event) {
    if (_cardSize == Size.zero) return;
    _resetController.stop();

    // Normalized coordinates (-1 to 1) from center
    final centerX = _cardSize.width / 2;
    final centerY = _cardSize.height / 2;
    final normalizedX = (event.localPosition.dx - centerX) / centerX;
    final normalizedY = (event.localPosition.dy - centerY) / centerY;

    setState(() {
      _pointerPosition = Offset(
        normalizedX.clamp(-1.0, 1.0),
        normalizedY.clamp(-1.0, 1.0),
      );
    });
  }

  void _onPointerExit(PointerEvent event) {
    setState(() => _isHovered = false);
    _resetAnimation = Tween<Offset>(
      begin: _pointerPosition,
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _resetController,
        curve: Curves.easeOutCubic,
      ),
    );
    _resetController.forward(from: 0.0);
  }

  @override
  Widget build(BuildContext context) {
    final tiltX = -_pointerPosition.dy * (widget.maxTiltAngle * pi / 180);
    final tiltY = _pointerPosition.dx * (widget.maxTiltAngle * pi / 180);

    // 3D Transform Matrix with perspective projection
    final s = _isHovered ? 1.02 : 1.0;
    final transform = Matrix4.identity()
      ..setEntry(3, 2, 0.0012)
      ..rotateX(tiltX)
      ..rotateY(tiltY)
      ..scaleByDouble(s, s, s, 1.0);

    return LayoutBuilder(
      builder: (context, constraints) {
        return MouseRegion(
          onEnter: (event) {
            setState(() => _isHovered = true);
          },
          onHover: (event) {
            final renderBox = context.findRenderObject() as RenderBox?;
            if (renderBox != null) {
              _cardSize = renderBox.size;
            }
          },
          onExit: _onPointerExit,
          child: Listener(
            onPointerMove: _onPointerMove,
            child: GestureDetector(
              onTap: widget.onTap,
              child: Padding(
                padding: widget.padding,
                child: Transform(
                  transform: transform,
                  alignment: FractionalOffset.center,
                  child: Stack(
                    children: [
                      widget.child,
                      // Specular Lighting / Glare layer
                      if (widget.enableGlare && _isHovered)
                        Positioned.fill(
                          child: IgnorePointer(
                            child: ClipRRect(
                              borderRadius:
                                  BorderRadius.circular(widget.borderRadius),
                              child: CustomPaint(
                                painter: _GlarePainter(
                                  pointerPos: _pointerPosition,
                                ),
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class _GlarePainter extends CustomPainter {
  final Offset pointerPos;

  _GlarePainter({required this.pointerPos});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..shader = RadialGradient(
        center: Alignment(pointerPos.dx, pointerPos.dy),
        radius: 0.8,
        colors: [
          Colors.white.withValues(alpha: 0.16),
          AppColors.secondary.withValues(alpha: 0.08),
          Colors.transparent,
        ],
        stops: const [0.0, 0.45, 1.0],
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));

    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), paint);
  }

  @override
  bool shouldRepaint(_GlarePainter oldDelegate) =>
      oldDelegate.pointerPos != pointerPos;
}
