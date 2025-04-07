import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:metodista/modulo_common_services/modulo_common_services.dart';
import '../presenter.dart';

class DocumentosBody extends StatelessWidget {
  const DocumentosBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DocumentosCubit, DocumentosState>(
        builder: (context, state) {
      if (state is DocumentosLoadingState) {
        return SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Center(
              child: CircularProgressIndicator(
            color: ColorsConstants().primaryColor,
          )),
        );
      }
      if (state is DocumentosLoadedState) {
        print(state.documentos);
        return SizedBox(
            height: MediaQuery.of(context).size.height,
            child: GridView.builder(
                padding: const EdgeInsets.all(5),
                itemCount: state.documentos.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, childAspectRatio: 2 / 2),
                itemBuilder: (context, index) {
                  return GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DocumentosLista(
                                      titulo: state.documentos[index].titulo!,
                                      documentos:
                                          state.documentos[index].arquivos,
                                    )));
                      },
                      child: Stack(
                        children: [
                          Padding(
                            padding: EdgeInsets.all(5),
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20.0),
                                  image: const DecorationImage(
                                    image: AssetImage('assets/documentos.png'),
                                    fit: BoxFit.cover,
                                  ),
                                  color: Colors.white),
                              width: 200,
                              height: 300,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(5),
                            child: Container(
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
                                  Text(
                                    state.documentos[index].titulo!,
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              )),
                            ),
                          )
                        ],
                      ));
                }));
      }
      return SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
      );
    });
  }
}
