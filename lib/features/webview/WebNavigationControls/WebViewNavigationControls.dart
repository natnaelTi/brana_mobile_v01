import 'dart:async';
import 'package:berana/locator.dart';
import 'package:berana/shared/base_colors.dart';
import 'package:berana/shared/services/navigation_service.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebNavigationControls extends StatelessWidget {
  WebNavigationControls({required this.controller, required this.viewModel});

  final Completer<WebViewController> controller;
  final viewModel;

  final NavigationService _navigationService = locator<NavigationService>();
  final CookieManager cookieManager = CookieManager();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<WebViewController>(
      future: controller.future,
      builder: (context, snapshot) {
        final WebViewController? controller = snapshot.data;
        if (snapshot.connectionState != ConnectionState.done || controller == null) {
          return Visibility(
            visible: false,
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: const <Widget>[
                Icon(Icons.arrow_back_ios),
                Icon(Icons.replay),
                Icon(Icons.arrow_forward_ios),
              ],
            ),
          );
        }

        return Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Visibility(
              maintainAnimation: true,
              maintainState: true,
              maintainSize: true,
              visible: !viewModel.isBusy,
              child: Container(
                height: MediaQuery.of(context).size.height * 0.0843,
                width: MediaQuery.of(context).size.width * 0.33,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    foregroundColor: BaseColors.primaryBerana,
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0.0),
                    ),
                  ),
                  onPressed: () async {
                    if (await controller.canGoBack()) {
                      viewModel.setBusy(true);

                      await controller.goBack().whenComplete(() async {
                        viewModel.setCurrentUrl(await controller.currentUrl());
                      });
                      viewModel.setBusy(false);
                    } else {
                      _navigationService.showSnackBar(description: 'Invalid');
                      return;
                    }
                  },
                  child: Center(
                    child: Icon(Icons.arrow_back_ios, color: Colors.black),
                  ),
                ),
              ),
            ),
            Visibility(
              maintainAnimation: true,
              maintainState: true,
              maintainSize: true,
              visible: !viewModel.isBusy,
              child: Container(
                height: MediaQuery.of(context).size.height * 0.0843,
                width: MediaQuery.of(context).size.width * 0.33,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    foregroundColor: BaseColors.primaryPink,
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0.0),
                    ),
                  ),
                  onPressed: () {
                    viewModel.setBusy(true);
                    controller.reload();
                    viewModel.setBusy(true);
                  },
                  child: Center(
                    child: Icon(Icons.replay, color: Colors.black),
                  ),
                ),
              ),
            ),
            Visibility(
              maintainAnimation: true,
              maintainState: true,
              maintainSize: true,
              visible: !viewModel.learningWebViewPageLoading,
              child: Container(
                height: MediaQuery.of(context).size.height * 0.0843,
                width: MediaQuery.of(context).size.width * 0.33,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    foregroundColor: BaseColors.primaryPink,
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0.0),
                    ),
                  ),
                  onPressed: () async {
                    if (await controller.canGoForward()) {
                      viewModel.setBusy(true);
                      await controller.goForward().whenComplete(() async {
                        viewModel.setCurrentUrl(await controller.currentUrl());
                      });
                      viewModel.setBusy(false);
                    } else {
                      _navigationService.showSnackBar(description: 'Invalid');
                      return;
                    }
                  },
                  child: Center(child: Icon(Icons.arrow_forward_ios, color: Colors.black)),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
