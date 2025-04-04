import '../../../../core/core.dart';
import '../../domain/domain.dart';

class HomeRepositoryImpl implements HomeRepository {
  @override
  Future<Either<Failure, HomeData>> getHomeData() async {
    try {
      // Implement data fetching logic
      return Right(HomeData(
        pastoral: 'Exemplo de pastoral',
        programacao: ['Programa 1', 'Programa 2'],
        aniversariantes: ['Pessoa 1', 'Pessoa 2'],
        devocional: ['Devocional 1', 'Devocional 2'],
      ));
    } catch (e) {
      return Left(ServerFailure());
    }
  }
}
