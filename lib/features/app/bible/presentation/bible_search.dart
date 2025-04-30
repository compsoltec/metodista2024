import 'package:flutter/material.dart';

import '../data/repositories/bible_repository.dart';

class SearchVersePage extends StatefulWidget {
  const SearchVersePage({super.key});

  @override
  State<SearchVersePage> createState() => _SearchVersePageState();
}

class _SearchVersePageState extends State<SearchVersePage> {
  final TextEditingController _controller = TextEditingController();
  final BibleRepository repository = BibleRepository();
  String? verse;
  bool isLoading = false;

  void _search() async {
    setState(() => isLoading = true);
    try {
      final result = await repository.searchVerse(_controller.text);
      setState(() {
        verse = result;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        verse = 'Erro ao buscar versículo';
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF2E1A47),
      appBar: AppBar(
        backgroundColor: const Color(0xFF2E1A47),
        title: const Text('Buscar Versículo',
            style: TextStyle(color: Colors.white)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                hintText: 'Ex: João 3:16',
                hintStyle: TextStyle(color: Colors.white54),
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFFC99058))),
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFFC99058))),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _search,
              style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFC99058)),
              child:
                  const Text('Buscar', style: TextStyle(color: Colors.white)),
            ),
            const SizedBox(height: 20),
            if (isLoading)
              const CircularProgressIndicator(color: Color(0xFFC99058))
            else if (verse != null)
              Text(verse!,
                  style: const TextStyle(color: Colors.white, fontSize: 16)),
          ],
        ),
      ),
    );
  }
}
