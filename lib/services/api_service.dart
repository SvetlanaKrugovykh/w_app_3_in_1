import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart' show rootBundle;
import 'dart:io';

class ApiService {
  Future<List<dynamic>> fetchData(String endpointId) async {
    final filePath = 'data/env_constants.json';
    final file = File(filePath);

    if (await file.exists()) {
      print('File $filePath exists');
    } else {
      print('File $filePath does not exist');
      return [];
    }

    final directory = Directory('data');
    print('Contents of directory ${directory.path}:');
    final files = directory.listSync();
    for (var file in files) {
      print(file.path);
    }
    String jsonString = await file.readAsString();
    Map<String, dynamic> envConstants = jsonDecode(jsonString);

    final String apiUrl = envConstants['API_URL'];
    print(apiUrl);

    String url = '${apiUrl}';
    print(url);

    final body = {"Query": envConstants['QUERY']};
    String URI_AUTHORIZATION = envConstants['URI_AUTHORIZATION'];
    print(URI_AUTHORIZATION);

    final headers = {
      'Content-Type': 'application/json',
      'Authorization': URI_AUTHORIZATION,
    };

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
