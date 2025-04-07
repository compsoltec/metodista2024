import '../../domain/entities/entities.dart';

class AtividadeRequestEntityMapper {
  static Map<String, dynamic> toMap({required AtividadeRequestEntity entity}) {
    return {
      'data': entity.data,
      'foto': entity.foto,
      'descricao': entity.descricao,
      'titulo': entity.titulo,
      'vagas': entity.vagas
    };
  }
}

class InscritostEntityMapper {
  static Map<String, dynamic> toMap({required InscritosRequestEntity entity}) {
    return {
      'nome': entity.nome,
      'telefone': entity.telefone,
      'token': entity.token,
      'idAtividade': entity.idAtividade
    };
  }
}
