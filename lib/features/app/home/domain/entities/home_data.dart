import '../../../../../core/core.dart';

class HomeData extends Equatable {
  final String pastoral;
  final List<String> programacao;
  final List<String> aniversariantes;
  final List<String> devocional;

  const HomeData({
    required this.pastoral,
    required this.programacao,
    required this.aniversariantes,
    required this.devocional,
  });

  @override
  List<Object?> get props => [
        pastoral,
        programacao,
        aniversariantes,
        devocional,
      ];
}
