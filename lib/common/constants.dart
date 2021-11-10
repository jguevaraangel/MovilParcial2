import 'package:http/http.dart' as http;

const String API_KEY = "e6f82161a21e6d20cdb1d8f70610c7c2";

Uri.parse("https://randomuser.me/api").resolveUri(Uri(queryParameters: {
      "format": 'json',
      "results": "1",
