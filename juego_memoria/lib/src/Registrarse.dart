// ignore_for_file: file_names, avoid_print, use_build_context_synchronously, use_full_hex_values_for_flutter_colors

import 'package:flutter/material.dart';
import 'package:juego_memoria/src/Home.dart';
import 'package:juego_memoria/src/Login.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';

class Registrarse extends StatefulWidget {
  const Registrarse({Key? key}) : super(key: key);

  @override
  State<Registrarse> createState() => _MyAppFormState();
}

class _MyAppFormState extends State<Registrarse> {
  TextEditingController nombre = TextEditingController();
  TextEditingController correo = TextEditingController();
  TextEditingController password = TextEditingController();

  final firebase = FirebaseFirestore.instance; 
  bool validarCorreo(String correo) {
    String patronCorreo =
        r'^[\w-]+(\.[\w-]+)*@([a-zA-Z0-9-]+\.)+[a-zA-Z]{2,7}$';

    RegExp regExp = RegExp(patronCorreo);

    return regExp.hasMatch(correo);
  }

  Future<void> guardarUsuario() async {
    try {
      if (!EmailValidator.validate(correo.text)) {
        mostrarAlerta('Correo inválido',
            'Por favor, ingresa un correo electrónico válido.');
        return;
      }

      if (password.text.length < 8) {
        mostrarAlerta('Contraseña inválida',
            'La contraseña debe tener al menos 8 caracteres.');
        return;
      }

      final QuerySnapshot<Map<String, dynamic>> existeCorreo = await firebase
          .collection('Memoria')
          .where('Email', isEqualTo: correo.text)
          .get();

      if (existeCorreo.docs.isNotEmpty) {
        mostrarAlerta('Correo ya registrado',
            'El correo electrónico ya está asociado a otra cuenta.');
        return;
      }

      await firebase.collection('Memoria').doc().set({
        'Nombre': nombre.text,
        'Email': correo.text,
        'Password': password.text,
      });

      print('Usuario registrado en Firestore');
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const Login()),
      );
    } catch (e) {
      print('Error al registrar el usuario: $e');
    }
  }

  void mostrarAlerta(String titulo, String mensaje) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(titulo),
          content: Text(mensaje),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Cerrar la alerta
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

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
                  height: 200.0,
                  width: 200.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    image: const DecorationImage(
                      image: AssetImage('images/icono.png'),
                      fit: BoxFit.cover,
                    )
                  ),
                ),
              const Divider(
                color: Colors.transparent,
              ),
              Container(
                height: 50.0,
                width: 200.0,
                decoration: BoxDecoration(
                        color: Colors.transparent,
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: const Center(
                  child: Text(
                    'SymphoMatch',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Silk',
                      fontSize: 23.0,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 25.0,
              ),
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xffa364ff),
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: TextField(
                  controller: nombre,
                  enableInteractiveSelection: false,
                  autofocus: false,
                  textCapitalization: TextCapitalization.characters,
                  decoration: InputDecoration(
                    hintText: '',
                    hintStyle: const TextStyle(color: Colors.white),
                    labelText: 'User name',
                    labelStyle: const TextStyle(color: Colors.white,fontFamily: 'Teko',fontSize: 25),
                    suffixIcon: const Icon(Icons.verified_user),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 18.0,
              ),
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xffa364ff),
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: TextField(
                  controller: correo,
                  decoration: InputDecoration(
                    hintText: '',
                    hintStyle: const TextStyle(color: Colors.white),
                    labelText: 'Email',
                    labelStyle: const TextStyle(color: Colors.white,fontFamily: 'Teko',fontSize: 25),
                    suffixIcon: const Icon(Icons.alternate_email),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 18.0,
              ),
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xffa364ff),
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: TextField(
                  controller: password,
                  enableInteractiveSelection: false,
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: '',
                    hintStyle: const TextStyle(color: Colors.white),
                    labelText: 'Contraseña',
                    labelStyle: const TextStyle(color: Colors.white,fontFamily: 'Teko',fontSize: 25),
                    suffixIcon: const Icon(Icons.lock_outline),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 18.0,
              ),
              SizedBox(
                height: 50,
                width: 120,
                child: TextButton(
                  style: ButtonStyle(
                    foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
                    backgroundColor: MaterialStateProperty.all<Color>(const Color(0xffffc7ff)),
                  ),
                  onPressed: () {
                    guardarUsuario();
                  },
                  child: const Text(
                    'Registrarse',
                    style: TextStyle(fontFamily: 'Silk', fontSize: 12.0),
                  ),
                ),
              ),
              const SizedBox(
                height: 120.0,
              ),
              Row(
                children: [
                  const SizedBox(
                    width: 50,
                  ),
                  IconButton(
                    icon: const Icon(Icons.home),
                    color: const Color(0xffa364ff),
                    iconSize: 30.0,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const Home()),
                      );
                    },
                  ),
                  const SizedBox(
                    width: 140,
                  ),
                  IconButton(
                    icon: const Icon(Icons.arrow_back),
                    color: const Color(0xffa364ff),
                    iconSize: 30.0,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const Login()),
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
