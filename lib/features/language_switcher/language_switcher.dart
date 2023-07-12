import 'package:berana/features/language_switcher/language_switcher_viewmodel.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter/material.dart';

class LanguageSwitcherView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<LanguageSwitcherViewModel>.reactive(
        viewModelBuilder: () => LanguageSwitcherViewModel(),
        builder: (context, viewModel, child) {
          return Container();
        });
  }
}
