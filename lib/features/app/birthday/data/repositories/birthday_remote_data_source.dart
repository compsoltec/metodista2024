import 'package:http/http.dart' as http;

import '../../../../../core/core.dart';
import '../../../app.dart';

class BirthdayRemoteDataSourceImpl implements BirthdayRepository {
  final http.Client client;

  BirthdayRemoteDataSourceImpl(this.client);

  @override
  Future<Either<String, List<Birthday>>> getBirthdays() async {
    try {
      final response = await client.get(Uri.parse('$baseUrl/birthdays'));

      if (response.statusCode == 200) {
        final List data = json.decode(response.body)['data'];
        final birthdays =
            data.map((e) => BirthdayModel.fromJson(e).toEntity()).toList();
        return Right(birthdays);
      } else {
        return Left('Erro ao buscar aniversariantes');
      }
    } catch (e) {
      return Left('Erro de conexão: ${e.toString()}');
    }
  }

  @override
  Future<Either<String, List<Birthday>>> getBirthdaysToday() async {
    try {
      final response = await client.get(Uri.parse('$baseUrl/birthdays/today'));

      if (response.statusCode == 200) {
        final List data = json.decode(response.body)['data'];
        final birthdays =
            data.map((e) => BirthdayModel.fromJson(e).toEntity()).toList();
        return Right(birthdays);
      } else {
        return Left('Erro ao buscar aniversariantes do dia');
      }
    } catch (e) {
      return Left('Erro de conexão: ${e.toString()}');
    }
  }

  @override
  Future<Either<String, void>> createBirthday(Birthday birthday) async {
    try {
      final response = await client.post(
        Uri.parse('$baseUrl/birthdays'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'name': birthday.name,
          'birthDate': birthday.birthDate.toIso8601String(),
        }),
      );

      if (response.statusCode == 201) {
        return Right(null);
      } else {
        return Left('Erro ao criar aniversariante');
      }
    } catch (e) {
      return Left('Erro de conexão: ${e.toString()}');
    }
  }

  @override
  Future<Either<String, void>> deleteBirthday(String id) async {
    try {
      final response = await client.delete(Uri.parse('$baseUrl/birthdays/$id'));

      if (response.statusCode == 200) {
        return Right(null);
      } else {
        return Left('Erro ao deletar aniversariante');
      }
    } catch (e) {
      return Left('Erro de conexão: ${e.toString()}');
    }
  }

  @override
  Future<Either<String, void>> updateBirthday(Birthday birthday) async {
    try {
      final response = await client.put(
        Uri.parse('$baseUrl/birthdays/${birthday.id}'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'name': birthday.name,
          'birthDate': birthday.birthDate.toIso8601String(),
        }),
      );

      if (response.statusCode == 200) {
        return Right(null);
      } else {
        return Left('Erro ao atualizar aniversariante');
      }
    } catch (e) {
      return Left('Erro de conexão: ${e.toString()}');
    }
  }
}
