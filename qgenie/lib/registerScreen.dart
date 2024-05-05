import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:qgenie/Globals.dart';

class RegisterScreen extends StatelessWidget {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final firstNamerController = TextEditingController();
  final lastNameController = TextEditingController();
  final cpasswordController = TextEditingController();

  Future<void> signUpUser(
    String email,
    String password,
    String confirmPassword,
    String firstName,
    String lastName,
    BuildContext context,
  ) async {
    final url = Uri.parse('http://${server}:${port}/users/signup/');
    print('Request URL: $url');
    try {
      final response = await http.post(
        url,
        body: jsonEncode({
          'email': email,
          'password': password,
          'cpassword': confirmPassword,
          'first_name': firstName,
          'last_name': lastName,
        }),
        headers: {'Content-Type': 'application/json'},
      );

      print('Response status code: ${response.statusCode}');

      if (response.statusCode == 200) {
        Map data = jsonDecode(response.body);
        String createdEmail = data["email"];

        print('Account created for email: $createdEmail');

        if (createdEmail.isNotEmpty) {
          Navigator.pushNamed(context, '/login');
        }
      } else {
        print('Failed to create account');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Failed to create account'),
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
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
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
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 20.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon:
                          const Icon(Icons.arrow_back_ios, color: Colors.white),
                    ),
                    const Text(
                      'تسجيل',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    const SizedBox(width: 40.0),
                  ],
                ),
                const SizedBox(height: 10.0),
                const Text(
                  'سجل هنا',
                  style: TextStyle(fontSize: 30.0, color: Colors.white),
                ),
                TextField(
                  style: const TextStyle(color: Colors.white),
                  controller: firstNamerController,
                  textAlign: TextAlign.right,
                  decoration: const InputDecoration(
                    labelText: 'الاسم الأول',
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
                const SizedBox(height: 10.0),
                TextField(
                  style: const TextStyle(color: Colors.white),
                  controller: lastNameController,
                  textAlign: TextAlign.right,
                  decoration: const InputDecoration(
                    labelText: 'الاسم الأخير',
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
                const SizedBox(height: 10.0),
                TextField(
                  style: const TextStyle(color: Colors.white),
                  controller: emailController,
                  textAlign: TextAlign.right,
                  decoration: const InputDecoration(
                    labelText: 'البريد الإلكتروني',
                    labelStyle: TextStyle(color: Colors.white),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    prefixIcon: Icon(Icons.email, color: Colors.white),
                  ),
                ),
                const SizedBox(height: 10.0),
                TextField(
                  style: const TextStyle(color: Colors.white),
                  controller: passwordController,
                  textAlign: TextAlign.right,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: 'كلمة المرور',
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
                const SizedBox(height: 10.0),
                TextField(
                  style: const TextStyle(color: Colors.white),
                  controller: cpasswordController,
                  textAlign: TextAlign.right,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: 'تاكيد كلمة المرور',
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
                const SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () {
                    print('Email: ${emailController.text}');
                    print('Password: ${passwordController.text}');
                    print('Confirm Password: ${cpasswordController.text}');
                    print('First Name: ${firstNamerController.text}');
                    print('Last Name: ${lastNameController.text}');
                    signUpUser(
                      emailController.text,
                      passwordController.text,
                      cpasswordController.text,
                      firstNamerController.text,
                      lastNameController.text,
                      context,
                    );
                  },
                  child: Text(
                    'إنشاء حساب',
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
                const SizedBox(height: 50.0),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
