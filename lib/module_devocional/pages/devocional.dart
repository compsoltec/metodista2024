import 'package:flutter/material.dart';
import 'package:notification2/module_config/constants/colors_constants.dart';
import 'package:notification2/module_devocional/models/devocional_model.dart';

class Devocional extends StatelessWidget {
  final List<DevocionalModels> devocionalList;
  Devocional({required this.devocionalList});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const SizedBox(height: 15),
        const Text("Devocionais",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        SizedBox(
            height: 110,
            child: ListView.builder(
                padding: EdgeInsets.zero,
                scrollDirection: Axis.vertical,
                itemCount: devocionalList.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Container(
                      height: 100,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: Colors.white),
                      width: MediaQuery.of(context).size.width,
                      child: Padding(
                        padding: const EdgeInsets.all(5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            const SizedBox(
                              width: 10,
                            ),
                            CircleAvatar(
                              maxRadius: 40,
                              backgroundColor: ColorsConstants().cruzColor,
                              child: Padding(
                                padding: const EdgeInsets.all(5),
                                child: CircleAvatar(
                                  backgroundImage:
                                      NetworkImage(devocionalList[index].foto),
                                  maxRadius: 40,
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    width: 190,
                                    child: Text(
                                        "${devocionalList[index].titulo} ",
                                        style: const TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.black)),
                                  ),
                                  const Divider(
                                    height: 7,
                                    color: Colors.transparent,
                                  ),
                                  Text("Data: ${devocionalList[index].data} ",
                                      style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black)),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: 50,
                              child: GestureDetector(
                                onTap: () {
                                  // Navigator.push(
                                  //     context,
                                  //     MaterialPageRoute(
                                  //         builder: (context) =>
                                  //             ExecutarDevocional(
                                  //                 foto: state
                                  //                     .devocionais[index].foto!,
                                  //                 titulo: state
                                  //                     .devocionais[index]
                                  //                     .titulo!,
                                  //                 devocional: state
                                  //                     .devocionais[index]
                                  //                     .devocional!,
                                  //                 data: state.devocionais[index]
                                  //                     .data!)));
                                },
                                child: CircleAvatar(
                                  backgroundColor: Colors.black,
                                  child: const Icon(
                                    Icons.play_circle,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                }))
      ],
    );
  }
}
