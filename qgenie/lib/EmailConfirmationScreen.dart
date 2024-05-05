import 'package:flutter/material.dart';

class EmailConfirmationScreen extends StatelessWidget {
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
                      'تأكيد البريد الإلكتروني',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    const SizedBox(width: 40.0),
                  ],
                ),
                const SizedBox(height: 50.0),
                const Icon(
                  Icons.email,
                  size: 80,
                  color: Colors.white,
                ),
                const SizedBox(height: 16.0),
                const Text(
                  'تأكيد البريد الإلكتروني',
                  style: TextStyle(fontSize: 24.0, color: Colors.white),
                ),
                const SizedBox(height: 16.0),
                const Text(
                  'تم إرسال رابط التأكيد إلى بريدك الإلكتروني. يرجى فتح البريد والنقر على الرابط لتأكيد حسابك.',
                  style: TextStyle(fontSize: 16.0, color: Colors.white),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 32.0),
                ElevatedButton(
                  onPressed: () {
                    // Check if email is confirmed, then navigate to the appropriate screen
                    // For now, let's assume the email is confirmed and navigate to the home screen
                    Navigator.pushNamedAndRemoveUntil(
                        context, '/home', (route) => false);
                  },
                  child: const Text(
                    'متابعة',
                    style: TextStyle(fontSize: 20),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    minimumSize: const Size(double.infinity, 50),
                  ),
                ),
                const SizedBox(height: 16.0),
                TextButton(
                  onPressed: () {
                    // Resend confirmation email logic
                  },
                  child: const Text(
                    'إعادة إرسال رابط التأكيد',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ),
                const SizedBox(height: 300.0),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
