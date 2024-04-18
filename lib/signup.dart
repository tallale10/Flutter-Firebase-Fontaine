import 'package:authenticationapp/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  String email = "", password = "", name = "", numero="";
  TextEditingController namecontroller = TextEditingController();
    TextEditingController phonecontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  TextEditingController mailcontroller = TextEditingController(); // Changed from phonecontroller to mailcontroller

  final _formkey = GlobalKey<FormState>();

  registration() async {
    if (namecontroller.text.isNotEmpty &&
        phonecontroller.text.isNotEmpty &&
        mailcontroller.text.isNotEmpty && // Changed from phonecontroller to mailcontroller
        passwordcontroller.text.isNotEmpty) {
      if (!mailcontroller.text.endsWith("@gmail.com")) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.orangeAccent,
          content: Text(
            "Please enter a valid Gmail address",
            style: TextStyle(fontSize: 18.0),
          ),
        ));
        return;
      }

      try {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: mailcontroller.text, password: passwordcontroller.text);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
            "Enregistré avec succès",
            style: TextStyle(fontSize: 20.0),
          ),
        ));
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => LogIn()));
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.orangeAccent,
            content: Text(
              "The password provided is too weak",
              style: TextStyle(fontSize: 18.0),
            ),
          ));
        } else if (e.code == "email-already-in-use") {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.orangeAccent,
            content: Text(
              "The account already exists",
              style: TextStyle(fontSize: 18.0),
            ),
          ));
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        child: Column(
          children: [
            Container(
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
                      padding:
                          EdgeInsets.symmetric(vertical: 2.0, horizontal: 30.0),
                      decoration: BoxDecoration(
                          color: Color(0xFFedf0f8),
                          borderRadius: BorderRadius.circular(30)),
                      child: TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Veuillez entrer un nom';
                          }
                          return null;
                        },
                        controller: namecontroller,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Nom",
                            hintStyle: TextStyle(
                                color: Color(0xFFb2b7bf), fontSize: 18.0)),
                      ),
                    ),
                    SizedBox(
                      height: 30.0,
                    ),
                    Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 2.0, horizontal: 30.0),
                      decoration: BoxDecoration(
                          color: Color(0xFFedf0f8),
                          borderRadius: BorderRadius.circular(30)),
                      child: TextFormField(
                        validator: (value) {
                          final phoneRegex = RegExp(r'^\d{10}$');
                          if (value == null || value.isEmpty) {
                            return 'Veuillez entrer le numéro de téléphone';
                          } else if (!phoneRegex.hasMatch(value)) {
                            return 'Veuillez entrer un numéro de téléphone valide';
                          }
                          return null;
                        },
                        controller: phonecontroller, // Changed from phonecontroller to mailcontroller
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Numéro",
                            hintStyle: TextStyle(
                                color: Color(0xFFb2b7bf), fontSize: 18.0)),
                      ),
                    ),
                    SizedBox(
                      height: 30.0,
                    ),
                    Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 2.0, horizontal: 30.0),
                      decoration: BoxDecoration(
                          color: Color(0xFFedf0f8),
                          borderRadius: BorderRadius.circular(30)),
                      child: TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Veuillez entrer votre e-mail';
                          }
                          if (!value.endsWith("@gmail.com")) {
                            return 'Veuillez entrer une adresse Gmail valide';
                          }
                          return null;
                        },
                        controller: mailcontroller, // Changed from phonecontroller to mailcontroller
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Email",
                            hintStyle: TextStyle(
                                color: Color(0xFFb2b7bf), fontSize: 18.0)),
                      ),
                    ),
                    SizedBox(
                      height: 30.0,
                    ),
                    Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 2.0, horizontal: 30.0),
                      decoration: BoxDecoration(
                          color: Color(0xFFedf0f8),
                          borderRadius: BorderRadius.circular(30)),
                      child: TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Veuillez entrer le mot de passe';
                          }
                          return null;
                        },
                        controller: passwordcontroller,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Mot de passe",
                            hintStyle: TextStyle(
                                color: Color(0xFFb2b7bf), fontSize: 18.0)),
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
                            numero = phonecontroller.text;
                            email = mailcontroller.text; // Changed from phonecontroller to mailcontroller
                            name = namecontroller.text;
                            password = passwordcontroller.text;
                          });
                          registration();
                        }
                      },
                      child: Container(
                          width: MediaQuery.of(context).size.width,
                          padding: EdgeInsets.symmetric(
                              vertical: 13.0, horizontal: 30.0),
                          decoration: BoxDecoration(
                              color: Color(0xFF273671),
                              borderRadius: BorderRadius.circular(30)),
                          child: Center(
                              child: Text(
                            "S'inscrire",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 22.0,
                                fontWeight: FontWeight.w500),
                          ))),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 40.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Vous avez déjà un compte?",
                    style: TextStyle(
                        color: Color(0xFF8c8e98),
                        fontSize: 18.0,
                        fontWeight: FontWeight.w500)),
                SizedBox(
                  width: 5.0,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => LogIn()));
                  },
                  child: Text(
                    "Se connecter",
                    style: TextStyle(
                        color: Color(0xFF273671),
                        fontSize: 20.0,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
