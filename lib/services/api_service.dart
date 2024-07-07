import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:logging/logging.dart';
import '../data/env_constants.dart';

final Logger logger = Logger('apiServiceLogger');

class ApiService {
  Future<List<dynamic>> fetchData(String endpointId) async {
    Logger.root.level = Level.ALL;
    String url = API_URL;
    String uriAuthorization = API_AUTHORIZATION;
    String query = QUERY;

    final body = {"Query": query};

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': uriAuthorization,
        },
        body: jsonEncode(body),
      );

      logger.warning('Status Code: ${response.statusCode}');

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseBody = json.decode(response.body);
        final List<dynamic> data = responseBody['ResponseArray'];
        return data;
      } else {
        throw http.ClientException(
            'Failed to fetch data from $url, Status code: ${response.statusCode}');
      }
    } catch (error) {
      logger.warning('Error: $error');
      throw http.ClientException(
          'Failed to fetch data from $url, Error: $error');
    }
  }

  Future<void> sendUserData(Map<String, dynamic> userData) async {
    Logger.root.level = Level.ALL;
    String url = API_URL;
    String uriAuthorization = API_AUTHORIZATION;

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': uriAuthorization,
        },
        body: jsonEncode(userData),
      );

      if (response.statusCode == 200) {
        logger.warning('User data sent successfully');
      } else {
        logger.warning(
            'Failed to send user data, Status code: ${response.statusCode}');
      }
    } catch (error) {
      logger.warning('Error sending user data: $error');
    }
  }
}
