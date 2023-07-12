import 'package:berana/bloc/common.dart';
import 'package:http/http.dart' as http;

class PaypalBloc {
  dynamic paypalCheckout(String accessToken) async {
    var headers = {
      'x-access-token': accessToken
    };
    var request = http.Request('GET', Uri.parse('$BASE_URL/api/paypal/checkout'));

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