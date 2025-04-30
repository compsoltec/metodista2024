import 'package:http/http.dart' as http;

import '../../../../../core/core.dart';
import '../../notices.dart';

class NoticesRemoteDataSourceImpl implements NoticesRepository {
  final http.Client client;

  NoticesRemoteDataSourceImpl(this.client);

  @override
  Future<Either<String, List<Notices>>> getNotices() async {
    try {
      final response = await client.get(Uri.parse('$baseUrl/notices'));

      if (response.statusCode == 200) {
        final List data = json.decode(response.body)['data'];
        final notices =
            data.map((e) => NoticesModel.fromJson(e).toEntity()).toList();
        return Right(notices);
      } else {
        return Left('Erro ao buscar cursos');
      }
    } catch (e) {
      return Left('Erro de conexão: ${e.toString()}');
    }
  }

  @override
  Future<Either<String, List<Notices>>> getNoticesToday() async {
    try {
      final response = await client.get(Uri.parse('$baseUrl/notices/today'));

      if (response.statusCode == 200) {
        final List data = json.decode(response.body)['data'];
        final notices =
            data.map((e) => NoticesModel.fromJson(e).toEntity()).toList();
        return Right(notices);
      } else {
        return Left('Erro ao buscar cursos do dia');
      }
    } catch (e) {
      return Left('Erro de conexão: ${e.toString()}');
    }
  }

  @override
  Future<Either<String, void>> createNotices(Notices notices) async {
    try {
      final response = await client.post(
        Uri.parse('$baseUrl/notices'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'name': notices.name,
          'description': notices.description,
          'image': notices.image,
        }),
      );

      if (response.statusCode == 201) {
        return Right(null);
      } else {
        return Left('Erro ao criar notices');
      }
    } catch (e) {
      return Left('Erro de conexão: ${e.toString()}');
    }
  }

  @override
  Future<Either<String, void>> deleteNotices(String id) async {
    try {
      final response = await client.delete(Uri.parse('$baseUrl/notices/$id'));

      if (response.statusCode == 200) {
        return Right(null);
      } else {
        return Left('Erro ao deletar notices');
      }
    } catch (e) {
      return Left('Erro de conexão: ${e.toString()}');
    }
  }

  @override
  Future<Either<String, void>> updateNotices(Notices notices) async {
    try {
      final response = await client.put(
        Uri.parse('$baseUrl/notices/${notices.id}'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'name': notices.name,
          'description': notices.description,
          'image': notices.image,
        }),
      );

      if (response.statusCode == 200) {
        return Right(null);
      } else {
        return Left('Erro ao atualizar notices');
      }
    } catch (e) {
      return Left('Erro de conexão: ${e.toString()}');
    }
  }
}
