import 'package:flutter/foundation.dart';
import '../../domain/domain.dart';

abstract class AtividadeState {}

class AtividadeControllersState extends AtividadeState {
  late final List<String> integrantes;
}

class AtividadeInitialState extends AtividadeState {}

class AtividadeLoadingState extends AtividadeState {}

class AtividadeSuccessState extends AtividadeState {
  final AtividadeResponse user;

  AtividadeSuccessState({required this.user});

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AtividadeSuccessState && other.user == user;
  }

  @override
  int get hashCode => user.hashCode;
}

class AtividadeErrorState extends AtividadeState {
  final String errorMessage;

  AtividadeErrorState({required this.errorMessage});

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AtividadeErrorState && other.errorMessage == errorMessage;
  }

  @override
  int get hashCode => errorMessage.hashCode;
}

class InscritosLoadedState extends AtividadeState {
  final List<InscritosRequestEntity> atividade;
  final List<InscritosRequestEntity> inscritos;
  InscritosLoadedState({required this.atividade, required this.inscritos});

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is InscritosLoadedState &&
        listEquals(other.atividade, atividade);
  }

  @override
  int get hashCode => atividade.hashCode;
}

class InscritosInitialState extends AtividadeState {
  final List<InscritosRequestEntity> atividade;

  InscritosInitialState({required this.atividade});

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is InscritosInitialState &&
        listEquals(other.atividade, atividade);
  }

  @override
  int get hashCode => atividade.hashCode;
}

class AtividadeLoadedState extends AtividadeState {
  final List<AtividadeEntity> atividade;

  AtividadeLoadedState({required this.atividade});

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AtividadeLoadedState &&
        listEquals(other.atividade, atividade);
  }

  @override
  int get hashCode => atividade.hashCode;
}
