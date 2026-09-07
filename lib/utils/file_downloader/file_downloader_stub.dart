import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// Fallback / Mobile / Desktop implementation for file downloading
Future<void> downloadFile(String assetPath, String fileName) async {
  Get.snackbar(
    'Resume Available',
    'Resume document ($fileName) is included in assets.',
    snackPosition: SnackPosition.BOTTOM,
    backgroundColor: const Color(0xFF1E293B),
    colorText: Colors.white,
    margin: const EdgeInsets.all(16),
    duration: const Duration(seconds: 3),
    icon: const Icon(Icons.description, color: Color(0xFF6C63FF)),
  );
}
