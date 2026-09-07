import 'dart:async';
import 'package:flutter/material.dart';
import '../utils/app_colors.dart';

/// A dynamic typewriter text animation widget that loops through a list of phrases
/// with smooth typing cadence and glowing pulsing cursor.
class TypewriterText extends StatefulWidget {
  final List<String> texts;
  final TextStyle textStyle;
  final Duration typingSpeed;
  final Duration deletingSpeed;
  final Duration pauseDuration;
  final bool showCursor;
  final Gradient? gradient;

  const TypewriterText({
    super.key,
    required this.texts,
    required this.textStyle,
    this.typingSpeed = const Duration(milliseconds: 70),
    this.deletingSpeed = const Duration(milliseconds: 40),
    this.pauseDuration = const Duration(milliseconds: 2000),
    this.showCursor = true,
    this.gradient,
  });

  @override
  State<TypewriterText> createState() => _TypewriterTextState();
}

class _TypewriterTextState extends State<TypewriterText>
    with SingleTickerProviderStateMixin {
  int _currentTextIndex = 0;
  String _displayedText = '';
  bool _isDeleting = false;
  Timer? _timer;

  late AnimationController _cursorController;
  late Animation<double> _cursorAnimation;

  @override
  void initState() {
    super.initState();
    _cursorController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    )..repeat(reverse: true);

    _cursorAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _cursorController, curve: Curves.easeInOut),
    );

    _startTyping();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _cursorController.dispose();
    super.dispose();
  }

  void _startTyping() {
    if (widget.texts.isEmpty) return;
    final currentFullText = widget.texts[_currentTextIndex];

    if (_isDeleting) {
      if (_displayedText.isNotEmpty) {
        _displayedText = _displayedText.substring(0, _displayedText.length - 1);
        setState(() {});
        _timer = Timer(widget.deletingSpeed, _startTyping);
      } else {
        _isDeleting = false;
        _currentTextIndex = (_currentTextIndex + 1) % widget.texts.length;
        _timer = Timer(const Duration(milliseconds: 300), _startTyping);
      }
    } else {
      if (_displayedText.length < currentFullText.length) {
        _displayedText =
            currentFullText.substring(0, _displayedText.length + 1);
        setState(() {});
        _timer = Timer(widget.typingSpeed, _startTyping);
      } else {
        _isDeleting = true;
        _timer = Timer(widget.pauseDuration, _startTyping);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget textWidget = Text(
      _displayedText.isEmpty ? ' ' : _displayedText,
      style: widget.textStyle,
    );

    if (widget.gradient != null) {
      textWidget = ShaderMask(
        shaderCallback: (bounds) => widget.gradient!.createShader(bounds),
        child: Text(
          _displayedText.isEmpty ? ' ' : _displayedText,
          style: widget.textStyle.copyWith(color: Colors.white),
        ),
      );
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        textWidget,
        if (widget.showCursor) ...[
          const SizedBox(width: 4),
          FadeTransition(
            opacity: _cursorAnimation,
            child: Container(
              width: 3,
              height: (widget.textStyle.fontSize ?? 20) * 1.1,
              decoration: BoxDecoration(
                color: AppColors.accentCyan,
                borderRadius: BorderRadius.circular(2),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.accentCyan.withValues(alpha: 0.8),
                    blurRadius: 8,
                    spreadRadius: 1,
                  ),
                ],
              ),
            ),
          ),
        ],
      ],
    );
  }
}
