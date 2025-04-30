import 'package:http/http.dart' as http;

import '../../../../../core/core.dart';
import '../../domain/entities/preaching.dart';
import '../../domain/repositories/preaching_repository.dart';

class PreachingRepositoryImpl implements PreachingRepository {
  final http.Client client;

  PreachingRepositoryImpl(this.client);

  @override
  Future<Either<Failure, List<Preaching>>> getPreachings() async {
    try {
      final response = await client.get(Uri.parse('$baseUrl/preaching'));
      if (response.statusCode == 200) {
        final List data = json.decode(response.body)['data'];
        final preaching = data.map((e) => Preaching.fromJson(e)).toList();
        return Right(preaching);
      } else {
        return Left(ServerFailure('Erro ao buscar devocionais'));
      }
    } catch (e) {
      return Left(ServerFailure('Erro inesperado: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, void>> createPreaching(Preaching preaching) async {
    try {
      final response = await client.post(
        Uri.parse('$baseUrl/preaching'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(preaching.toJson()),
      );
      if (response.statusCode == 201) {
        return const Right(null);
      } else {
        return Left(ServerFailure('Erro ao criar devocional'));
      }
    } catch (e) {
      return Left(ServerFailure('Erro inesperado: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, void>> deletePreaching(String id) async {
    try {
      final response = await client.delete(Uri.parse('$baseUrl/preaching/$id'));
      if (response.statusCode == 200) {
        return const Right(null);
      } else {
        return Left(ServerFailure('Erro ao deletar devocional'));
      }
    } catch (e) {
      return Left(ServerFailure('Erro inesperado: ${e.toString()}'));
    }
  }
}
