import 'package:berana/bloc/common.dart';
import 'package:berana/bloc/common.dart';
import 'package:http/http.dart' as http;

class AudioBookChapterBloc {
  dynamic getAllAudioBookChapters(String accessToken, int audioBookId) async {
    var headers = {
      'x-access-token': accessToken
    };
    var request = http.Request('GET', Uri.parse('$BASE_URL/api/chapter'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    }
    else {
      print(response.reasonPhrase);
    }
  }

  dynamic getAudioBookChaptersPaginated(String accessToken, int page) async {
    var headers = {
      'x-access-token': ''
    };
    var request = http.Request('GET', Uri.parse('$BASE_URL/api/chapter/pages/$page'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    }
    else {
    print(response.reasonPhrase);
    }

  }

  // :TODO Implement the rest once streaming issue is fixed
}