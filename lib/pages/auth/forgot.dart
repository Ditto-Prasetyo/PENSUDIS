import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ForgotPassword extends StatelessWidget {
  const ForgotPassword({super.key});
  final String adminNumber = "+62 851-6101-5745";

   Future<void> _launchWhatsApp() async {
    final message = "Selamat pagi Admin, saya lupa password akun saya. Mohon bantuannya. Terima kasih.";
    final url = "https://wa.me/$adminNumber?text=${Uri.encodeComponent(message)}";

    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
    } else {
      throw "Tidak bisa membuka WhatsApp.";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerRight,
      padding: const EdgeInsets.symmetric(
        vertical: 25.0,
        horizontal: 30.0,
      ),
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: _launchWhatsApp,
          child: Text(
            "Forgot?",
            style: TextStyle(
              fontSize: 18.0,
              color: Colors.grey[400],
              fontWeight: FontWeight.w700,
              letterSpacing: 2,
            ),
          ),
        ),
      ),
    );
  }
}