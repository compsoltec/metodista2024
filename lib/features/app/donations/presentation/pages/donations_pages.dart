import 'package:flutter/material.dart';

import '../../../../../core/core.dart';

class DonationsPage extends StatelessWidget {
  const DonationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Donations'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Make a Donation via PIX',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: AppColors.copper,
              ),
            ),
            const SizedBox(height: 20),
            // PIX QR Code placeholder
            Container(
              width: double.infinity,
              height: 300,
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.copper),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Center(
                child: Text('PIX QR Code'),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Handle copy PIX key
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.copper,
                minimumSize: const Size(double.infinity, 50),
              ),
              child: const Text('Copy PIX Key'),
            ),
          ],
        ),
      ),
    );
  }
}
