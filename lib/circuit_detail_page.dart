import 'package:flutter/material.dart';
import 'package:tugas_api/model/circuit.dart';
import 'package:url_launcher/url_launcher.dart';

class CircuitDetailPage extends StatelessWidget {
  final Circuits circuit;

  CircuitDetailPage({required this.circuit});

  Future <void> _launchURL(String url) async{
    final Uri _url = Uri.parse(url);
    if(!await launchUrl(_url)){
      throw "Couldn't launch url";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Circuit Detail'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              circuit.circuitName ?? '',
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            const Text(
              'Location:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 5),
            Text(
              '${circuit.location?.locality ?? ''}, ${circuit.location?.country ?? ''}',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 10),
            Text(
              'Latitude: ${circuit.location?.lat ?? ''}',
              style: const TextStyle(fontSize: 18),
            ),
            Text(
              'Longitude: ${circuit.location?.long ?? ''}',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _launchURL(circuit.url ?? '');
              },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10), // Make button squarer
                ),
              ),
              child: Container(
              width: double.infinity, // Set button width to match parent width
              height: 55, // Set button height
              padding: const EdgeInsets.all(10), // Set padding
              child: const Center(
                child: Text(
                  "See Details (Wikipedia)",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            ),
          ],
        ),
      ),
    );
  }
}