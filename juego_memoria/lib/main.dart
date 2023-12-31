import 'package:flutter/material.dart';
import 'package:juego_memoria/firebase_options.dart';
import 'package:juego_memoria/src/Home.dart';
import 'package:firebase_core/firebase_core.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Memorice',
      //CUANDO ABRE EL MAIN EN EL CELU, TE MANDA DIRECTO AL HOME
      home: Home(),
    );
  }
}
