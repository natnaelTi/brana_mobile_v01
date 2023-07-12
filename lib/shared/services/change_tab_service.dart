import 'package:observable_ish/observable_ish.dart';
import 'package:stacked/stacked.dart';

class ChangeTabService with ReactiveServiceMixin {
  RxValue<int> _tabIndex = RxValue<int>(0);
  int get tabIndex => _tabIndex.value;
  void changeTab({required int tabIndex}) {
    if (tabIndex > 0 && tabIndex <= 3) {
      _tabIndex.value = tabIndex;
      notifyListeners();
    }
  }
}
