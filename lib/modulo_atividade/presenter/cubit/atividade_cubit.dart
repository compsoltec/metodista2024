import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import '../../domain/domain.dart';
import '../../external/datasources/datasources.dart';
import 'atividade_state.dart';

class AtividadeCubit extends Cubit<AtividadeState> {
  final DoAtividadeUsecase _usecase;
  AtividadeCubit({required DoAtividadeUsecase usecase})
      : _usecase = usecase,
        super(
          AtividadeInitialState(),
        );

  TextEditingController controllerNome = TextEditingController();
  TextEditingController controllerTelefone = TextEditingController();
  TextEditingController controllerData = TextEditingController();
  TextEditingController controllerDescricao = TextEditingController();
  TextEditingController controllerVaga = TextEditingController();
  TextEditingController cnotrollerTitulo = TextEditingController();

  final focusNodeData = FocusNode();
  final focusNodeDescricao = FocusNode();
  final focusNodeVaga = FocusNode();
  final focusNodeTitulo = FocusNode();

  String? urlDownload;

  final formKey = GlobalKey<FormState>();
  var maskFormatter = MaskTextInputFormatter(
      mask: '(##) #####-####',
      filter: {"#": RegExp(r'[0-9]')},
      type: MaskAutoCompletionType.lazy);
  List<InscritosRequestEntity> inscritos = [];
  List<InscritosRequestEntity> inscritosAtividade = [];

  String idInscricao = '';

  Future<void> doAtividade(AtividadeRequestEntity atividadeRequest) async {
    emit(AtividadeLoadingState());

    try {
      final AtividadeResponse user =
          await _usecase.call(atividadeRequestEntity: atividadeRequest);

      emit(AtividadeSuccessState(user: user));
    } on AtividadeFailure catch (error) {
      emit(AtividadeErrorState(errorMessage: error.errorMessage));
    }
  }

  Future<void> getAtividade() async {
    emit(AtividadeLoadingState());
    try {
      final result = await _usecase.getAtividade();
      emit(AtividadeLoadedState(atividade: result));
    } on AtividadeFailure catch (error) {
      emit(AtividadeErrorState(errorMessage: error.errorMessage));
    }
  }

  Future<void> getInscritos(String inscritosRequestEntity) async {
    emit(AtividadeLoadingState());
    try {
      final result = await AtividadeDatasourceImpl(dio: Dio())
          .getInscritos(atividadeId: inscritosRequestEntity);
      final resultAll = await AtividadeDatasourceImpl(dio: Dio())
          .getAllInscritos(atividadeId: inscritosRequestEntity);
      emit(InscritosLoadedState(atividade: result, inscritos: resultAll));
    } on AtividadeFailure catch (error) {
      emit(AtividadeErrorState(errorMessage: error.errorMessage));
    }
  }

  Future<void> doInscrito(InscritosRequestEntity inscritosRequestEntity) async {
    emit(AtividadeLoadingState());
    try {
      final AtividadeResponse user = await AtividadeDatasourceImpl(dio: Dio())
          .doInscrito(atividadeRequestEntity: inscritosRequestEntity);
      emit(AtividadeSuccessState(user: user));
    } on AtividadeFailure catch (error) {
      emit(AtividadeErrorState(errorMessage: error.errorMessage));
    }
  }

  Future<void> deleteInscricao(
      InscritosRequestEntity inscritosRequestEntity) async {
    try {
      emit(AtividadeLoadingState());
      final user = await AtividadeDatasourceImpl(dio: Dio())
          .deleteInscrito(atividadeRequestEntity: inscritosRequestEntity);
      emit(AtividadeSuccessState(
          user: AtividadeResponse(
              message: 'Inscrição Deletada com Sucesso', status: true)));
    } on AtividadeFailure catch (error) {
      emit(AtividadeErrorState(errorMessage: error.errorMessage));
    }
  }
}
