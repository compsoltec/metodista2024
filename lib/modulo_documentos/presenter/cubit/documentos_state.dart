import 'package:flutter/foundation.dart';
import '../../domain/domain.dart';

abstract class DocumentosState {}

class DocumentosInitialState extends DocumentosState {}

class DocumentosLoadingState extends DocumentosState {}

class DocumentosSuccessState extends DocumentosState {
  final DocumentosResponse user;

  DocumentosSuccessState({required this.user});

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is DocumentosSuccessState && other.user == user;
  }

  @override
  int get hashCode => user.hashCode;
}

class DocumentosErrorState extends DocumentosState {
  final String errorMessage;

  DocumentosErrorState({required this.errorMessage});

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is DocumentosErrorState && other.errorMessage == errorMessage;
  }

  @override
  int get hashCode => errorMessage.hashCode;
}

class DocumentosLoadedState extends DocumentosState {
  final List<DocumentosEntity> documentos;

  DocumentosLoadedState({required this.documentos});

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is DocumentosLoadedState &&
        listEquals(other.documentos, documentos);
  }

  @override
  int get hashCode => documentos.hashCode;
}
