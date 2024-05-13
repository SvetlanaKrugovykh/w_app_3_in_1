// lib/services/api_service.dart

import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  Future<List<dynamic>> fetchData(String endpointId) async {
    final String apiUrl = String.fromEnvironment('API_URL',
        defaultValue: 'https://default-api-url.com');
    print(apiUrl);

    String url = '${apiUrl}/$endpointId';
    print(url);

    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data;
    } else {
      throw Exception('Failed to fetch data from $url');
    }
  }
}
