import 'package:http/http.dart' as http;
import 'dart:convert';

/// Email service for sending emails via EmailJS
class EmailService {
  // EmailJS Configuration
  // Get these from https://www.emailjs.com/
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
        print('Email send failed: ${response.statusCode}');
        print('Response: ${response.body}');
        return false;
      }
    } catch (e) {
      print('Error sending email: $e');
      return false;
    }
  }

  /// Alternative: Send email via Formspree
  static Future<bool> sendEmailViaFormspree({
    required String senderName,
    required String senderEmail,
    required String subject,
    required String message,
  }) async {
    try {
      // Get your form ID from https://formspree.io/
      const String formId = 'YOUR_FORMSPREE_ID';
      final response = await http.post(
        Uri.parse('https://formspree.io/f/$formId'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'name': senderName,
          'email': senderEmail,
          'subject': subject,
          'message': message,
        }),
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        print('Email send failed: ${response.statusCode}');
        return false;
      }
    } catch (e) {
      print('Error sending email: $e');
      return false;
    }
  }

  /// Alternative: Send email via custom backend
  static Future<bool> sendEmailViaBackend({
    required String senderName,
    required String senderEmail,
    required String subject,
    required String message,
    required String recipientEmail,
  }) async {
    try {
      // Replace with your backend URL
      const String backendUrl = 'https://your-backend.com/api/send-email';
      
      final response = await http.post(
        Uri.parse(backendUrl),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'senderName': senderName,
          'senderEmail': senderEmail,
          'subject': subject,
          'message': message,
          'recipientEmail': recipientEmail,
        }),
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        print('Email send failed: ${response.statusCode}');
        return false;
      }
    } catch (e) {
      print('Error sending email: $e');
      return false;
    }
  }
}
