import 'package:berana/shared/services/service_subscription.dart';
import 'package:stacked/stacked.dart';


class LanguageSelectionViewModel extends ReactiveViewModel with ServiceSubscription {
  String languageSelectionBoxHeader = "Choose Language / ቋንቋ ይምረጡ";
  List<LanguageData> languages = [
    LanguageData(
        name: 'English',
        iconPath: 'assets/icons/flags/united_kingdom.png'
    ),
    LanguageData(
        name: 'Amharic',
        iconPath: 'assets/icons/flags/ethiopia.png'
    )
  ];

  int _selectedLanguageIndex = 0;
  int get selectedLanguageIndex => _selectedLanguageIndex;
  void setSelectedLanguageIndex (int index) {
    if(index > languages.length - 1) return;
    _selectedLanguageIndex = index;
    notifyListeners();
  }

  bool _dropDownOpen = false;
  bool get dropDownOpen => _dropDownOpen;
  void toggleDropDown() {
    _dropDownOpen = !_dropDownOpen;
    notifyListeners();
  }
}

class LanguageData {
  String name;
  String iconPath;

  LanguageData({
    required this.name,
    required this.iconPath
  });

  @override
  toString() {
    return 'LanguageData{name: $name, iconPath: $iconPath}';
  }
}