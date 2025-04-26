import 'package:http/http.dart' as http;

import '../../../../../core/core.dart';
import '../../domain/entities/devotional.dart';
import '../../domain/repositories/devotional_repository.dart';

class DevotionalRepositoryImpl implements DevotionalRepository {
  final http.Client client;

  DevotionalRepositoryImpl(this.client);

  @override
  Future<Either<Failure, List<Devotional>>> getDevotionals() async {
    try {
      final response = await client.get(Uri.parse('$baseUrl/devotionals'));
      if (response.statusCode == 200) {
        final List data = json.decode(response.body)['data'];
        final devotionals = data.map((e) => Devotional.fromJson(e)).toList();
        return Right(devotionals);
      } else {
        return Left(ServerFailure('Erro ao buscar devocionais'));
      }
    } catch (e) {
      return Left(ServerFailure('Erro inesperado: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, void>> createDevotional(Devotional devotional) async {
    try {
      final response = await client.post(
        Uri.parse('$baseUrl/devotionals'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(devotional.toJson()),
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
  Future<Either<Failure, void>> deleteDevotional(String id) async {
    try {
      final response =
          await client.delete(Uri.parse('$baseUrl/devotionals/$id'));
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
