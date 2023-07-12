import 'package:get_storage/get_storage.dart';
import 'package:observable_ish/observable_ish.dart';
import 'package:stacked/stacked.dart';

class UserStore with ReactiveServiceMixin {
  GetStorage sharedPrefs = GetStorage();
  final RxValue<String> _accessToken = RxValue("");
  static const ACCESS_TOKEN_PERSISTENT_KEY = "BERANA_ACCESS_TOKEN";
  String get accessToken => _retrieveAccessToken();

  String _retrieveAccessToken() {
    String token = _accessToken.value;
    if (token.isNotEmpty) return token;
    token = sharedPrefs.read(ACCESS_TOKEN_PERSISTENT_KEY) ?? "";
    if (token.isNotEmpty) setAccessToken(value: token);
    return token;
  }

  void setAccessToken({required String value}) {
    _accessToken.value = value;
    sharedPrefs.write(ACCESS_TOKEN_PERSISTENT_KEY, value);
    notifyListeners();
  }

  UserStore() {
    listenToReactiveValues([_accessToken]);
  }
}
