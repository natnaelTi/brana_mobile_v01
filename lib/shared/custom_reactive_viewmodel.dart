import 'package:berana/shared/services/service_subscription.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:stacked/stacked.dart';

class CustomReactiveViewModel extends ReactiveViewModel with ServiceSubscription {
  void showOverlay() {
    (navigationService.navigationKey.currentContext)!.loaderOverlay.show();
  }

  void hideOverlay() {
    (navigationService.navigationKey.currentContext)!.loaderOverlay.hide();
  }

  void showOverlayForDuration({required Duration duration}) {
    (navigationService.navigationKey.currentContext)!.loaderOverlay.show();
    Future.delayed(duration, () {
      (navigationService.navigationKey.currentContext)!.loaderOverlay.hide();
    });
  }
}
