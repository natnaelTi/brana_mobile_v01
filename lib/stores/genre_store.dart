import 'package:get_storage/get_storage.dart';
import 'package:observable_ish/observable_ish.dart';
import 'package:stacked/stacked.dart';

class GenreStore with ReactiveServiceMixin {
  GetStorage sharedPrefs = GetStorage();
  final RxValue<List<String>> _genre = RxValue([]);
  static const GENRE_PERSISTENT_KEY = "BERANA_GENRE_KEY";
  List<String> get genreList => _genre.value;

  List<String> retrieveGenre() {
    List<String> genre = genreList;
    if (genre.isNotEmpty) return genre;
    genre = sharedPrefs.read(GENRE_PERSISTENT_KEY) ?? [];
    if (genre.isNotEmpty) setGenre(genreList: genre);
    return genre;
  }

  void setGenre({required List<String> genreList}) {
    _genre.value = genreList;
    sharedPrefs.write(GENRE_PERSISTENT_KEY, genreList);
    notifyListeners();
  }

  GenreStore() {
    listenToReactiveValues([_genre]);
  }
}
