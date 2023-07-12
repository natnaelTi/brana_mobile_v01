import 'package:berana/features/signin_selection/signin_selection_viewmodel.dart';
import 'package:berana/layouts/root_layout/root_layout.dart';
import 'package:flutter/cupertino.dart';
import 'package:stacked/stacked.dart';

class SignInSelectionView extends StatelessWidget {
  const SignInSelectionView({super.key});
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SignInSelectionViewModel>.reactive(
        viewModelBuilder: () => SignInSelectionViewModel(),
        builder: ((context, viewModel, child) {
          return RootLayout(child: const Text('test'));
        }));
  }
}
