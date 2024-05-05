import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:qgenie/EmailConfirmationScreen.dart';
import 'package:qgenie/ForgotPasswordScreen.dart';
import 'package:qgenie/Globals.dart';
import 'package:qgenie/LoginScreen.dart';
import 'package:qgenie/ResetPasswordScreen.dart';
import 'package:qgenie/VerificationCodeScreen.dart';
import 'package:qgenie/registerScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'My App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/login',
      routes: {
        '/login': (context) => LoginScreen(),
        '/home': (context) => HomeScreen(),
        '/register': (context) => RegisterScreen(),
        '/forgetpassword': (context) => ForgotPasswordScreen(),
        '/verification': (context) => VerificationCodeScreen(),
        '/newpassword': (context) => ResetPasswordScreen(),
        '/confirmemail': (context) => EmailConfirmationScreen(),
      },
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final inputController = TextEditingController();
  final answerController = TextEditingController();
  String soual = "السؤال";
  Future<String?> simpleQuestion(
      String context_, String answer, BuildContext context) async {
    final url = Uri.parse('http://${server}:${port}/quizzes/question/');
    //print('Request URL: $url');
    try {
      final response = await http.post(
        url,
        body: jsonEncode({
          'text': context_,
          'answer': answer,
          'lang': 'arabic',
          'session': 1
        }),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Token $token'
        },
      );

      //print('Response status code: ${response.statusCode}');

      if (response.statusCode == 200) {
        Map data = jsonDecode(utf8.decode(response.body.runes.toList()));

        String question = data["question"];

        if (question != "") {
          return question;
        }
      } else {
        //print('wrong input');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Incorrect input'),
          ),
        );
      }
    } catch (e) {
      //print('Error: $e');
    }
    return null;
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
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/login');
                      },
                      icon:
                          const Icon(Icons.arrow_back_ios, color: Colors.white),
                    ),
                    const Text(
                      'مولد الاسئلة',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    const SizedBox(width: 50.0),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                const SizedBox(height: 8.0),
                const Text(
                  'السؤال الجيد هو السؤال الذي يساعد الطالب على فهم المادة الدراسية بشكل أفضل، ويحفزه على التفكير والاستنتاج والتحليل. وينبغي أن يكون السؤال واضحًا ومحددًا، وأن يتناسب مع مستوى الطلبة ومع المادة الدراسية.',
                  style: TextStyle(fontSize: 16.0, color: Colors.white),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16.0),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: Colors.blue.shade300,
                  ),
                  height: 170,
                  child: Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Expanded(
                              child: TextField(
                                controller: inputController,
                                maxLines: null,
                                textAlign: TextAlign.right,
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'السياق',
                                  hintStyle: TextStyle(
                                      color: Colors.white, fontSize: 18),
                                ),
                                style: const TextStyle(
                                  color:
                                      Colors.white, // Set text color to white
                                  fontSize: 18,
                                ),
                                textInputAction: TextInputAction.newline,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: Colors.blue.shade300,
                  ),
                  height: 50,
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: TextField(
                      controller: answerController,
                      maxLines: null,
                      textAlign: TextAlign.right,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'الجواب',
                        hintStyle: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                      textInputAction: TextInputAction.newline,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 70,
                      child: Container(
                        padding: const EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                          color: Colors.blue.shade300,
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: GestureDetector(
                          onTap: () async {
                            String? question = await simpleQuestion(
                                inputController.text.trim(),
                                answerController.text.trim(),
                                context);
                            if (question != null) {
                              setState(() {
                                soual = question;
                              });
                            }
                          },
                          child: const Center(
                            child: Text(
                              'ارسال',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18.0,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 16,
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: Colors.blue.shade300,
                  ),
                  height: 170,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Text(
                          soual,
                          style: const TextStyle(
                              color: Colors.white, fontSize: 18),
                        ),
                      ),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.share, color: Colors.white),
                          SizedBox(width: 8.0),
                          Icon(Icons.copy, color: Colors.white),
                          SizedBox(width: 8.0),
                          Icon(Icons.star_border, color: Colors.white),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                const SizedBox(
                  height: 230,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
