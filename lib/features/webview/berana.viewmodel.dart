import 'dart:async';
import 'dart:io';
import 'package:stacked/stacked.dart';
import 'package:webview_flutter/webview_flutter.dart';

class BeranaWebViewModel extends BaseViewModel implements Initialisable {
  String url;
  BeranaWebViewModel({required this.url});

  var platform;
  String _currentUrl = "";
  bool _pageLoading = true;
  WebView? webView;

  String get currentUrl => _currentUrl;
  bool get pageLoading => _pageLoading;

  void setPageLoading(bool value) {
    _pageLoading = value;
    notifyListeners();
  }

  void setCurrentUrl(String url) {
    _currentUrl = url;
    notifyListeners();
  }

  // For Google Login Only
  Future<int> getOAuthStatus(WebViewController controller) async {
    String cookies = await controller.runJavascriptReturningResult('document.cookie');
    List<List<String>> cookiesList =
        cookies.split("\"")[1].split(";").map((e) => e.split("=")).toList();
    for (var cookie in cookiesList) {
      if (cookie[0].trim() == "oauth_status") {
        return int.parse(cookie[1].trim());
      }
    }
    return 0;
  }

  @override
  void initialise() {
    if (Platform.isAndroid) {
      platform = SurfaceAndroidWebView();
      _currentUrl = url;
    }
  }
}
