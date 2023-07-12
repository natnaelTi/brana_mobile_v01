import 'package:observable_ish/observable_ish.dart';
import 'package:stacked/stacked.dart';

class AudioVideoPlayerService with ReactiveServiceMixin {
  RxValue<Stream> _videoStream = RxValue<Stream>(new Stream.fromIterable([]));

  Stream get videoStream => _videoStream.value;

  void setVideoStream(Stream stream) {
    _videoStream.value = stream;
  }

  AudioVideoPlayerService() {
    listenToReactiveValues([
      _videoStream,
    ]);
  }
}