// ignore_for_file: file_names, use_full_hex_values_for_flutter_colors

import 'package:flutter/material.dart';
import 'package:juego_memoria/src/Login.dart';
import 'package:juego_memoria/src/Verpuntaje.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _MyAppFormState();
}

class _MyAppFormState extends State<Home> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xff241b35),
        body: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 90.0),
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 220.0,
                  width: 220.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    image: const DecorationImage(
                      image: AssetImage('images/icono.png'),
                      fit: BoxFit.cover,
                    )
                  ),
                ),
                const Divider(
                  height: 35.0,
                  color: Colors.transparent,
                ),
                Container(
                    height: 80.0,
                    width: 250.0,
                    decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(20.0)),
                    child: const Center(
                      child: Text(
                        'SymphoMatch',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Silk',
                            fontSize: 29.0),
                      ),
                    )),
                const SizedBox(
                  width: 160.0,
                  height: 50.0,
                  child: Divider(
                    color: Colors.transparent,
                  ),
                ),
                Container(
                  height: 100.0,
                  width: 200.0,
                  decoration: BoxDecoration(
                      color: const Color(0xffa364ff),
                      borderRadius: BorderRadius.circular(50)),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xffa364ff)),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const Login()),
                      );
                    },
                    child: const Text(
                      "JUGAR",
                      style: TextStyle(
                        fontSize: 25.0,
                        color: Colors.white,
                        fontFamily: 'Silk',
                      ),
                    ),
                  ),
                ),
                const Divider(
                  height: 20.00,
                  color: Colors.transparent,
                ),
                Container(
                  height: 100.0,
                  width: 200.0,
                  decoration: BoxDecoration(
                    color: const Color(0xffa364ff),
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xffa364ff),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const Verpuntaje()),
                      );
                    },
                    child: const Text(
                      "Puntajes",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontFamily: 'Silk',
                      ),
                    ),
                  ),
                ),
                const Divider(
                  height: 18.0,
                  color: Colors.transparent,
                ),
              ],
            )
          ],
        ));
  }
}
