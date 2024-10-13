import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'medication_manager.dart';
import 'data_page.dart';
import 'login_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final MedicationManager medicationManager = MedicationManager();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Medication Manager',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: AnimationPage(medicationManager: medicationManager),
    );
  }
}

class AnimationPage extends StatelessWidget {
  final MedicationManager medicationManager;

  AnimationPage({required this.medicationManager});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: AnimatedTextKit(
          animatedTexts: [
            FadeAnimatedText(
              'Welcome to',
              textStyle: TextStyle(fontSize: 32.0, fontWeight: FontWeight.bold),
              duration: Duration(seconds: 2),
            ),
            ScaleAnimatedText(
              'Medication Manager',
              textStyle: TextStyle(fontSize: 48.0, fontWeight: FontWeight.bold),
              duration: Duration(seconds: 2),
            ),
            ColorizeAnimatedText(
              'Medication Manager',
              textStyle: TextStyle(fontSize: 48.0, fontWeight: FontWeight.bold),
              colors: [
                Colors.blue,
                Colors.green,
                Colors.yellow,
                Colors.red,
              ],
              speed: Duration(milliseconds: 150),
            ),
          ],
          totalRepeatCount: 1,
          onFinished: () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => LoginPage(
                  onLoginSuccess: () {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => DataPage(
                          medicationManager: medicationManager,
                          onLogout: () {
                            // This creates a recursive structure that allows for repeated login/logout
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(builder: (context) => MyApp()),
                            );
                          },
                        ),
                      ),
                    );
                  },
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
