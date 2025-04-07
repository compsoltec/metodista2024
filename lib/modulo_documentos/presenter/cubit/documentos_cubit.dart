import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

import '../../modulo_documentos.dart';

class DocumentosCubit extends Cubit<DocumentosState> {
  final DoDocumentosUsecase _usecase;
  bool _isLoading = false;

  List<String> integrantes = [];

  String? dropdownvalue = 'Acolhida';
  final focusIntegrante = FocusNode();
  final focusData = FocusNode();
  final formKey = GlobalKey<FormState>();
  TextEditingController controllerIntegrantes = TextEditingController();
  TextEditingController controllerData = TextEditingController();

  DocumentosCubit({required DoDocumentosUsecase usecase})
      : _usecase = usecase,
        super(
          DocumentosInitialState(),
        );

  Future<void> doDocumentos(DocumentosRequestEntity documentosRequest) async {
    emit(DocumentosLoadingState());

    try {
      final DocumentosResponse user =
          await _usecase.call(documentosRequestEntity: documentosRequest);

      emit(DocumentosSuccessState(user: user));
    } on DocumentosFailure catch (error) {
      emit(DocumentosErrorState(errorMessage: error.errorMessage));
    }
  }

  Future<void> getDocumentos() async {
    emit(DocumentosLoadingState());
    try {
      final result = await _usecase.getDocumentos();
      emit(DocumentosLoadedState(documentos: result));
    } on DocumentosFailure catch (error) {
      emit(DocumentosErrorState(errorMessage: error.errorMessage));
    }
  }
}
