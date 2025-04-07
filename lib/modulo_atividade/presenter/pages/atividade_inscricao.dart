import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../module_config/constants/colors_constants.dart';
import '../../../module_designer_system/components/custom_alert_dialog.dart';
import '../../../module_designer_system/components/custom_textFormField.dart';
import '../../../module_services/service_locator.dart';
import '../../../module_services/sharedPreference_services.dart';
import '../../modulo_atividade.dart';

class AtividadeInscricao extends StatefulWidget {
  final imgPath;
  final String? data, descricao, id, titulo;
  final int? vagas;

  const AtividadeInscricao(
      {Key? key,
      this.imgPath,
      this.data,
      this.descricao,
      this.id,
      this.titulo,
      this.vagas})
      : super(key: key);

  @override
  State<AtividadeInscricao> createState() => _AtividadeInscricaoState();
}

class _AtividadeInscricaoState extends State<AtividadeInscricao> {
  final SharedPreferenceModule pref = getIt.get();
  var atividade = getIt.get<AtividadeCubit>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: ColorsConstants().primaryColor,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.white),
        centerTitle: true,
        title: Text(
          widget.titulo!,
          style: GoogleFonts.quicksand(
              fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white),
        ),
      ),
      body: Form(
        key: atividade.formKey,
        child: Stack(
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                image: DecorationImage(
                    opacity: 0.5,
                    image: NetworkImage(widget.imgPath),
                    fit: BoxFit.cover),
              ),
              child: Align(
                  alignment: Alignment.topCenter,
                  child: Image.network(widget.imgPath)),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 400,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40),
                    ),
                    color: ColorsConstants().primaryColor,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: 70,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: CustomTextFormField(
                                  textInputType: TextInputType.text,
                                  validators: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'O Campo Nome Não Pode Estar Vázio';
                                    }
                                    return null;
                                  },
                                  controller: atividade.controllerNome,
                                  icon: const Icon(Icons.person),
                                  borderColor: Colors.white,
                                  hintColor: ColorsConstants().primaryColor,
                                  hintText: 'Nome',
                                  label: '',
                                  labelColor: ColorsConstants().primaryColor,
                                  prefixColor: ColorsConstants().primaryColor,
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              BlocConsumer<AtividadeCubit, AtividadeState>(
                                listener: (context, state) {
                                  if (state is AtividadeSuccessState) {
                                    atividade.controllerNome.clear();
                                    atividade.controllerTelefone.clear();
                                    _showAlert(
                                      state.user.message,
                                      "Concluído",
                                    );
                                    setState(() {
                                      getIt<AtividadeCubit>()
                                          .getInscritos(widget.id!);
                                    });
                                  } else if (state is AtividadeErrorState) {
                                    _showAlert(state.errorMessage, "Atenção");
                                  } else if (state is AtividadeLoadingState) {
                                    const Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  } else if (state is InscritosLoadedState) {
                                    setState(() {
                                      atividade.inscritosAtividade =
                                          state.atividade;
                                      atividade.inscritos = state.inscritos;
                                    });
                                  }
                                },
                                builder: (context, state) {
                                  final bool isLoadingState =
                                      state is AtividadeLoadingState;
                                  return CircleAvatar(
                                    backgroundColor: Colors.white,
                                    child: isLoadingState
                                        ? const Center(
                                            child: CircularProgressIndicator(),
                                          )
                                        : IconButton(
                                            icon: Icon(
                                              Icons.send,
                                              color: ColorsConstants()
                                                  .primaryColor,
                                            ),
                                            onPressed: () {
                                              if (atividade
                                                  .formKey.currentState!
                                                  .validate()) {
                                                _onPressedAtividade(context);
                                              }
                                            },
                                          ),
                                  );
                                },
                              )
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: CustomTextFormField(
                          textInputType: TextInputType.phone,
                          controller: atividade.controllerTelefone,
                          icon: const Icon(Icons.phone_iphone),
                          borderColor: ColorsConstants().primaryColor,
                          hintColor: ColorsConstants().primaryColor,
                          hintText: 'Telefone',
                          inputFormatters: [atividade.maskFormatter],
                          label: '',
                          validators: (value) {
                            if (value == null || value.isEmpty) {
                              return 'O Campo Telefone Não Pode Estar Vázio';
                            }
                            return null;
                          },
                          labelColor: ColorsConstants().primaryColor,
                          prefixColor: ColorsConstants().primaryColor,
                        ),
                      ),
                      const Padding(
                          padding: EdgeInsets.only(left: 20, right: 20),
                          child: Divider(
                            color: Colors.white,
                          )),
                      const SizedBox(height: 10),
                      Expanded(
                          child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: ListView.builder(
                            padding: EdgeInsets.zero,
                            itemCount: atividade.inscritosAtividade.length,
                            itemBuilder: (context, index) {
                              return SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  height: 40,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      const Icon(
                                        Icons.person,
                                        color: Colors.white,
                                      ),
                                      Expanded(
                                        child: Text(
                                          atividade
                                              .inscritosAtividade[index].nome,
                                          style: GoogleFonts.quicksand(
                                              color: Colors.white,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ),
                                      IconButton(
                                          onPressed: () {
                                            _onPressedDelete(
                                                context,
                                                atividade
                                                    .inscritosAtividade[index]
                                                    .id);
                                          },
                                          icon: const Icon(
                                            Icons.delete,
                                            color: Colors.red,
                                          ))
                                    ],
                                  ));
                            }),
                      )),
                      const SizedBox(height: 30),
                    ],
                  )),
            )
          ],
        ),
      ),
    );
  }

  void _showAlert(String message, String alert) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return CustomDialogBox(
            onPressedLeft: () {
              _onPressedGetInsc();
              Navigator.pop(context);
            },
            onPressed: () {},
            title: alert,
            textLeft: '',
            descriptions: message,
            text: 'Voltar',
          );
        });
  }

  void _onPressedDelete(BuildContext context, String idInscrito) async {
    final SharedPreferenceModule pref = getIt.get();
    final request = InscritosRequestEntity(
        id: idInscrito,
        nome: atividade.controllerNome.text,
        telefone: atividade.controllerTelefone.text,
        token: pref.getUserData(),
        idAtividade: widget.id!);

    context.read<AtividadeCubit>().deleteInscricao(request);
    _onPressedGetInsc();
  }

  void _onPressedAtividade(BuildContext context) async {
    print(widget.vagas);
    if (atividade.inscritos.length == widget.vagas) {
      _showAlert('Limite de Vagas excedido', 'Atenção');
    } else {
      final SharedPreferenceModule pref = getIt.get();
      final request = InscritosRequestEntity(
          id: '',
          nome: atividade.controllerNome.text,
          telefone: atividade.controllerTelefone.text,
          token: pref.getUserData(),
          idAtividade: widget.id!);

      context.read<AtividadeCubit>().doInscrito(request);
    }
  }

  void _onPressedGetInsc() async {
    context.read<AtividadeCubit>().getInscritos(widget.id!);
  }
}
