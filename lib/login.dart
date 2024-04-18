// ignore_for_file: use_build_context_synchronously

import 'package:authenticationapp/forgot_password.dart';
import 'package:authenticationapp/home.dart';
import 'package:authenticationapp/signup.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class LogIn extends StatefulWidget {
  const LogIn({Key? key}) : super(key: key);

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  String email = "";
  String password = "";

  TextEditingController mailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();

  final _formkey = GlobalKey<FormState>();

  userLogin() async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'utilisateur-non-trouve') {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.orangeAccent,
          content: Text(
            "Aucun utilisateur trouvé pour cet e-mail",
            style: TextStyle(fontSize: 18.0),
          ),
        ));
      } else if (e.code == 'mauvais-mot-de-passe') {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.orangeAccent,
          content: Text(
            "Mauvais mot de passe fourni par l'utilisateur",
            style: TextStyle(fontSize: 18.0),
          ),
        ));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Image.asset(
              "images/car.PNG",
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(
            height: 30.0,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20.0),
            child: Form(
              key: _formkey,
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 2.0, horizontal: 30.0),
                    decoration: BoxDecoration(
                      color: Color(0xFFedf0f8),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Veuillez entrer votre adresse e-mail';
                        }
                        if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                          return "S'il vous plaît, mettez une adresse email valide";
                        }
                        if (!value.endsWith('@gmail.com')) {
                          return 'Veuillez saisir une adresse e-mail';
                        }
                        return null;
                      },
                      controller: mailcontroller,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Email",
                        hintStyle: TextStyle(
                          color: Color(0xFFb2b7bf),
                          fontSize: 18.0,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 2.0, horizontal: 30.0),
                    decoration: BoxDecoration(
                      color: Color(0xFFedf0f8),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: TextFormField(
                      controller: passwordcontroller,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "S'il vous plaît entrer le mot de passe";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Mot de passe",
                        hintStyle: TextStyle(
                          color: Color(0xFFb2b7bf),
                          fontSize: 18.0,
                        ),
                      ),
                      obscureText: true,
                    ),
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
                  GestureDetector(
                    onTap: () {
                      if (_formkey.currentState!.validate()) {
                        setState(() {
                          email = mailcontroller.text;
                          password = passwordcontroller.text;
                        });
                        userLogin();
                      }
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.symmetric(vertical: 13.0, horizontal: 30.0),
                      decoration: BoxDecoration(
                        color: Color(0xFF273671),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Center(
                        child: Text(
                          "Se connecter",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 22.0,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => ForgotPassword()));
            },
            child: Text(
              "Mot de passe oublié?",
              style: TextStyle(
                color: Color(0xFF8c8e98),
                fontSize: 18.0,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          SizedBox(
            height: 40.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Vous n'avez pas de compte ?",
                style: TextStyle(
                  color: Color(0xFF8c8e98),
                  fontSize: 18.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(
                width: 5.0,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => SignUp()));
                },
                child: Text(
                  "S'inscrire",
                  style: TextStyle(
                    color: Color(0xFF273671),
                    fontSize: 20.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
