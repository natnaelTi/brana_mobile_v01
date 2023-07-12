import 'package:berana/features/genre_selection/genre_selection_view.dart';
import 'package:berana/shared/services/service_subscription.dart';
import 'package:flutter/cupertino.dart';
import 'package:stacked/stacked.dart';

class SignupViewModel extends ReactiveViewModel with ServiceSubscription {

  final TextEditingController firstNameTEC = TextEditingController();
  final TextEditingController lastNameTEC = TextEditingController();
  final TextEditingController emailTEC = TextEditingController();
  final TextEditingController phoneNumberTEC = TextEditingController();
  final TextEditingController passwordTEC = TextEditingController();
  final TextEditingController confirmPasswordTEC = TextEditingController();

  int _indexSignupPage = 0;
  int get indexSignupPage => _indexSignupPage;
  void toggleIndex() {
    if(_indexSignupPage != 0 && _indexSignupPage != 1) return;
    if(_indexSignupPage ==0) _indexSignupPage = 1;
    else _indexSignupPage = 0;
    notifyListeners();
  }

  void validateSignup() {

  }

  void submit() {
    navigationService.navigateTo(GenreSelectionView());
  }


  @override
  List<ReactiveServiceMixin> get reactiveServices => [
    signUpService
  ];
}