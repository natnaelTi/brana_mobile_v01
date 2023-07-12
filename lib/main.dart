import 'package:berana/features/splash_screen/splash_screen_view.dart';
import 'package:berana/locator.dart';
import 'package:berana/mainViewModel.dart';
import 'package:berana/shared/services/dialogue_manager.dart';
import 'package:berana/shared/services/dialogue_service.dart';
import 'package:berana/shared/services/navigation_service.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:stacked/stacked.dart';

void main() async {
  // WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  setupLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
        viewModelBuilder: () => MainViewModel(),
        builder: ((context, viewModel, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Berana',
            navigatorKey: locator<NavigationService>().navigationKey,
            builder: (context, child) => Navigator(
              key: locator<DialogueService>().dialogNavigationKey,
              onGenerateRoute: (settings) => MaterialPageRoute(
                  builder: (context) => DialogueManager(child: child!)),
            ),
            home: SplashScreenView()
          );
        })
    );
  }
}
