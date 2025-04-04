import '../../feature/home/home.dart';
import '../core.dart';

Future<void> init() async {
  // Repositories
  Get.lazyPut<HomeRepository>(
    () => HomeRepositoryImpl(),
  );

  // Use cases
  Get.lazyPut(() => GetHomeDataUseCase(Get.find()));
}
