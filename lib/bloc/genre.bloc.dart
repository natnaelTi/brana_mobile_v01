import 'package:berana/bloc/common.dart';
import 'package:berana/bloc/common.dart';
import 'package:berana/bloc/common.dart';
import 'package:http/http.dart' as http;

class GenreBloc {
  dynamic getAllGenre() async {
    var request = http.Request('GET', Uri.parse('$BASE_URL/api/genre'));


    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    }
    else {
    print(response.reasonPhrase);
    }
  }

  dynamic getGenrePaginated(int page) async {
    var request = http.Request('GET', Uri.parse('$BASE_URL/api/genre/pages/$page'));


    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    }
    else {
      print(response.reasonPhrase);
    }
  }

  dynamic getOneGenre(int page) async {
    var request = http.Request('GET', Uri.parse('$BASE_URL/api/genre/1'));


    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    }
    else {
      print(response.reasonPhrase);
    }
  }
}