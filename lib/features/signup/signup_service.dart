import 'package:berana/shared/extensions.dart';
import 'package:observable_ish/observable_ish.dart';
import 'package:stacked/stacked.dart';

class SignUpService with ReactiveServiceMixin {
  RxValue<String> _firstName = RxValue('');
  RxValue<String> _lastName = RxValue('');
  RxValue<String> _phoneNumber = RxValue('');
  RxValue<String> _email = RxValue('');
  RxValue<String> _password = RxValue('');
  RxValue<String> _passwordConfirmation = RxValue('');

  String get firstName => _firstName.value;
  String get lastName => _lastName.value;
  String get phoneNumber => _phoneNumber.value;
  String get email => _email.value;
  String get password => _password.value;
  String get passwordConfirmation => _passwordConfirmation.value;

  void setFirstName({required String value}) {
    if(!value.validateOnlyAlpha()) return;
    _firstName.value = value;
    notifyListeners();
  }

  void setLastName({required String value}) {
    if(!value.validateOnlyAlpha()) return;
    _lastName.value = value;
    notifyListeners();
  }

  void setPhoneNumber({required String value}) {
    if(!value.validatePhoneNumber()) return;
    _phoneNumber.value = value;
    notifyListeners();
  }

  void setEmail({required String value}) {
    if(!value.validateEmail()) return;
    _email.value = value;
    notifyListeners();
  }

  void setPassword({required String value}) {
    if(!value.validatePassword()) return;
    _password.value = value;
    notifyListeners();
  }

  void setPasswordConfirmation({required String value}) {
    if(!value.validatePassword()) return;
    _passwordConfirmation.value = value;
    notifyListeners();
  }


  SignUpService() {
    listenToReactiveValues([
      _firstName,
      _lastName,
      _phoneNumber,
      _email,
      _password,
      _passwordConfirmation
    ]);
  }
}