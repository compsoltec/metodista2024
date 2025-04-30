import 'package:flutter/material.dart';

import '../../../../core/core.dart';
import 'bible_verses.dart';

class BibleChaptersScreen extends StatelessWidget {
  final String abbrev;
  final String name;
  final int totalChapters;

  const BibleChaptersScreen({
    super.key,
    required this.abbrev,
    required this.name,
    required this.totalChapters,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(name, style: const TextStyle(color: Colors.white)),
        backgroundColor: AppColors.primaryColor,
        centerTitle: true,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
          ),
          itemCount: totalChapters,
          itemBuilder: (context, index) {
            final chapter = index + 1;
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => BibleVersesScreen(
                      abbrev: abbrev,
                      chapter: chapter,
                      bookName: name,
                    ),
                  ),
                );
              },
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.cardColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: Text(
                    chapter.toString(),
                    style: const TextStyle(
                      color: AppColors.textPrimary,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
