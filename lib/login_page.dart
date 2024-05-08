import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tugas_api/circuit_page.dart';
import 'package:tugas_api/register_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late SharedPreferences prefs;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  String _savedEmail = "";
  String _savedPassword = "";
  String _errorMessage = "";

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
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Login"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(60),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                // Text('$_savedPassword $_savedEmail'),
                TextField(
                  controller: _emailController,
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.grey[200],
                      contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20), // Padding
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10), // Border radius
                      ),
                      hintText: "Masukkan email"
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.grey[200],
                      contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20), // Padding
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10), // Border radius
                      ),
                      hintText: "Masukkan password"
                  ),
                ),
                const SizedBox(height: 60),
                ElevatedButton(
                    onPressed: () {
                      setState(() {
                        if (_emailController.text.isEmpty ||
                            _passwordController.text.isEmpty) {
                          _errorMessage = "Isi semuanya dahulu!";
                          return;
                        }
                        if (_emailController.text == _savedEmail &&
                            _passwordController.text == _savedPassword) {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => CircuitPage()));
                        } else {
                          _errorMessage = "Email atau password salah!";
                        }
                      });
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
                        "Login",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                Text(
                  _errorMessage,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.red,
                  ),
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: ElevatedButton(
            onPressed: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => RegisterPage()));
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
                "Register",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        )
    );
  }
}
