import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({super.key});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  late SharedPreferences prefs;

  String _savedEmail = "";
  String _savedPassword = "";
  String _savedTanggalLahir = "";
  @override
  void initState() {
    super.initState();
    initial();
  }

  void initial() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      _savedEmail = prefs.getString('email')!;
      _savedPassword = prefs.getString('password')!;
      _savedTanggalLahir = prefs.getString('tanggalLahir')!;

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Email: $_savedEmail',
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 10),
              Text(
                'Password: $_savedPassword',
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 10),
              Text(
                'Date of Birth: $_savedTanggalLahir',
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 160)
            ],
          ),
        )
      ),
    );
  }
}
