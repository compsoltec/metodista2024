import 'package:http/http.dart' as http;

import '../../../../../core/core.dart';
import '../../domain/domain.dart';
import '../models/models.dart';

class PastoralRepositoryImpl implements PastoralRepository {
  final http.Client client;

  PastoralRepositoryImpl(this.client);

  @override
  Future<Either<String, List<Pastoral>>> getPastorals() async {
    final response = await client.get(Uri.parse('$baseUrl/pastorals'));
    if (response.statusCode == 200) {
      final List data = json.decode(response.body)['data'];
      final pastorals =
          data.map((e) => PastoralModel.fromJson(e).toEntity()).toList();
      return Right(pastorals);
    } else {
      return Left('Erro ao buscar pastorais');
    }
  }

  @override
  Future<Either<String, void>> createPastoral(Pastoral pastoral) async {
    final model = PastoralModel.fromEntity(pastoral);
    final response = await client.post(
      Uri.parse('$baseUrl/pastorals'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'title': model.title,
        'text': model.text,
        'author': model.author,
        'imageUrls': model.imageUrls,
        'date': model.date.toIso8601String(),
      }),
    );

    if (response.statusCode == 201) {
      return const Right(null);
    } else {
      return Left('Erro ao criar pastoral');
    }
  }

  @override
  Future<Either<String, Pastoral>> getPastoralById(String id) async {
    final response = await client.get(Uri.parse('$baseUrl/pastorals/$id'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body)['data'];
      final pastoral = PastoralModel.fromJson(data).toEntity();
      return Right(pastoral);
    } else if (response.statusCode == 404) {
      return Left('Pastoral não encontrada');
    } else {
      return Left('Erro ao buscar pastoral');
    }
  }

  @override
  Future<Either<String, void>> updatePastoral(Pastoral pastoral) async {
    final model = PastoralModel.fromEntity(pastoral);
    final response = await client.put(
      Uri.parse('$baseUrl/pastorals/${model.id}'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'title': model.title,
        'text': model.text,
        'author': model.author,
        'date': model.date.toIso8601String(),
      }),
    );

    if (response.statusCode == 200) {
      return const Right(null);
    } else {
      return Left('Erro ao atualizar pastoral');
    }
  }

  @override
  Future<Either<String, void>> deletePastoral(String id) async {
    final response = await client.delete(Uri.parse('$baseUrl/pastorals/$id'));

    if (response.statusCode == 200) {
      return const Right(null);
    } else if (response.statusCode == 404) {
      return Left('Pastoral não encontrada para deletar');
    } else {
      return Left('Erro ao deletar pastoral');
    }
  }
}
