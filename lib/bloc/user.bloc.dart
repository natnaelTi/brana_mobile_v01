import 'package:berana/bloc/common.dart';
import 'package:http/http.dart' as http;

class UserBloc {

  dynamic getProfile (
    String accessToken
  ) async {
    var headers = {
      'x-access-token': accessToken
    };
    var request = http.Request('GET', Uri.parse('$BASE_URL/api/account/profile'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    }
    else {
    print(response.reasonPhrase);
    }
  }

  dynamic getRatings(
      String accessToken
  ) async {
    var headers = {
      'x-access-token': accessToken
    };
    var request = http.Request('GET', Uri.parse('$BASE_URL/api/account/ratings'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    }
    else {
      print(response.reasonPhrase);
    }
  }

  dynamic getWishlists(
      String accessToken
  ) async {
    var headers = {
      'x-access-token': accessToken
    };
    var request = http.Request('GET', Uri.parse('$BASE_URL/api/account/wishlists'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    }
    else {
    print(response.reasonPhrase);
    }
  }

  dynamic getCart(
      String accessToken
  ) async {
    var headers = {
      'x-access-token': accessToken
    };
    var request = http.Request('GET', Uri.parse('$BASE_URL/api/account/cart'));

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