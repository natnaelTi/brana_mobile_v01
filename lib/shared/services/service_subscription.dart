import 'package:berana/features/signup/signup_service.dart';
import 'package:get_storage/get_storage.dart';
import 'package:berana/locator.dart';
import 'package:berana/shared/services/change_tab_service.dart';
import 'package:berana/shared/services/dialogue_service.dart';
import 'package:berana/shared/services/navigation_service.dart';
// import 'package:berana/stores/user_store.dart';

class ServiceSubscription {
  // Internal Services
  final NavigationService _navigationService = locator<NavigationService>();
  final DialogueService _dialogueService = locator<DialogueService>();
  final ChangeTabService _changeTabService = locator<ChangeTabService>();

  // Local Internal Services
  final SignUpService _signUpService = locator<SignUpService>();

  // Stores
  // final UserStore _userStore = locator<UserStore>();
  final GetStorage _sharedPrefs = GetStorage();

  //
  NavigationService get navigationService => _navigationService;
  DialogueService get dialogueService => _dialogueService;
  ChangeTabService get changeTabService => _changeTabService;
  //
  SignUpService get signUpService => _signUpService;
  // UserStore get userStore => _userStore;
  GetStorage get sharedPrefs => _sharedPrefs;
}
