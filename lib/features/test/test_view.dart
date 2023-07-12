import 'dart:developer' as dv;
import 'dart:math';

import 'package:berana/features/test/test_viewmodel.dart';
import 'package:berana/layouts/root_layout/root_layout.dart';
import 'package:berana/shared/base_colors.dart';
import 'package:berana/widgets/berana_button.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class TestView extends StatelessWidget {
  const TestView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<TestViewModel>.reactive(
        viewModelBuilder: () => TestViewModel(),
        builder: ((context, viewModel, child) {
          return RootLayout(
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                      onPressed: () {
                        viewModel.setBusy(true);
                      }, child: Text('Make Busy')
                  ),
                  Text('Busy Status: ${viewModel.isBusy}'),
                  BeranaButton(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.black,
                      pressedFunc: () {
                        dv.log('test');
                      },
                      isLoading: viewModel.isBusy,
                      child: Center(
                          child: Text('test')
                      ),
                  )
                ]
              ),
            ),
          );
        }));
  }

}