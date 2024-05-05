import 'package:flutter/material.dart';

class VerificationCodeScreen extends StatelessWidget {
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon:
                          const Icon(Icons.arrow_back_ios, color: Colors.white),
                    ),
                    const Text(
                      'رمز التحقق',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    const SizedBox(width: 40.0),
                  ],
                ),
                const SizedBox(height: 50.0),
                const Text(
                  'أدخل رمز التحقق',
                  style: TextStyle(fontSize: 24.0, color: Colors.white),
                ),
                const SizedBox(height: 16.0),
                const Text(
                  'تم إرسال رمز التحقق إلى بريدك الإلكتروني',
                  style: TextStyle(fontSize: 16.0, color: Colors.white),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 32.0),
                const TextField(
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    labelText: 'رمز التحقق',
                    labelStyle: TextStyle(color: Colors.white),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(height: 32.0),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/newpassword');
                  },
                  child: const Text(
                    'تأكيد',
                    style: TextStyle(fontSize: 20),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    minimumSize: const Size(double.infinity, 50),
                  ),
                ),
                SizedBox(height: 300.0),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
