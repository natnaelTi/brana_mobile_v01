import 'package:berana/shared/services/service_subscription.dart';
import 'package:flutter/cupertino.dart';
import 'package:observable_ish/observable_ish.dart';
import 'package:stacked/stacked.dart';

class GenreSelectionViewModel
    extends ReactiveViewModel
    with ServiceSubscription
    implements Initialisable {
  final List<String> _genreSelected = [];
  final List<String> _genre = [
    'biographical',
    'drama',
    'historical',
    'action',
    'adventure',
    'comedy',
    'informative',
    'sci-fi',
    'romance',
    'mystery',
    'horror',
  ];
  final List <String> _genreFiltered = [
    'biographical',
    'drama',
    'historical',
    'action',
    'adventure',
    'comedy',
    'informative',
    'sci-fi',
    'romance',
    'mystery',
    'horror',
  ];

  List<String> get genre => _genre;
  List<String> get genreSelected => _genreSelected;
  List<String> get genreFiltered => _genreFiltered;

  RxValue<String> searchString = RxValue("");


  void addToGenreSelected (String value) {
    if(!genre.contains(value)) return;
    genreSelected.add(value);
    notifyListeners();
  }

  void removeFromSelectedGenre (String value) {
    if(!genreSelected.contains(value)) return;
    genreSelected.remove(value);
    notifyListeners();
  }


  @override
  void initialise() {
    searchString.listen((v) {
      switch(v.length) {
        case 0:
          _genreFiltered.clear();
          _genreFiltered.addAll(_genre);
          notifyListeners();
          break;
        default:
          _genreFiltered.clear();
          _genreFiltered.addAll(_genre.where((element) => element.contains(v)));
          notifyListeners();
          break;
      }
    });
  }
}