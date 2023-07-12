import 'package:http/http.dart' as http;

import 'common.dart';

class AudioBookBloc {
  dynamic getAllAudioBooks() async {
    var request = http.Request('GET', Uri.parse('$BASE_URL/api/audiobooks'));


    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    }
    else {
    print(response.reasonPhrase);
    }
  }

  dynamic getOneAudioBook(int audioBookId) async {
    var request = http.Request('GET', Uri.parse('$BASE_URL/api/audiobooks/$audioBookId'));


    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    }
    else {
    print(response.reasonPhrase);
    }
  }

  dynamic getFrontPageAudioBooks(int page) async {
    var request = http.Request('GET', Uri.parse('$BASE_URL/api/audiobooks/pages/$page'));

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    }
    else {
    print(response.reasonPhrase);
    }
  }

  dynamic getAudioBookRatings(int audioBookId) async {
    var request = http.Request('GET', Uri.parse('$BASE_URL/api/audiobooks/$audioBookId/ratings'));


    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    }
    else {
      print(response.reasonPhrase);
    }
  }

  dynamic getAudioBookWishlists(int audioBookId) async {
    var request = http.Request('GET', Uri.parse('$BASE_URL/api/audiobooks/$audioBookId/wishlists'));

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    }
    else {
      print(response.reasonPhrase);
    }
  }

  dynamic getAudioBookPurchases(String accessToken) async {
    var headers = {
      'x-access-token': accessToken
    };
    var request = http.Request('GET', Uri.parse('$BASE_URL/api/audiobooks/1/purchases'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    }
    else {
    print(response.reasonPhrase);
    }
  }

  dynamic getAudioBookCart(String accessToken, int audioBookId) async {
    var headers = {
      'x-access-token': accessToken
    };
    var request = http.Request('GET', Uri.parse('$BASE_URL/api/audiobooks/$audioBookId/cart'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    }
    else {
      print(response.reasonPhrase);
    }
  }
}