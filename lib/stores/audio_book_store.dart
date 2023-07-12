import 'package:observable_ish/observable_ish.dart';
import 'package:stacked/stacked.dart';

class AudioBookStore with ReactiveServiceMixin {
  final RxValue<List<String>> _audioBookLinks = RxValue<List<String>>(["http://64.225.74.219/audiobooks/sample1.mp4", "http://64.225.74.219/audiobooks/sample2.mp4"]);
  List<String> get audioBookLinks => _audioBookLinks.value;

  final RxValue<List<List<int>>> _audioBooksCachedInBytes = RxValue(<List<int>>[]);


  void addToAudioBookLinks(String url) {
    _audioBookLinks.value.add(url);
  }

  void addToAudioBooksCachedInBytes(List<int> bytes) {
    // Should be a lazy task not to interrupt main thread
    Future.microtask(() => _audioBooksCachedInBytes.value.add(bytes));
  }

  UserStore() {
    listenToReactiveValues([_audioBookLinks, _audioBooksCachedInBytes]);
  }
}
