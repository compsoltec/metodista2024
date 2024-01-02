import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomAppBar extends StatelessWidget {
  final bool isIconePerson;
  final bool isBackScreen;
  const CustomAppBar(
      { required this.isIconePerson, required this.isBackScreen});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage(
                'assets/novotemplo.jpeg',
              ),
              fit: BoxFit.cover)),
      width: Get.width,
      height: 200,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        width: MediaQuery.of(context).size.width,
        color: Colors.black.withOpacity(0.8),
        child: Center(
            child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            isBackScreen
                ? IconButton(
                    onPressed: () => Get.back(),
                    icon: const Icon(Icons.arrow_back_ios_new_sharp),
                    color: Colors.white,
                  )
                : const SizedBox(),
            const Text(
              'Metodista Jardim Belvedere',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.bold),
            ),
            isIconePerson
                ? CircleAvatar(
                    backgroundColor: Colors.red.shade600,
                    child: const Icon(
                      Icons.person,
                      color: Colors.white,
                    ),
                  )
                : const SizedBox()
          ],
        )),
      ),
    );
  }
}
