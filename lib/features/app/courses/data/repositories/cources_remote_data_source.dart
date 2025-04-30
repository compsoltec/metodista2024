import 'package:http/http.dart' as http;

import '../../../../../core/core.dart';
import '../../cources.dart';

class CourcesRemoteDataSourceImpl implements CourcesRepository {
  final http.Client client;

  CourcesRemoteDataSourceImpl(this.client);

  @override
  Future<Either<String, List<Cources>>> getCources() async {
    try {
      final response = await client.get(Uri.parse('$baseUrl/cources'));

      if (response.statusCode == 200) {
        final List data = json.decode(response.body)['data'];

        final cources =
            data.map((e) => CourcesModel.fromJson(e).toEntity()).toList();
        return Right(cources);
      } else {
        return Left('Erro ao buscar cursos');
      }
    } catch (e) {
      return Left('Erro de conexão: ${e.toString()}');
    }
  }

  @override
  Future<Either<String, List<Cources>>> getCourcesToday() async {
    try {
      final response = await client.get(Uri.parse('$baseUrl/cources/today'));

      if (response.statusCode == 200) {
        final List data = json.decode(response.body)['data'];
        final cources =
            data.map((e) => CourcesModel.fromJson(e).toEntity()).toList();
        return Right(cources);
      } else {
        return Left('Erro ao buscar cursos do dia');
      }
    } catch (e) {
      return Left('Erro de conexão: ${e.toString()}');
    }
  }

  @override
  Future<Either<String, void>> createCources(Cources cources) async {
    try {
      final response = await client.post(
        Uri.parse('$baseUrl/cources'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'name': cources.name,
          'course': cources.course,
          'image': cources.image,
          'inscricoes': cources.inscricoes,
          'phone': cources.phone,
        }),
      );

      if (response.statusCode == 201) {
        return Right(null);
      } else {
        return Left('Erro ao criar cources');
      }
    } catch (e) {
      return Left('Erro de conexão: ${e.toString()}');
    }
  }

  @override
  Future<Either<String, void>> deleteCources(String id) async {
    try {
      final response = await client.delete(Uri.parse('$baseUrl/cources/$id'));

      if (response.statusCode == 200) {
        return Right(null);
      } else {
        return Left('Erro ao deletar cources');
      }
    } catch (e) {
      return Left('Erro de conexão: ${e.toString()}');
    }
  }

  @override
  Future<Either<String, void>> updateCources(Cources cources) async {
    try {
      final response = await client.put(
        Uri.parse('$baseUrl/cources/${cources.id}'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'name': cources.name,
          'course': cources.course,
          'image': cources.image,
          'inscricoes': cources.inscricoes
        }),
      );

      if (response.statusCode == 200) {
        return Right(null);
      } else {
        return Left('Erro ao atualizar cources');
      }
    } catch (e) {
      return Left('Erro de conexão: ${e.toString()}');
    }
  }
}
