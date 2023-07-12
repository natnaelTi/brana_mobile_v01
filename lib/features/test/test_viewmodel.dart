import 'package:berana/shared/services/service_subscription.dart';
import 'package:stacked/stacked.dart';

class TestViewModel extends ReactiveViewModel with ServiceSubscription {
    bool _testBool = false;
    bool get testBool => _testBool;
    void toggleTestBool () {
      _testBool = !_testBool;
      notifyListeners();
    }
}