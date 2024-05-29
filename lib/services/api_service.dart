import 'dart:convert';
import 'package:http/http.dart' as http;
import '../data/env_constants.dart';

class ApiService {
  Future<List<dynamic>> fetchData(String endpointId) async {
    String url = API_URL;
    String uriAuthorization = API_AUTHORIZATION;
    String query = QUERY;

    final body = {"Query": query};

    final headers = {
      'Content-Type': 'application/json',
      'Authorization': uriAuthorization,
    };
    print(url);

    try {
      final response = await http.post(
        Uri.parse(url),
        body: json.encode(body), // Encode your body to JSON
        headers: {
          ...headers,
          'Content-Type': 'application/json', // Ensure the content type is JSON
        },
      );
      print(response.statusCode);
      if (response.statusCode == 200) {
        final Map<String, dynamic> body = json.decode(response.body);
        final List<dynamic> data = body['ResponseArray'];
        return data;
      } else {
        throw Exception('Failed to fetch data from $url');
      }
    } catch (error) {
      print('Error: $error');
      throw Exception('Failed to fetch data from $url');
    }
  }
}
