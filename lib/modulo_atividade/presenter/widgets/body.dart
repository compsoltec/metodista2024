import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../module_config/constants/colors_constants.dart';
import '../../../module_services/service_locator.dart';
import '../cubit/atividade_cubit.dart';
import '../cubit/atividade_state.dart';
import '../pages/atividade_inscricao.dart';

class AtividadeBody extends StatelessWidget {
  const AtividadeBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AtividadeCubit, AtividadeState>(
        builder: (context, state) {
      if (state is AtividadeLoadedState) {
        return SizedBox(
            height: MediaQuery.of(context).size.height,
            child: GridView.builder(
                padding: const EdgeInsets.all(5),
                itemCount: state.atividade.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, childAspectRatio: 2 / 2),
                itemBuilder: (context, index) {
                  return GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => BlocProvider(
                                      create: (context) =>
                                          getIt<AtividadeCubit>()
                                            ..getInscritos(
                                                state.atividade[index].id!),
                                      child: AtividadeInscricao(
                                        vagas: state.atividade[index].vagas,
                                        imgPath: state.atividade[index].foto,
                                        data: state.atividade[index].data,
                                        descricao:
                                            state.atividade[index].descricao,
                                        id: state.atividade[index].id,
                                        titulo: state.atividade[index].titulo,
                                      ),
                                    )));
                      },
                      child: Stack(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(5),
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20.0),
                                  image: DecorationImage(
                                    image: NetworkImage(
                                        state.atividade[index].foto!),
                                    fit: BoxFit.cover,
                                  ),
                                  color: Colors.white),
                              width: 200,
                              height: 300,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(5),
                            child: Container(
                              padding: const EdgeInsets.all(5),
                              width: 200,
                              height: 300,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20.0),
                                gradient: LinearGradient(
                                    begin: Alignment.bottomRight,
                                    stops: const [
                                      0.3,
                                      0.9
                                    ],
                                    colors: [
                                      Colors.white.withOpacity(.5),
                                      Colors.white.withOpacity(.6),
                                    ]),
                              ),
                              child: Center(
                                  child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                      padding: const EdgeInsets.all(5),
                                      height: 60,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                      child: Center(
                                        child: Text(
                                          state.atividade[index].titulo!,
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      )),
                                ],
                              )),
                            ),
                          )
                        ],
                      ));
                }));
      } else if (state is AtividadeLoadingState) {
        return SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Center(
              child: CircularProgressIndicator(
            color: ColorsConstants().primaryColor,
          )),
        );
      }
      return SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
      );
    });
  }
}
