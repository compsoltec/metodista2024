import '../../domain/domain.dart';

class DocumentosResponseEntityMapper {
  static DocumentosResponse fromMap({required Map<String, dynamic> map}) {
    return DocumentosResponse(
      message: map['message'],
      status: map['status'],
    );
  }
}
