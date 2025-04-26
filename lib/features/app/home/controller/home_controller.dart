import 'package:flutter/material.dart';

import '../../../../core/core.dart';
import '../home.dart';

class HomeController extends GetxController {
  final GetHomeDataUseCase _getHomeDataUseCase;

  HomeController(this._getHomeDataUseCase);

  final isLoading = true.obs;
  final drawerKey = GlobalKey<ScaffoldState>();

  @override
  void onInit() {
    super.onInit();
    loadHomeData();
  }

  Future<void> loadHomeData() async {
    isLoading.value = true;
    final result = await _getHomeDataUseCase();
    result.fold(
      (failure) => Get.snackbar(
        'Erro',
        'Não foi possível carregar os dados',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      ),
      (data) {
        // Handle data
      },
    );
    isLoading.value = false;
  }

  void openDrawer() {
    drawerKey.currentState?.openDrawer();
  }

  Widget buildDevocional() {
    return Container(); // Implement devocional widget
  }

  Widget buildPastoral() {
    return Container(); // Implement pastoral widget
  }

  Widget buildProgramacoes() {
    return Container(); // Implement programacoes widget
  }

  Widget buildAniversariantes() {
    return Container(); // Implement aniversariantes widget
  }
}
