import '../../domain/domain.dart';

class AtividadeEntityMapper {
  static AtividadeEntity fromMap({required Map<String, dynamic> map}) {
    return AtividadeEntity(
        data: map['data'],
        descricao: map['descricao'],
        foto: map['foto'],
        titulo: map['titulo'],
        id: map['id'],
        vagas: map['vagas']);
  }
}

class InscricaoEntityMapper {
  static InscritosRequestEntity fromMap({required Map<String, dynamic> map}) {
    return InscritosRequestEntity(
      nome: map['nome'],
      telefone: map['telefone'],
      token: map['token'],
      idAtividade: map['idAtividade'],
      id: map['id'],
    );
  }
}
