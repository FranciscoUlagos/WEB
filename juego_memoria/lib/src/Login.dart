// ignore_for_file: file_names, use_build_context_synchronously, avoid_print, use_full_hex_values_for_flutter_colors

import 'package:flutter/material.dart';
import 'package:juego_memoria/src/Home.dart';
import 'package:juego_memoria/src/Juego.dart';
import 'package:juego_memoria/src/Registrarse.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _MyAppFormState();
}

class _MyAppFormState extends State<Login> {
  TextEditingController nombreController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final FirebaseFirestore _firebase = FirebaseFirestore.instance;

  Future<void> verificarUsuario() async {
    final nombre = nombreController.text.trim();
    final password = passwordController.text.trim();

    if (nombre.isEmpty || password.isEmpty) { //VACIOS
      mostrarAlerta('Campos Vacíos', 'Por favor, completa todos los campos.');
      return;
    }

    try {
      final QuerySnapshot<Map<String, dynamic>> existeUsuario = await _firebase
          .collection('Memoria')
          .where('Nombre', isEqualTo: nombre)
          .get();
      //SI EL USUARIO EXISTE SE SIGUE
      if (existeUsuario.docs.isNotEmpty) {  
        final usuario = existeUsuario.docs.first.data();
        final usuarioId = existeUsuario.docs.first.id;

        final email = usuario['Email'];

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                //SE INICIA EL JUEGO CON LO INGRESADO
                Juego(usuario: usuario, email: email, usuarioId: usuarioId), 
          ),
        );
      } else {
        mostrarAlerta('Usuario no registrado',
            'Por favor, regístrate antes de iniciar sesión.');
      }
    } catch (e) {
      print('Error al verificar el usuario: $e');
      mostrarAlerta(
        'Error',
        'Ocurrió un error al verificar el usuario. Por favor, inténtalo de nuevo.',
      );
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
              //LOGO DEL JUEGO
              Container(
                height: 200.0,
                width: 200.0,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    image: const DecorationImage(
                      image: AssetImage('images/icono.png'),
                      fit: BoxFit.cover,
                    )),
              ),
              const Divider(
                color: Colors.transparent,
              ),
              //NOMBRE DEL JUEGO
              Container(
                height: 70.0,
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
                height: 15.0,
              ),
              //CAJITA PARA USERNAME
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xffa364ff),
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: TextField(
                  controller: nombreController,
                  enableInteractiveSelection: false,
                  autofocus: false,
                  textCapitalization: TextCapitalization.characters,
                  decoration: InputDecoration(
                    hintText: '',
                    hintStyle: const TextStyle(color: Colors.white),
                    labelText: 'User name',
                    labelStyle: const TextStyle(
                        color: Colors.white, fontFamily: 'Teko', fontSize: 25),
                    suffixIcon: const Icon(Icons.verified_user),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              //CAJITA PARA CONTRASEÑA
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xffa364ff),
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: TextField(
                  controller: passwordController,
                  enableInteractiveSelection: false,
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: '',
                    hintStyle: const TextStyle(color: Colors.white),
                    labelText: 'Contraseña',
                    labelStyle: const TextStyle(
                        color: Colors.white, fontFamily: 'Teko', fontSize: 25),
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
              //BOTON INICIAR SESION
              SizedBox(
                height: 50,
                width: 120,
                child: TextButton(
                  onPressed: () async {
                    await verificarUsuario();
                  },
                  style: ButtonStyle(
                    foregroundColor:
                        MaterialStateProperty.all<Color>(Colors.black),
                    backgroundColor: MaterialStateProperty.all<Color>(
                        const Color(0xffffc7ff)),
                  ),
                  child: const Text(
                    'Iniciar Sesión',
                    style: TextStyle(fontFamily: 'Silk', fontSize: 10.0),
                  ),
                ),
              ),
              const SizedBox(
                height: 0,
              ),
              //BOTON "ENLACE" PARA REGISTRARSE EN CASO DE NO TENER CUENTA
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const Registrarse()),
                  );
                },
                child: const Text(
                  'No tienes una cuenta? Registrate aqui',
                  style: TextStyle(
                      color: Colors.white, fontFamily: 'Teko', fontSize: 20.0),
                ),
              ),
              const SizedBox(
                height: 150.0,
              ),
              //ICONO HOME
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
            ],
          ),
        ],
      ),
    );
  }
}
