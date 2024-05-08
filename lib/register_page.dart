import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';
import 'package:tugas_api/login_page.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _password1Controller = TextEditingController();
  final _dateController = TextEditingController();
  String _errorMessage = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Register"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(60),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextField(
                  controller: _emailController,
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.grey[200],
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 15, horizontal: 20), // Padding
                      border: OutlineInputBorder(
                        borderRadius:
                            BorderRadius.circular(10), // Border radius
                      ),
                      hintText: "Masukkan Email"),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.grey[200],
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 15, horizontal: 20), // Padding
                      border: OutlineInputBorder(
                        borderRadius:
                            BorderRadius.circular(10), // Border radius
                      ),
                      hintText: "Masukkan password"),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: _password1Controller,
                  obscureText: true,
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.grey[200],
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 15, horizontal: 20), // Padding
                      border: OutlineInputBorder(
                        borderRadius:
                            BorderRadius.circular(10), // Border radius
                      ),
                      hintText: "Masukkan password lagi"),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller:
                      _dateController, //editing controller of this TextField
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 15, horizontal: 20), // Padding
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                    icon: const Icon(Icons.calendar_today), //icon of text field
                    labelText: "Masukkan Tanggal Lahir",
                    //label text of field
                  ),
                  readOnly: true, // when true user cannot edit text
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(), //get today's date
                        firstDate: DateTime(
                            1945), //DateTime.now() - not to allow to choose before today.
                        lastDate: DateTime(2025));
                    if (pickedDate != null) {
                      String formattedDate = DateFormat('yyyy-MM-dd').format(
                          pickedDate); // format date in required form here we use yyyy-MM-dd that means time is removed

                      setState(() {
                        _dateController.text =
                            formattedDate; //set foratted date to TextField value.
                      });
                    }
                  },
                ),
                const SizedBox(height: 30),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      if (_dateController.text.isEmpty ||
                          _passwordController.text.isEmpty ||
                          _password1Controller.text.isEmpty ||
                          _emailController.text.isEmpty) {
                        _errorMessage = "Masih ada yang kosong!";
                        return;
                      }

                      if (_passwordController.text !=
                          _password1Controller.text) {
                        _errorMessage = "Password harus sama";
                        return;
                      }
                      String password = _passwordController.text;

                      String email = _emailController.text;
                      if (!_isEmailValid(email)) {
                        _errorMessage = "email tdk valid";
                        return;
                      }

                      String tanggalLahir = _dateController.text;

                      _setSession(email, password, tanggalLahir);
                      _errorMessage = "";
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text("Register berhasil! Silakan Login")));
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(10), // Make button squarer
                    ),
                  ),
                  child: Container(
                    width: double
                        .infinity, // Set button width to match parent width
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
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => LoginPage()));
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
        ));
  }

  bool _isEmailValid(String email) {
    const pattern = r"(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'"
        r'*+/=?^_`{|}~-]+)*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-'
        r'\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*'
        r'[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:(2(5[0-5]|[0-4]'
        r'[0-9])|1[0-9][0-9]|[1-9]?[0-9]))\.){3}(?:(2(5[0-5]|[0-4][0-9])|1[0-9]'
        r'[0-9]|[1-9]?[0-9])|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\'
        r'x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])';
    final regex = RegExp(pattern);
    return email.isNotEmpty && !regex.hasMatch(email) ? false : true;
  }

  Future<void> _setSession(
      String email, String password, String tanggalLahir) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('email', email);
    prefs.setString('password', password);
    prefs.setString('tanggalLahir', tanggalLahir);
  }
}
