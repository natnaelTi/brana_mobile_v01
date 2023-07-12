// import 'package:berana/stores/user_store.dart';
import 'package:berana/features/signup/signup_service.dart';
import 'package:berana/shared/services/change_tab_service.dart';
import 'package:berana/stores/genre_store.dart';
import 'package:berana/stores/user_store.dart';
import 'package:get_it/get_it.dart';
import 'package:berana/shared/services/dialogue_service.dart';
import 'package:berana/shared/services/navigation_service.dart';
// import 'package:berana/stores/user_store.dart';

GetIt locator = GetIt.instance;

setupLocator() {
  // Internal Services
  locator.registerLazySingleton(() => NavigationService());
  locator.registerLazySingleton(() => DialogueService());
  locator.registerLazySingleton(() => ChangeTabService());
  // Local Internal Services
  locator.registerLazySingleton(() => SignUpService());
  // Stores
  locator.registerLazySingleton(() => GenreStore());
  locator.registerLazySingleton(() => UserStore());
  // locator.registerLazySingleton(() => UserStore());
}
