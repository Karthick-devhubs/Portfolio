import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

/// Email service for sending emails via EmailJS
class EmailService {
  // EmailJS Configuration
  static const String serviceId = 'service_hch0nbd';
  static const String templateId = 'template_eqqt83f';
  static const String publicKey = 'HpKwgpbcol8x_y4HS';
  static const String apiUrl = 'https://api.emailjs.com/api/v1.0/email/send';

  /// Send email via EmailJS
  static Future<bool> sendEmail({
    required String senderName,
    required String senderEmail,
    required String subject,
    required String message,
  }) async {
    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'service_id': serviceId,
          'template_id': templateId,
          'user_id': publicKey,
          'template_params': {
            'name': senderName,
            'email': senderEmail,
            'title': subject,
            'message': message,
          },
        }),
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        debugPrint('Email send failed: ${response.statusCode} | ${response.body}');
        return false;
      }
    } catch (e) {
      debugPrint('Error sending email: $e');
      return false;
    }
  }
}
