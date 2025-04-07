
import '../../../modulo_common_services/modulo_common_services.dart';

abstract class DocumentosFailure extends FailureCubit {
  DocumentosFailure({
    String errorMessage = '',
    StackTrace? stackTrace,
    String? label,
  }) : super(
          errorMessage: errorMessage,
          stackTrace: stackTrace,
          label: label,
        );
}

class DataSourceDocumentosFailure extends DocumentosFailure {
  DataSourceDocumentosFailure({
    required String errorMessage,
    StackTrace? stackTrace,
    String? label,
  }) : super(
          errorMessage: errorMessage,
          stackTrace: stackTrace,
          label: label,
        );
}

class NoInternetDocumentosFailure extends DocumentosFailure {
  NoInternetDocumentosFailure({
    String errorMessage = 'Você esta sem internet, tente novamente.',
    StackTrace? stackTrace,
    String? label,
  }) : super(
          errorMessage: errorMessage,
          stackTrace: stackTrace,
          label: label,
        );
}

class UnknownDocumentosFailure extends DocumentosFailure {
  UnknownDocumentosFailure({
    String errorMessage = 'Ocorreu um erro inesperado, tente novamente.',
    StackTrace? stackTrace,
    String? label,
  }) : super(
          errorMessage: errorMessage,
          stackTrace: stackTrace,
          label: label,
        );
}

class InvalidCredentialsDocumentosFailure extends DocumentosFailure {
  InvalidCredentialsDocumentosFailure({
    String errorMessage = 'Credenciais invalidas, tente novamente.',
    StackTrace? stackTrace,
    String? label,
  }) : super(
          errorMessage: errorMessage,
          stackTrace: stackTrace,
          label: label,
        );
}
