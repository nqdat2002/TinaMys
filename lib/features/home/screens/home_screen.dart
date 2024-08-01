import 'package:flutter/material.dart';
import 'package:tinamys/services/user/user_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Map<String, dynamic>? _profile;
  late UserServices userServices;

  Future<void> fetchData() async {
    final response = await userServices.getUserProfile();
    setState(() {
      _profile = response['data'];
    });
  }

  @override
  void initState() {
    super.initState();
    userServices = UserServices();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: _profile == null
          ? const Center(child: CircularProgressIndicator())
          : Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Welcome, ${_profile!['username']}!'),
            const SizedBox(height: 16.0),
            Text('Email: ${_profile!['email']}'),
          ],
        ),
      ),
    );
  }
}
