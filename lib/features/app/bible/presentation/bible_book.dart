import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../../../core/core.dart';
import '../../app.dart';

class BibleBooksScreen extends StatefulWidget {
  const BibleBooksScreen({super.key});

  @override
  State<BibleBooksScreen> createState() => _BibleBooksScreenState();
}

class _BibleBooksScreenState extends State<BibleBooksScreen> {
  List<dynamic> books = [];
  List<dynamic> filteredBooks = [];
  bool isLoading = true;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchBooks();
    _searchController.addListener(() {
      filterBooks();
    });
  }

  Future<void> fetchBooks() async {
    final response = await http.get(
      Uri.parse('https://www.abibliadigital.com.br/api/books'),
      headers: {
        'Authorization':
            'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdHIiOiJUdWUgQXByIDI5IDIwMjUgMTc6MDI6NDQgR01UKzAwMDAucXVlbGxlbl9yb2RyaWd1ZXNAaG90bWFpbC5jb20iLCJpYXQiOjE3NDU5NDYxNjR9.SrBpguOmC2obLdJhFLo1qf-PulAUzloERNDQCd34eyQ'
      }, // Se tiver
    );

    if (response.statusCode == 200) {
      setState(() {
        books = jsonDecode(response.body);
        filteredBooks = books;
        isLoading = false;
      });
    }
  }

  void filterBooks() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      filteredBooks = books.where((book) {
        final name = book['name'].toLowerCase();
        return name.contains(query);
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: const Text('Bíblia', style: TextStyle(color: Colors.white)),
        backgroundColor: AppColors.primaryColor,
        centerTitle: true,
        elevation: 0,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  TextField(
                    controller: _searchController,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: 'Pesquisar livro...',
                      hintStyle: TextStyle(color: Colors.white70),
                      prefixIcon:
                          const Icon(Icons.search, color: Colors.white70),
                      filled: true,
                      fillColor: AppColors.sage,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Expanded(
                    child: ListView.builder(
                      itemCount: filteredBooks.length,
                      itemBuilder: (context, index) {
                        final book = filteredBooks[index];
                        return Card(
                          color: AppColors.cardColor,
                          child: ListTile(
                            title: Text(
                              book['name'],
                              style: const TextStyle(
                                color: AppColors.textPrimary,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Text(
                              '${book['chapters']} capítulos',
                              style: TextStyle(color: AppColors.textSecondary),
                            ),
                            trailing: const Icon(Icons.arrow_forward_ios,
                                color: AppColors.sage),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => BibleChaptersScreen(
                                    abbrev: book['abbrev']['pt'],
                                    name: book['name'],
                                    totalChapters: book['chapters'],
                                  ),
                                ),
                              );
                            },
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
