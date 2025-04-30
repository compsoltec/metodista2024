import 'dart:convert';

import 'package:http/http.dart' as http;

class BibleRepository {
  final String _baseUrl = 'https://www.abibliadigital.com.br/api';
  final String _email = 'quellen_rodrigues@hotmail.com';
  String _token =
      'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdHIiOiJUdWUgQXByIDI5IDIwMjUgMTc6MDI6NDQgR01UKzAwMDAucXVlbGxlbl9yb2RyaWd1ZXNAaG90bWFpbC5jb20iLCJpYXQiOjE3NDU5NDYxNjR9.SrBpguOmC2obLdJhFLo1qf-PulAUzloERNDQCd34eyQ'; // token inicial

  Future<http.Response> _get(Uri uri) async {
    final response = await http.get(uri, headers: {
      'Authorization': _token,
      'Content-Type': 'application/json',
    });

    if (response.statusCode == 403) {
      await _refreshToken();
      return await http.get(uri, headers: {
        'Authorization': _token,
        'Content-Type': 'application/json',
      });
    }

    return response;
  }

  Future<void> _refreshToken() async {
    final response = await http.get(
      Uri.parse('$_baseUrl/users/$_email'),
      headers: {'Authorization': _token},
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      _token = 'Bearer ${data['token']}';
    }
  }

  Future<List<dynamic>> getBooks() async {
    final uri = Uri.parse('$_baseUrl/books');
    final response = await _get(uri);

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Erro ao carregar livros');
    }
  }

  Future<List<dynamic>> getChapter(String abbrev, int chapter) async {
    final uri = Uri.parse('$_baseUrl/verses/nvi/$abbrev/$chapter');
    final response = await _get(uri);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['verses'];
    } else {
      throw Exception('Erro ao carregar capítulo');
    }
  }

  Future<String> searchVerse(String query) async {
    final uri = Uri.parse('$_baseUrl/verses/search');
    final response = await http.post(
      uri,
      headers: {
        'Authorization': _token,
        'Content-Type': 'application/json',
      },
      body: json.encode({'version': 'nvi', 'search': query}),
    );

    if (response.statusCode == 403) {
      await _refreshToken();
      return searchVerse(query); // recursivo após novo token
    }

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if ((data['verses'] as List).isNotEmpty) {
        final first = data['verses'].first;
        return '${first['book']['name']} ${first['chapter']}:${first['number']} - ${first['text']}';
      } else {
        return 'Nenhum versículo encontrado.';
      }
    } else {
      throw Exception('Erro ao buscar versículo');
    }
  }
}
