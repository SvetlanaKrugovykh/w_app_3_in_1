// lib/services/api_service.dart

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiService {
  Future<List<dynamic>> fetchData(String endpointId) async {
    await dotenv.load(fileName: '.env');
    String apiKey = dotenv.get('API_KEY');
    String url = '${apiKey}/$endpointId';
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
