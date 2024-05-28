import 'package:flutter/material.dart';
import '../../services/api_service.dart';

class GoodsScreen extends StatefulWidget {
  const GoodsScreen({Key? key}) : super(key: key);

  @override
  _GoodsScreenState createState() => _GoodsScreenState();
}

class _GoodsScreenState extends State<GoodsScreen> {
  List<Service> services = [];
  final apiService = ApiService();

  @override
  void initState() {
    super.initState();
    _fetchServices();
  }

  Future<void> _fetchServices() async {
    try {
      final List<dynamic> data = await apiService.fetchData('services');
      setState(() {
        services =
            data.map((item) => Service.fromJson(item)).cast<Service>().toList();
      });
    } catch (e) {
      print('Error fetching services: $e');
      // You can handle the error here, e.g., show a snackbar
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Services'),
      ),
      body: RefreshIndicator(
        onRefresh: _fetchServices,
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
