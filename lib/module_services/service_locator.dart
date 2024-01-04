import 'package:shared_preferences/shared_preferences.dart';
import 'package:get_it/get_it.dart';

import 'sharedPreference_services.dart';
final getIt = GetIt.instance;

void initServiceLocator() {
  getIt.registerSingletonAsync<SharedPreferences>(
      () => SharedPreferences.getInstance());

  getIt.registerSingletonWithDependencies<SharedPreferenceModule>(
      () => SharedPreferenceModule(pref: getIt<SharedPreferences>()),
      dependsOn: [SharedPreferences]);
  
}
