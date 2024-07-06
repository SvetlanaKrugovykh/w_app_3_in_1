// goods_screen.dart
import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../services/api_service.dart';
import '../../localization/localization_service.dart';

class GoodsScreen extends StatefulWidget {
  const GoodsScreen({Key? key}) : super(key: key);

  @override
  _GoodsScreenState createState() => _GoodsScreenState();
}

class _GoodsScreenState extends State<GoodsScreen> {
  List<Service> services = [];
  final apiService = ApiService();
  bool isLoading = true;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    _fetchServices();
  }

  Future<void> _fetchServices() async {
    setState(() {
      isLoading = true; // Show loading indicator
      errorMessage = null; // Reset error message
    });

    try {
      final List<dynamic> data = await apiService.fetchData('services');
      setState(() {
        services = data.map((item) => Service.fromJson(item)).toList();
      });
    } catch (e) {
      print('Error fetching services: $e');
      setState(() {
        errorMessage = 'Failed to load services. Please try again.';
      });
    } finally {
      setState(() {
        isLoading = false; // Hide loading indicator
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var localizationService = Provider.of<LocalizationService>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(localizationService.getTranslatedValue('services.title')),
      ),
      body: RefreshIndicator(
        onRefresh: _fetchServices,
        child: ListView.builder(
          itemCount: services.length,
          itemBuilder: (context, index) {
            final service = services[index];
            return ListTile(
              leading: Image.memory(service.image),
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
  final Uint8List image;
  final String name;
  final String description;

  Service({required this.image, required this.name, required this.description});

  factory Service.fromJson(Map<String, dynamic> json) {
    String base64Image = json['image']['content'];
    base64Image = base64Image
        .replaceAll('\n', '')
        .replaceAll('\r', '')
        .replaceAll(' ', '');
    return Service(
        image: base64Decode(base64Image),
        name: json['name'],
        description: json['image']['fileName']);
  }
}
