import 'package:flutter/material.dart';
import 'package:tugas_api/circuit_detail_page.dart';
import 'package:tugas_api/detail_page.dart';
import 'package:tugas_api/model/circuit.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import 'login_page.dart';


class CircuitPage extends StatefulWidget {
  const CircuitPage({super.key});

  @override
  State<CircuitPage> createState() => _CircuitPageState();
}

class _CircuitPageState extends State<CircuitPage> {
  List<Circuits> circuits = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchCircuits();
  }

  Future<void> fetchCircuits() async {
    var url = Uri.parse('http://ergast.com/api/f1/circuits.json?limit=300');
    var response = await http.get(url);

    if (response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(response.body);
      var circuitsData = jsonResponse['MRData']['CircuitTable']['Circuits'];

      setState(() {
        circuits = List<Circuits>.from(circuitsData.map((x) => Circuits.fromJson(x)));
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Circuit List'),
        actions: [
          IconButton(
            icon: const Icon(Icons.account_circle),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const DetailPage()),
              );
            },
          ),
        ],
      ),
      body: isLoading
          ? const Center(
        child: CircularProgressIndicator(), // Show loading indicator if data is loading
      )
          : ListView.builder(
        itemCount: circuits.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CircuitDetailPage(circuit: circuits[index])),
              );
            },
            child: Card(
              elevation: 2,
              margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: ListTile(
                  title: Text(
                    circuits[index].circuitName ?? '',
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 5),
                      Text(
                        'Location: ${circuits[index].location?.locality ?? ''}, ${circuits[index].location?.country ?? ''}',
                        style: const TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                  trailing: const Icon(Icons.keyboard_arrow_right),
                ),
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: BottomAppBar(
        child: SizedBox(
          height: 50,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                icon: const Icon(Icons.exit_to_app),
                onPressed: () {
                  // Clear user session and navigate to login page
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => LoginPage()), // Change LoginPage to your actual login page
                  );
                },
              ),
              const SizedBox(width: 16),
            ],
          ),
        ),
      ),
    );
  }
}

