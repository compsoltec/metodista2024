import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../module_common_deps/module_common_deps.dart';
import '../../../module_config/constants/colors_constants.dart';
import '../../../module_services/service_locator.dart';
import '../../external/datasources/datasources.dart';
import '../cubit/atividade_cubit.dart';
import '../pages/ministerios/inscritos_atividades.dart';

class ListarAtividadeBody extends StatelessWidget {
  const ListarAtividadeBody({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: AtividadeDatasourceImpl(dio: Dio()).getAtividade(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return GridView.builder(
                padding: const EdgeInsets.all(5),
                itemCount: snapshot.data!.length,
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
                                                snapshot.data![index].id!),
                                      child: InscritosAtividades(
                                        imgPath: snapshot.data![index].foto!,
                                        id: snapshot.data![index].id!,
                                        titulo: snapshot.data![index].titulo!,
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
                                        snapshot.data![index].foto!),
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
                                      height: 40,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                      child: Center(
                                        child: Text(
                                          snapshot.data![index].titulo!,
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
                });
          }
          return Center(
            child: CircularProgressIndicator(
                color: ColorsConstants().primaryColor),
          );
        });
  }
}
