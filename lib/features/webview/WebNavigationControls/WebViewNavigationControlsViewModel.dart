import 'package:berana/shared/services/service_subscription.dart';
import 'package:stacked/stacked.dart';

class WebViewNavigationControlsViewModel
    extends ReactiveViewModel
    with ServiceSubscription
    implements Initialisable {

  @override
  void initialise() {

  }

  @override
  List<ReactiveServiceMixin> get reactiveServices =>
      [
        changeTabService,
        // :TODO add other global services
      ];

}