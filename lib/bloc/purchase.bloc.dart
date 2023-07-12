import 'package:berana/bloc/common.dart';
import 'package:berana/bloc/common.dart';
import 'package:berana/bloc/common.dart';
import 'package:http/http.dart' as http;

class PurchaseBloc {
  dynamic getPurchases(String accessToken) async {
    var headers = {
      'x-access-token': accessToken
    };
    var request = http.Request('GET', Uri.parse('$BASE_URL/api/purchase'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    }
    else {
    print(response.reasonPhrase);
    }
  }

  dynamic getPurchasesPaginated(String accessToken, int page) async {
    var headers = {
      'x-access-token': accessToken
    };
    var request = http.Request('GET', Uri.parse('$BASE_URL/api/purchase/pages/$page'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    }
    else {
    print(response.reasonPhrase);
    }
  }

  dynamic getPurchase(String accessToken, int purchaseId) async {
    var headers = {
      'x-access-token': accessToken
    };
    var request = http.Request('GET', Uri.parse('$BASE_URL/api/purchase/26'));

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