import 'dart:async';

import 'package:berana/features/webview/berana.viewmodel.dart';
import 'package:berana/helpers.dart';
import 'package:berana/shared/base_colors.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:berana/locator.dart';
import 'package:berana/shared/services/dialogue_service.dart';
import 'package:berana/shared/services/navigation_service.dart';

class BeranaWebView extends StatelessWidget {
  BeranaWebView(
      {
        required this.url,
        this.pageRequested,
        this.showBackButton = true,
      });

  final String url;
  final bool showBackButton;
  final String? pageRequested;

  final NavigationService _navigationService = locator<NavigationService>();
  final DialogueService _dialogueService = locator<DialogueService>();
  final Completer<WebViewController> controller = Completer<WebViewController>();
  final CookieManager cookieManager = CookieManager();

  Future<bool> onWillPop({BuildContext? context}) async {
    DateTime? currentBackPressTime;

    DateTime now = DateTime.now();

    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime) > Duration(seconds: 2)) {
      currentBackPressTime = now;
      var confirmed = await _dialogueService.showConfirmationDialog(
        title: 'Are you sure you want to exit',
        description: 'Confirm by clicking Ok',
        context: context,
      );
      if (confirmed.confirmed) {
        _navigationService.pop();
      }
      return Future.value(false);
    }
    return Future.value(true);
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<BeranaWebViewModel>.reactive(
        viewModelBuilder: () => BeranaWebViewModel(url: url),
        builder: (context, viewModel, child) {
          double height = MediaQuery.of(context).size.height;
          return WillPopScope(
            onWillPop: onWillPop,
            child: Scaffold(
              resizeToAvoidBottomInset: false,
              bottomNavigationBar: Container(
                height: height * 0.0855,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border(
                    top: BorderSide(
                      color: BaseColors.primaryBerana,
                      width: 1.0,
                    ),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // :TODO add navigiation controls here
                      ],
                    ),
                  ],
                ),
              ),
              appBar: AppBar(
                leading: showBackButton
                    ? IconButton(
                        onPressed: () {
                          onWillPop(context: context);
                        },
                        icon: Icon(Icons.arrow_back_ios),
                        //replace with our own icon data.
                      )
                    : null,
                foregroundColor: Colors.black,
                backgroundColor: Colors.white,
                title: Text( pageRequested ?? "Google Login"),
                actions: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(8.0, 8.0, 16.0, 8.0),
                    child: viewModel.pageLoading
                        ? Container()
                        : InkWell(
                            splashColor: BaseColors.quinaryGreen,
                            onTap: () async {
                              var tempController = await controller.future;
                              var oAuthStatus = await viewModel.getOAuthStatus(tempController);
                              viewModel.setPageLoading(true);
                              var curUrl = await tempController.currentUrl();

                              if(oAuthStatus != null) {
                                _navigationService.showSnackBar(
                                    description: 'Failed to Login using Google OAuth'
                                );
                              }
                              //:TODO get oauth url from Sami
                              viewModel.setCurrentUrl("");
                              viewModel.setPageLoading(false);
                            },
                            child: Ink(
                              padding: EdgeInsets.all(8.0),
                              child: Icon(
                                Icons.shopping_cart,
                                color: Colors.black,
                              ),
                            ),
                          ),
                  ),
                ],
                centerTitle: true,
              ),
              body: Column(
                children: [
                  Container(
                    height: height * 0.737,
                    child: Stack(
                      children: [
                        WebView(
                          navigationDelegate: (navigation) {
                            final parsedUrl = Uri.parse(navigation.url);
                            final host = parsedUrl.host;
                            final path = parsedUrl.path;

                            // :TODO handle navigation decisions here

                            viewModel.setCurrentUrl(navigation.url);
                            return NavigationDecision.navigate;
                          },
                          initialUrl: url,
                          onWebViewCreated: (webViewController) async {
                            controller.complete(webViewController);
                            var tempController = await controller.future;
                          },
                          onPageFinished: (url) async {
                            viewModel.setPageLoading(true);
                            var tempController = await controller.future;
                            //:TODO disable some js here to block some google bg services since oauth popup slows down the app
                            await tempController.runJavascriptReturningResult("""
                                 
                              """);
                            viewModel.setPageLoading(false);
                          },
                          onWebResourceError: (error) {
                            _navigationService.showErrorDialogue(
                                title: 'Error', description: 'Error Occurred');
                          },
                          onProgress: (progress) {
                            viewModel.setPageLoading(true);
                            if (progress == 100) {
                              viewModel.setPageLoading(false);
                            }
                          },
                          javascriptMode: JavascriptMode.unrestricted,
                          zoomEnabled: false,
                          gestureNavigationEnabled: true,
                        ),
                        if (viewModel.pageLoading == true) loadingSpinner,
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
