import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:qgenie/Globals.dart';

class LoginScreen extends StatelessWidget {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  Future<void> loginUser(
      String email, String password, BuildContext context) async {
    final url = Uri.parse('http://${server}:${port}/users/login/');
    print('Request URL: $url');
    try {
      final response = await http.post(
        url,
        body: jsonEncode({'email': email, 'password': password}),
        headers: {'Content-Type': 'application/json'},
      );

      print('Response status code: ${response.statusCode}');

      if (response.statusCode == 200) {
        Map data = jsonDecode(response.body);
        token = data["token"];

        print('Account exists');

        print(token);
        if (token != "") {
          Navigator.pushNamed(context, '/home');
        }
      } else {
        print('Account does not exist or login failed');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Incorrect email or password'),
          ),
        );
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              const Color(0xFF00224F),
              Colors.blue.shade300,
            ],
          ),
        ),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 20.0),
                const Text(
                  'تسجيل دخول',
                  style: TextStyle(fontSize: 20.0, color: Colors.white),
                ),
                const SizedBox(height: 50.0),
                const Text(
                  'مرحبا بكم مجددا',
                  style: TextStyle(fontSize: 30.0, color: Colors.white),
                ),
                const SizedBox(height: 16.0),
                TextField(
                  controller: emailController,
                  textAlign: TextAlign.right,
                  decoration: const InputDecoration(
                    labelText: 'حساب',
                    labelStyle: TextStyle(color: Colors.white),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    prefixIcon: Icon(Icons.person, color: Colors.white),
                  ),
                ),
                const SizedBox(height: 16.0),
                TextField(
                  controller: passwordController,
                  textAlign: TextAlign.right,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: 'كلمة السر',
                    labelStyle: TextStyle(color: Colors.white),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    prefixIcon: Icon(Icons.lock, color: Colors.white),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/forgetpassword');
                  },
                  child: const Text(
                    'نسيت كلمة السر؟',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ),
                const SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () {
                    loginUser(
                        emailController.text, passwordController.text, context);
                  },
                  child: Text(
                    'تسجيل الدخول',
                    style: TextStyle(fontSize: 20),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    minimumSize: const Size(double.infinity, 50),
                  ),
                ),
                const SizedBox(height: 16.0),
                const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Expanded(
                      child: Divider(
                        color: Colors.white,
                        thickness: 1.0,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        'أو',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    Expanded(
                      child: Divider(
                        color: Colors.white,
                        thickness: 1.0,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16.0),
                ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.facebook, color: Colors.white),
                  label: const Text(
                    'Facebook',
                    style: TextStyle(color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF3F51B5).withOpacity(0.8),
                    minimumSize: const Size(double.infinity, 50),
                  ),
                ),
                const SizedBox(height: 16.0),
                ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.email, color: Colors.white),
                  label: const Text(
                    'Gmail',
                    style: TextStyle(color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF3F51B5).withOpacity(0.8),
                    minimumSize: const Size(double.infinity, 50),
                  ),
                ),
                const SizedBox(height: 16.0),
                const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Expanded(
                      child: Divider(
                        color: Colors.white,
                        thickness: 1.0,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        'ليس لديك حساب؟  ',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Divider(
                        color: Colors.white,
                        thickness: 1.0,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16.0),
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/register');
                  },
                  child: const Text(
                    'انشاء حساب جديد',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                ),
                const SizedBox(height: 200.0),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
