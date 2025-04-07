import '../../domain/domain.dart';

class AtividadeResponseEntityMapper {
  static AtividadeResponse fromMap({required Map<String, dynamic> map}) {
    return AtividadeResponse(
      message: map['message'],
      status: map['status'],
    );
  }
}
