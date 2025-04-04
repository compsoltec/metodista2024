import 'package:flutter/material.dart';

import '../../../../core/core.dart';

class SocialMediaButtons extends StatelessWidget {
  const SocialMediaButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          _SocialButton(
            icon: 'assets/icons/whatsapp.png',
            url: 'https://wa.me/5524999868778',
          ),
          const SizedBox(width: 12),
          _SocialButton(
            icon: 'assets/icons/facebook.png',
            url: 'https://www.facebook.com/igrejametodistajdbelvedere/',
          ),
          const SizedBox(width: 12),
          _SocialButton(
            icon: 'assets/icons/instagram.png',
            url: 'https://www.instagram.com/metodistajardimbelvedere/',
          ),
        ],
      ),
    );
  }
}

class _SocialButton extends StatelessWidget {
  final String icon;
  final String url;

  const _SocialButton({
    required this.icon,
    required this.url,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 4,
      shape: const CircleBorder(),
      clipBehavior: Clip.antiAlias,
      color: Colors.white,
      child: InkWell(
        onTap: () => _launchUrl(url),
        child: Container(
          padding: const EdgeInsets.all(12),
          width: 45,
          height: 45,
          child: Image.asset(
            icon,
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }

  Future<void> _launchUrl(String urlString) async {
    final Uri url = Uri.parse(urlString);
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }
}
