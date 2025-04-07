import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../module_config/constants/colors_constants.dart';
import '../../../../module_services/service_locator.dart';
import '../../../../module_services/sharedPreference_services.dart';
import '../../../modulo_atividade.dart';

class InscritosAtividades extends StatefulWidget {
  final String? titulo, imgPath, id;

  const InscritosAtividades(
      {super.key,
      required this.titulo,
      required this.imgPath,
      required this.id});

  @override
  State<InscritosAtividades> createState() => _InscritosAtividadesState();
}

class _InscritosAtividadesState extends State<InscritosAtividades> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsConstants().primaryColor,
      appBar: AppBar(
        backgroundColor: ColorsConstants().primaryColor,
        elevation: 0,
        title: Text(
          'Inscritos',
          style: GoogleFonts.quicksand(
              color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 30),
              child: Container(
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20))),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: BlocBuilder<AtividadeCubit, AtividadeState>(
                  builder: (context, state) {
                    if (state is AtividadeLoadingState) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (state is AtividadeErrorState) {
                    } else if (state is InscritosLoadedState) {
                      return Stack(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                right: 10, left: 10, top: 50),
                            child: ListView.builder(
                                padding: EdgeInsets.zero,
                                itemCount: state.atividade.length,
                                itemBuilder: (context, index) {
                                  state.atividade
                                      .sort((a, b) => a.nome.compareTo(b.nome));
                                  return Padding(
                                    padding: const EdgeInsets.only(top: 10),
                                    child: Container(
                                        height: 70,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        decoration: BoxDecoration(
                                            color:
                                                ColorsConstants().primaryColor,
                                            borderRadius:
                                                BorderRadius.circular(15)),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            const Padding(
                                              padding:
                                                  EdgeInsets.only(left: 10),
                                              child: Icon(
                                                Icons.person,
                                                color: Colors.white,
                                              ),
                                            ),
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  state.atividade[index].nome,
                                                  style: GoogleFonts.quicksand(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: Colors.white),
                                                ),
                                                Text(
                                                  state.atividade[index]
                                                      .telefone,
                                                  style: GoogleFonts.quicksand(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: Colors.white),
                                                ),
                                              ],
                                            ),
                                            IconButton(
                                                onPressed: () {
                                                  _onPressedDelete(
                                                      context,
                                                      state
                                                          .atividade[index].id);
                                                },
                                                icon: const Icon(
                                                  Icons.delete,
                                                  color: Colors.red,
                                                ))
                                          ],
                                        )),
                                  );
                                }),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              top: 30,
                            ),
                            child: Align(
                              alignment: Alignment.topCenter,
                              child: Text(
                                'Total de Inscritos: ${state.atividade.length.toString()}',
                                style: GoogleFonts.quicksand(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.black),
                              ),
                            ),
                          )
                        ],
                      );
                    }
                    return const SizedBox();
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onPressedDelete(BuildContext context, String idInscrito) async {
    final SharedPreferenceModule pref = getIt.get();
    final request = InscritosRequestEntity(
        id: idInscrito,
        nome: '',
        telefone: '',
        token: pref.getUserData(),
        idAtividade: widget.id!);

    context.read<AtividadeCubit>().deleteInscricao(request);
    _onPressedGetInsc();
  }

  void _onPressedGetInsc() async {
    context.read<AtividadeCubit>().getInscritos(widget.id!);
  }
}
