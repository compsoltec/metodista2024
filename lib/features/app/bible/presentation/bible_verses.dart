import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../../../core/core.dart';

class BibleVersesScreen extends StatefulWidget {
  final String abbrev;
  final int chapter;
  final String bookName;

  const BibleVersesScreen({
    super.key,
    required this.abbrev,
    required this.chapter,
    required this.bookName,
  });

  @override
  State<BibleVersesScreen> createState() => _BibleVersesScreenState();
}

class _BibleVersesScreenState extends State<BibleVersesScreen> {
  List<dynamic> verses = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchVerses();
  }

  Future<void> fetchVerses() async {
    final url =
        'https://www.abibliadigital.com.br/api/verses/nvi/${widget.abbrev}/${widget.chapter}';
    final response = await http.get(
      Uri.parse(url),
      headers: {
        'Authorization':
            'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdHIiOiJUdWUgQXByIDI5IDIwMjUgMTc6MDI6NDQgR01UKzAwMDAucXVlbGxlbl9yb2RyaWd1ZXNAaG90bWFpbC5jb20iLCJpYXQiOjE3NDU5NDYxNjR9.SrBpguOmC2obLdJhFLo1qf-PulAUzloERNDQCd34eyQ'
      }, // Se tiver
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        verses = data['verses'];
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Text('${widget.bookName} ${widget.chapter}',
            style: const TextStyle(color: Colors.white)),
        backgroundColor: AppColors.primaryColor,
        centerTitle: true,
        elevation: 0,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: verses.length,
              itemBuilder: (context, index) {
                final verse = verses[index];
                return Card(
                  color: AppColors.cardColor,
                  margin: const EdgeInsets.only(bottom: 12),
                  child: ListTile(
                    title: Text(
                      '${verse['number']}. ${verse['text']}',
                      style: const TextStyle(
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
