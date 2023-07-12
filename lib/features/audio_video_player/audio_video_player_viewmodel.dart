import 'package:berana/shared/services/service_subscription.dart';
import 'package:stacked/stacked.dart';
import 'package:video_player/video_player.dart';

class AudioVideoPlayerViewModel extends ReactiveViewModel with ServiceSubscription, Initialisable {

  String _url = "";
  String get url => _url;
  void setUrl(String value) {
    _url = value;
    notifyListeners();
  }

  late VideoPlayerController _videoPlayerController;
  VideoPlayerController get videoPlayerController => _videoPlayerController;


  @override
  List<ReactiveServiceMixin> get reactiveServices => [];

  @override
  void initialise() {
    _videoPlayerController = VideoPlayerController.network(url);
    _videoPlayerController.initialize();
    _videoPlayerController.setLooping(true);
    _videoPlayerController.play();
  }
}