import 'package:flutter/material.dart';
import '../../services/api_service.dart';

class GoodsScreen extends StatefulWidget {
  const GoodsScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _GoodsScreenState createState() => _GoodsScreenState();
}

class _GoodsScreenState extends State<GoodsScreen> {
  List<Service> services = [];

  @override
  void initState() {
    super.initState();
    fetchServices();
  }

  final apiService = ApiService();
  Future<void> fetchServices() async {
    try {
      final List<dynamic> data = await apiService.fetchData('services');
      setState(() {
        services = data.map((item) => Service.fromJson(item)).toList();
      });
    } catch (e) {
      throw Exception('Failed to fetch services');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Services'),
      ),
      body: RefreshIndicator(
        onRefresh: fetchServices,
        child: ListView.builder(
          itemCount: services.length,
          itemBuilder: (context, index) {
            final service = services[index];
            return ListTile(
              leading: Image.network(service.imageUrl),
              title: Text(service.name),
              subtitle: Text(service.description),
            );
          },
        ),
      ),
    );
  }
}

class Service {
  final String imageUrl;
  final String name;
  final String description;

  Service(
      {required this.imageUrl, required this.name, required this.description});

  factory Service.fromJson(Map<String, dynamic> json) {
    return Service(
      imageUrl: json['imageUrl'],
      name: json['name'],
      description: json['description'],
    );
  }
}
