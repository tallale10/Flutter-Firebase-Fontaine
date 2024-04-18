import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            buildbackgroundimage(),
            Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Bienvenu',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 50,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Pacifico-Regular',
                    ),
                  ),
                  const SizedBox(height: 40),
                  Padding(
                    padding: const EdgeInsets.only(right: 50.0),
                    child: Container(
                      width: 209,
                      height: 70,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.black,
                          width: 4,
                        ),
                        borderRadius: BorderRadius.circular(40),
                        gradient: const LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              Color.fromRGBO(100, 0, 100, 1),
                              Color.fromRGBO(100, 0, 179, 1),
                              Color.fromRGBO(204, 0, 204, 1),
                              Color.fromRGBO(255, 0, 255, 1)
                            ]),
                      ),
                      child: MaterialButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40),
                        ),
                        onPressed: () {
                          // Navigate to the desired screen or perform any action
                        },
                        child: const Text(
                          'Continuer',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Pacifico-Regular',
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget buildbackgroundimage() => Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
          image: AssetImage('images/purple-03.jpg'),
          fit: BoxFit.cover,
        )),
      );
}
