import 'package:flutter/material.dart';

import '../models/templo_model.dart';

class AgentaTemploCard extends StatelessWidget {
  final String titulo;
  final String data;
  final String image;
  final List<Horario> horario;

  AgentaTemploCard(
      {required this.titulo,
      required this.data,
      required this.image,
      required this.horario});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Card(
        child: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            child: Column(
              children: [
                Flexible(
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height * 0.1,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Container(
                            width: 150,
                            padding: EdgeInsets.all(8.0),
                            child: Center(
                              child: Text(
                                this.titulo,
                                textAlign: TextAlign.left,
                              ),
                            )),
                        Container(
                          width: 90,
                          decoration: BoxDecoration(
                              gradient: RadialGradient(
                                  colors: [
                                Color(0xffFCE183),
                                Color(0xffF68D7F),
                              ],
                                  center: Alignment(0, 0),
                                  radius: 0.8,
                                  focal: Alignment(0, 0),
                                  focalRadius: 0.1)),
                          padding: EdgeInsets.all(8.0),
                          child: Center(
                            child: Image.asset(image),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Flexible(
                  child: Container(
                    decoration: BoxDecoration(
                        gradient: RadialGradient(
                            colors: [
                          Color(0xffFCE183),
                          Color(0xffF68D7F),
                          Color(0xffFCE183),
                        ],
                            center: Alignment(0, 0),
                            radius: 0.8,
                            focal: Alignment(0, 0),
                            focalRadius: 0.1)),
                    height: 1,
                    width: MediaQuery.of(context).size.width * 0.6,
                  ),
                ),
                Flexible(
                  flex: 5,
                  fit: FlexFit.loose,
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.6,
                    child: ListView.builder(
                      padding: EdgeInsets.zero,
                      itemCount: horario.length,
                      itemBuilder: (_, index) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 6, top: 6),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.watch_later_rounded,
                                    size: 15,
                                  ),
                                  Text(
                                    horario[index].hora,
                                    style:
                                        TextStyle(fontWeight: FontWeight.w700),
                                  ),
                                ],
                              ),
                              Text(horario[index].evento),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                )
              ],
            )),
      ),
    );
  }
}
