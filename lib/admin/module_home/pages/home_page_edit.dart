import '../../../module_common_deps/module_common_deps.dart';
import '../../../module_designer_system/module_designer_system.dart';
import '../controllers/controllers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:io';

class HomePageEdit extends StatefulWidget {
  @override
  State<HomePageEdit> createState() => _HomePageEditState();
}

class _HomePageEditState extends State<HomePageEdit> {
  HomeControllerAdmin homeController = Get.put(HomeControllerAdmin());
  @override
  Widget build(BuildContext context) {
    homeController.fotosCulto = homeController.homeModel!.fotosCultos!;
    homeController.avisos = homeController.homeModel!.avisos;
    homeController.campanhas = homeController.homeModel!.campanhas;
    homeController.aniversariantes = homeController.homeModel!.aniversariantes;
    return Scaffold(
      
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
          backgroundColor: Colors.black,
          onPressed: () {
            homeController.putData(
                homeController.homeModel!.avisos,
                homeController.homeModel!.campanhas,
                homeController.fotosCulto,
                homeController.homeModel!.aniversariantes,
                homeController.homeModel!.id);
          },
          label: Obx(
            () => homeController.isLoading.value
                ? const Center(
                    child: CircularProgressIndicator(color: Colors.white),
                  )
                : Row(children: [Text('Atualizar Informações')]),
          )),
      body: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.2,
            child: const CustomAppBar(
              isIconePerson: false,
              isBackScreen: true,
            ),
          ),
          CustomBody(
              child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.grey.shade200),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding:
                              EdgeInsets.only(top: 10, left: 20, bottom: 10),
                          child: SizedBox(
                              child: Text(
                            'Fotos Culto',
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold),
                          )),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: 300,
                          child: Obx(
                            () => homeController.isLoading.value
                                ? const Center(
                                    child: CircularProgressIndicator(
                                      color: Colors.black,
                                    ),
                                  )
                                : ListView.builder(
                                    padding: EdgeInsets.zero,
                                    scrollDirection: Axis.horizontal,
                                    itemCount: homeController
                                            .fotosCulto!.reversed.length ??
                                        0,
                                    itemBuilder: (context, index) {
                                      return Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10),
                                        child: Container(
                                          width: 300,
                                          height: 300,
                                          decoration: BoxDecoration(
                                              image: DecorationImage(
                                                  image: NetworkImage(
                                                      homeController
                                                          .fotosCulto![index]),
                                                  fit: BoxFit.cover),
                                              borderRadius:
                                                  BorderRadius.circular(20)),
                                          child: Center(
                                              child: IconButton(
                                            onPressed: () {
                                              setState(() {
                                                homeController.fotosCulto!
                                                    .removeAt(index);
                                              });
                                            },
                                            icon: const Icon(
                                              Icons.delete,
                                              color: Colors.red,
                                              size: 30,
                                            ),
                                          )),
                                        ),
                                      );
                                    }),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: InkWell(
                            onTap: () {
                              imgFromGallery('fotosCulto');
                            },
                            child: Container(
                              height: 100,
                              width: 100,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.grey.shade100),
                              child: const Center(
                                  child: Icon(Icons.camera_alt_outlined)),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                      ]),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.grey.shade200),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding:
                              EdgeInsets.only(top: 10, left: 20, bottom: 10),
                          child: SizedBox(
                              child: Text(
                            'Avisos',
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold),
                          )),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: 300,
                          child: Obx(
                            () => homeController.isLoading.value
                                ? const Center(
                                    child: CircularProgressIndicator(
                                      color: Colors.black,
                                    ),
                                  )
                                : ListView.builder(
                                    padding: EdgeInsets.zero,
                                    scrollDirection: Axis.horizontal,
                                    itemCount: homeController
                                            .avisos!.reversed.length ??
                                        0,
                                    itemBuilder: (context, index) {
                                      return Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10),
                                        child: Container(
                                          width: 300,
                                          height: 300,
                                          decoration: BoxDecoration(
                                              image: DecorationImage(
                                                  image: NetworkImage(
                                                      homeController
                                                          .avisos![index]),
                                                  fit: BoxFit.cover),
                                              borderRadius:
                                                  BorderRadius.circular(20)),
                                          child: Center(
                                              child: IconButton(
                                            onPressed: () {
                                              setState(() {
                                                homeController.avisos!
                                                    .removeAt(index);
                                              });
                                            },
                                            icon: const Icon(
                                              Icons.delete,
                                              color: Colors.red,
                                              size: 30,
                                            ),
                                          )),
                                        ),
                                      );
                                    }),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: InkWell(
                            onTap: () {
                              imgFromGallery('avisos');
                            },
                            child: Container(
                              height: 100,
                              width: 100,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.grey.shade100),
                              child: const Center(
                                  child: Icon(Icons.camera_alt_outlined)),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                      ]),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.grey.shade200),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding:
                              EdgeInsets.only(top: 10, left: 20, bottom: 10),
                          child: SizedBox(
                              child: Text(
                            'Campanhas',
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold),
                          )),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: 300,
                          child: Obx(
                            () => homeController.isLoading.value
                                ? const Center(
                                    child: CircularProgressIndicator(
                                      color: Colors.black,
                                    ),
                                  )
                                : ListView.builder(
                                    padding: EdgeInsets.zero,
                                    scrollDirection: Axis.horizontal,
                                    itemCount: homeController
                                            .campanhas!.reversed.length ??
                                        0,
                                    itemBuilder: (context, index) {
                                      return Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10),
                                        child: Container(
                                          width: 300,
                                          height: 300,
                                          decoration: BoxDecoration(
                                              image: DecorationImage(
                                                  image: NetworkImage(
                                                      homeController
                                                          .campanhas![index]),
                                                  fit: BoxFit.cover),
                                              borderRadius:
                                                  BorderRadius.circular(20)),
                                          child: Center(
                                              child: IconButton(
                                            onPressed: () {
                                              setState(() {
                                                homeController.campanhas!
                                                    .removeAt(index);
                                              });
                                            },
                                            icon: const Icon(
                                              Icons.delete,
                                              color: Colors.red,
                                              size: 30,
                                            ),
                                          )),
                                        ),
                                      );
                                    }),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: InkWell(
                            onTap: () {
                              imgFromGallery('campanhas');
                            },
                            child: Container(
                              height: 100,
                              width: 100,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.grey.shade100),
                              child: const Center(
                                  child: Icon(Icons.camera_alt_outlined)),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                      ]),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.grey.shade200),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding:
                              EdgeInsets.only(top: 10, left: 20, bottom: 10),
                          child: SizedBox(
                              child: Text(
                            'Aniversariantes',
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold),
                          )),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: 100,
                          child: Obx(
                            () => homeController.isLoading.value
                                ? const Center(
                                    child: CircularProgressIndicator(
                                      color: Colors.black,
                                    ),
                                  )
                                : ListView.builder(
                                    padding: EdgeInsets.zero,
                                    scrollDirection: Axis.horizontal,
                                    itemCount: homeController
                                            .aniversariantes!.reversed.length ??
                                        0,
                                    itemBuilder: (context, index) {
                                      return Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10),
                                          child: Container(
                                              width: 200,
                                              height: 100,
                                              decoration: BoxDecoration(
                                                  color: Colors.grey.shade100,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20)),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  const SizedBox(
                                                    width: 10,
                                                  ),
                                                  Expanded(
                                                    child: Text(homeController
                                                            .aniversariantes![
                                                        index]),
                                                  ),
                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                  IconButton(
                                                    onPressed: () {
                                                      setState(() {
                                                        homeController
                                                            .aniversariantes!
                                                            .removeAt(index);
                                                      });
                                                    },
                                                    icon: const Icon(
                                                      Icons.delete,
                                                      color: Colors.red,
                                                      size: 20,
                                                    ),
                                                  ),
                                                ],
                                              )),
                                        ),
                                      );
                                    }),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    padding:
                                        const EdgeInsets.only(left: 10, top: 5),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    height: 55,
                                    width: MediaQuery.of(context).size.width,
                                    child: TextField(
                                      controller: homeController
                                          .controllerAniversariantes,
                                      decoration: const InputDecoration(
                                        border: InputBorder.none,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      homeController.aniversariantes!.add(
                                          homeController
                                              .controllerAniversariantes.text);
                                      homeController.controllerAniversariantes
                                          .clear();
                                    });
                                  },
                                  child: const CircleAvatar(
                                    backgroundColor: Colors.black,
                                    child: Icon(
                                      Icons.send,
                                      size: 20,
                                      color: Colors.white,
                                    ),
                                  ),
                                )
                              ],
                            )),
                        const SizedBox(
                          height: 20,
                        ),
                      ]),
                ),
                const SizedBox(
                  height: 100,
                ),
              ],
            ),
          )),
        ],
      ),
    );
  }

  Future imgFromGallery(tipoImagem) async {
    final pickedFile =
        await homeController.picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        homeController.photo = File(pickedFile.path);
        homeController.uploadFile(tipoImagem);
        homeController.imageFileList!.add(homeController.photo!);
      });
    } else {
      print('No image selected.');
    }
  }
}
