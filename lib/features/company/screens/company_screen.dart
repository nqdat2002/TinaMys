import 'package:flutter/material.dart';

class CompanyPage extends StatefulWidget {
  const CompanyPage({Key? key}) : super(key: key);

  @override
  State<CompanyPage> createState() => _CompanyPageState();
}

class _CompanyPageState extends State<CompanyPage> {
  Map<String, String> companyDetails = {
    'name': 'LARA Fashion',
    'address': '123 Fashion Street, Style City',
    'phone': '+1 234 567 890',
    'email': 'contact@larafashion.com',
    'website': 'https://www.larafashion.com',
  };
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Company Information'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              companyDetails['name']!,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 16.0),
            Text(
              'Address: ${companyDetails['address']}',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 8.0),
            Text(
              'Phone: ${companyDetails['phone']}',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 8.0),
            Text(
              'Email: ${companyDetails['email']}',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 8.0),
            Text(
              'Website: ${companyDetails['website']}',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                // Navigate to the company website or perform other actions
              },
              child: const Text('Visit Website'),
            ),
          ],
        ),
      ),
    );
  }
}
