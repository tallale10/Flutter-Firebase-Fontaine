import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:authenticationapp/login.dart';
import 'package:authenticationapp/homeA.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('en'), // English
        const Locale('ar'), // Arabic
      ],
      locale: Locale('en'), // Default language
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  const Home({Key? key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool isOn = false;
  Color selectedColor = Colors.red; // Default color

  void toggleSwitch() {
    setState(() {
      isOn = !isOn;
    });
  }

  void changeColor(Color color) {
    setState(() {
      selectedColor = color;
    });
  }

  void applyColor(Color color) {
    setState(() {
      selectedColor = color;
    });
    Navigator.pop(context); // Close the color picker dialog
  }



  void logout() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => MyApp()),
    );
  }

  void showMenuOptions() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Menu"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {
                Navigator.push(context,
                MaterialPageRoute(builder: (context) => HomeA()));
              },                child: Text("العربية"),
              ),
              SizedBox(height: 8),
              GestureDetector(
                onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => LogIn()));
                  },
                child: Text("تسجيل الخروج"),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Contrôleur de fontaine"),
        centerTitle: true,
        leading: IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {    Navigator.popUntil(context, ModalRoute.withName('/'));
              },),
        actions: [
          IconButton(
            onPressed: () {
              showMenuOptions();
            },
            icon: Icon(Icons.menu),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: toggleSwitch,
              child: Text(isOn ? 'ON' : 'OFF'),
              style: ElevatedButton.styleFrom(
                backgroundColor: isOn ? const Color.fromARGB(255, 96, 244, 101) : Colors.grey,
              ),
            ),
            SizedBox(height: 16),
            Text(
              "Des tensionsà",
              style: TextStyle(
                color: selectedColor,
                fontSize: 16,
              ),
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                  ColorButton(Colors.red, 'Feu 1', changeColor),
                  ColorButton(Colors.blue, 'Feu 2', changeColor),
                  ColorButton(Colors.green, 'Feu 3', changeColor),
              ],
              ),
            SizedBox(height: 16),
          
          ],
        ),
      ),
    );
  }
}

class ColorButton extends StatelessWidget {
  final Color color;
  final String text;
  final Function(Color) onTap;

  ColorButton(this.color, this.text, this.onTap);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          text,
          style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
        ),
        GestureDetector(
          onTap: () => onTap(color),
          child: Container(
            width: 80,
            height: 40,
            margin: EdgeInsets.symmetric(horizontal: 8),
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        ),
      ],
    );
  }
}


class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
