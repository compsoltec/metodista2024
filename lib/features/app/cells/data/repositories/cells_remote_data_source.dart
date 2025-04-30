import 'package:http/http.dart' as http;

import '../../../../../core/core.dart';
import '../../cells.dart';

class CellsRemoteDataSourceImpl implements CellsRepository {
  final http.Client client;

  CellsRemoteDataSourceImpl(this.client);

  @override
  Future<Either<String, List<Cells>>> getCells() async {
    try {
      final response = await client.get(Uri.parse('$baseUrl/cells'));

      if (response.statusCode == 200) {
        final List data = json.decode(response.body)['data'];

        final cells =
            data.map((e) => CellsModel.fromJson(e).toEntity()).toList();
        return Right(cells);
      } else {
        return Left('Erro ao buscar cursos');
      }
    } catch (e) {
      return Left('Erro de conexão: ${e.toString()}');
    }
  }

  @override
  Future<Either<String, List<Cells>>> getCellsToday() async {
    try {
      final response = await client.get(Uri.parse('$baseUrl/cells/today'));

      if (response.statusCode == 200) {
        final List data = json.decode(response.body)['data'];
        final cells =
            data.map((e) => CellsModel.fromJson(e).toEntity()).toList();
        return Right(cells);
      } else {
        return Left('Erro ao buscar cursos do dia');
      }
    } catch (e) {
      return Left('Erro de conexão: ${e.toString()}');
    }
  }

  @override
  Future<Either<String, void>> createCells(Cells cells) async {
    try {
      final response = await client.post(
        Uri.parse('$baseUrl/cells'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'name': cells.name,
          'course': cells.course,
          'image': cells.image,
          'inscricoes': cells.inscricoes,
          'phone': cells.phone,
        }),
      );

      if (response.statusCode == 201) {
        return Right(null);
      } else {
        return Left('Erro ao criar cells');
      }
    } catch (e) {
      return Left('Erro de conexão: ${e.toString()}');
    }
  }

  @override
  Future<Either<String, void>> deleteCells(String id) async {
    try {
      final response = await client.delete(Uri.parse('$baseUrl/cells/$id'));

      if (response.statusCode == 200) {
        return Right(null);
      } else {
        return Left('Erro ao deletar cells');
      }
    } catch (e) {
      return Left('Erro de conexão: ${e.toString()}');
    }
  }

  @override
  Future<Either<String, void>> updateCells(Cells cells) async {
    try {
      final response = await client.put(
        Uri.parse('$baseUrl/cells/${cells.id}'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'name': cells.name,
          'course': cells.course,
          'image': cells.image,
          'inscricoes': cells.inscricoes
        }),
      );

      if (response.statusCode == 200) {
        return Right(null);
      } else {
        return Left('Erro ao atualizar cells');
      }
    } catch (e) {
      return Left('Erro de conexão: ${e.toString()}');
    }
  }
}
