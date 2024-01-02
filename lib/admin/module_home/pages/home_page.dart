import 'dart:io';
import '../../../module_common_deps/module_common_deps.dart';
import '../../../module_designer_system/module_designer_system.dart';
import '../module_home.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePageAdmin extends StatefulWidget {
  @override
  State<HomePageAdmin> createState() => _HomePageAdminState();
}

class _HomePageAdminState extends State<HomePageAdmin> {
  HomeControllerAdmin homeController = Get.put(HomeControllerAdmin());
  List<CustomButtomModel> imageList = [
    CustomButtomModel(
        image: 'assets/icons/botao-home.png',
        page: '/home_edit',
        text: 'Configurar Home'),
    CustomButtomModel(
        image: 'assets/icons/nota-musical.png',
        page: '/home_edit',
        text: 'Configurar Home'),

    // 'assets/icons/botao-home.png',
    // 'assets/icons/nota-musical.png',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: SingleChildScrollView(
        child: Column(
          children: [
            const CustomAppBar(
              isIconePerson: true,
              isBackScreen: false,
            ),
            CustomBody(
              child: Column(children: [
                Expanded(
                  child: GridView.builder(
                      padding: EdgeInsets.zero,
                      itemCount: imageList.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: MediaQuery.of(context).orientation ==
                                Orientation.landscape
                            ? 3
                            : 2,
                        crossAxisSpacing: 8,
                        mainAxisSpacing: 8,
                        childAspectRatio: (2 / 2),
                      ),
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            Get.toNamed('/home_edit');
                          },
                          child: Container(
                              decoration: const BoxDecoration(
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey,
                                      blurRadius: 15.0, // soften the shadow
                                      spreadRadius: 5.0, //extend the shadow
                                      offset: Offset(
                                        8.0, // Move to right 5  horizontally
                                        8.0, // Move to bottom 5 Vertically
                                      ),
                                    )
                                  ],
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20))),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    imageList[index].image!,
                                    height: 90,
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  const Text(
                                    'Configurar Home',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  )
                                ],
                              )),
                        );
                      }),
                )
              ]),
            )

            // Container(
            //   width: MediaQuery.of(context).size.width,
            //   height: 200,
            //   child: Obx(
            //     () => homeController.isLoading.value
            //         ? const Center(
            //             child: CircularProgressIndicator(),
            //           )
            //         : ListView.builder(
            //             itemCount:
            //                 homeController.homeModel?.aniversariantes!.length,
            //             itemBuilder: (context, index) {
            //               return ListTile(
            //                 title: Text('Aqqui' ?? 'no name'),
            //               );
            //             }),
            //   ),
            // ),
            // Center(
            //   child: GestureDetector(
            //     onTap: () {
            //       _showPicker(context);
            //     },
            //     child: homeController.photo != null
            //         ? ClipRRect(
            //             borderRadius: BorderRadius.circular(20),
            //             child: Image.file(
            //               homeController.photo!,
            //               width: 200,
            //               height: 200,
            //               fit: BoxFit.cover,
            //             ),
            //           )
            //         : Container(
            //             decoration: BoxDecoration(
            //                 color: Colors.grey[200],
            //                 borderRadius: BorderRadius.circular(20)),
            //             width: 100,
            //             height: 100,
            //             child: Icon(
            //               Icons.camera_alt,
            //               color: Colors.grey[800],
            //             ),
            //           ),
            //   ),
            // ),
            // SizedBox(
            //   width: MediaQuery.of(context).size.width,
            //   height: 200,
            //   child: ListView.builder(
            //       scrollDirection: Axis.horizontal,
            //       itemCount: homeController.imageFileList!.length,
            //       itemBuilder: ((context, index) {
            //         return (Image.file(homeController.imageFileList![index]));
            //       })),
            // )
          ],
        ),
      ),
    ));
  }

  
}
