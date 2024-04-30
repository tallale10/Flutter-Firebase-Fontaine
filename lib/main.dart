import 'dart:async';

import 'package:authenticationapp/login.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: "AIzaSyC67_ddNcCkJkoIBT83e6vFCFc6hwFHzns",
      appId: "1:303418212810:android:0055fd4a10668acd89cf33",
      messagingSenderId: "Bienvenue",
      projectId: "authenticationapp-9c231",
    ),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const SplashScreen(
        duration: Duration(seconds: 5),
        nextPage: LogIn(),
      ),
    );
  }
}

class SplashScreen extends StatefulWidget {
  final Duration duration;
  final Widget nextPage;

  const SplashScreen({
    required this.duration,
    required this.nextPage,
    Key? key,
  }) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(widget.duration, () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => widget.nextPage),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'DiGISAND',
              style: TextStyle(
                fontSize: 50,
                fontWeight: FontWeight.bold,
                color: const Color.fromARGB(255, 32, 3, 80), // Set the color here
              ),
            ),
            SizedBox(height: 20),
            Text(
              ' لانكم تستحقون الافضل ', // Add the sentence here
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: const Color.fromARGB(255, 94, 49, 173), // Set the color here
              ),
            ),
          ],
        ),
      ),
    );
  }
}
