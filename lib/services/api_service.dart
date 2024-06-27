import 'dart:io';
import 'dart:convert';
import '../data/env_constants.dart';

class ApiService {
  Future<List<dynamic>> fetchData(String endpointId) async {
    String url = API_URL;
    String uriAuthorization = API_AUTHORIZATION;
    String query = QUERY;

    final body = {"Query": query};

    try {
      HttpClient client = HttpClient();
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      HttpClientRequest request = await client.postUrl(Uri.parse(url));
      request.headers.set('Content-Type', 'application/json');
      request.headers.set('Authorization', uriAuthorization);
      request.headers.set('Access-Control-Allow-Origin', '*');
      request.headers.set('Access-Control-Allow-Methods', 'GET, POST, OPTIONS');
      request.headers
          .set('Access-Control-Allow-Headers', 'Content-Type, Authorization');

      request.add(utf8.encode(json.encode(body)));
      HttpClientResponse response = await request.close();
      print('Status Code: ${response.statusCode}');

      if (response.statusCode == 200) {
        final responseBody = await response.transform(utf8.decoder).join();
        final Map<String, dynamic> body = json.decode(responseBody);
        final List<dynamic> data = body['ResponseArray'];
        return data;
      } else {
        throw HttpException(
            'Failed to fetch data from $url, Status code: ${response.statusCode}');
      }
    } catch (error) {
      print('Error: $error');
      throw HttpException(
          'Failed to fetch data from $url, Status code: ${error.toString()}');
    }
  }
}

class HttpOverridesBypassSSL extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
