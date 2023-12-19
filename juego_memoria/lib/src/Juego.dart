// ignore: file_names
// ignore_for_file: unnecessary_null_comparison, file_names, duplicate_ignore, avoid_print

import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:juego_memoria/src/Home.dart';
import 'package:juego_memoria/src/Logica.dart';
import 'package:juego_memoria/widgets/board.dart';

class Juego extends StatefulWidget {
  final Map<String, dynamic>? usuario;
  final String email;
  final String usuarioId;

  const Juego(
      {Key? key, this.usuario, required this.email, required this.usuarioId})
      : super(key: key);

  @override
  State<Juego> createState() => _MyAppFormState();
}

class _MyAppFormState extends State<Juego> {
  final GameLogic _game = GameLogic();
  var levelForCardCount = 0;
  var tries = 0;
  var score = 0;
  late Timer timer;
  int startTime = 30;

  void startTimer(BuildContext context) {
    const oneSecond = Duration(seconds: 1);
    timer = Timer.periodic(oneSecond, (timer) {
      //SE ACABA EL TIEMPO LO QUE SIGNIFICA QUE PERDIO, ALERTA GAME OVER
      if (startTime == 0) { 
        //SE CANCELA EL TIEMPO PARA QUE LA ALERTA NO SIGA APARECIENDO EN LAS DEMAS INTERFACES
        timer.cancel();
        if (mounted) {
          _showDialog(context, 'Game Over', 'Tu puntuación $score');
        }
      } else {
        if (mounted) {
          setState(() {
            startTime--;
          });
        }
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _game.initGame();
    startTimer(context);
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    var axisNumber = 4;
    var fontFamily = 'Silk';
    var textStyle =
        TextStyle(fontFamily: fontFamily, color: Colors.white, fontSize: 18.0);

    return Scaffold(
        backgroundColor: const Color(0xff241b35),
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: const Color(0xff241b35),
        ),
        body: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                board(
                    'Tiempo',
                    '$startTime',
                    TextStyle(
                        fontFamily: fontFamily,
                        color: Colors.white,
                        fontSize: 18.0)),
                board('Score', '$score', textStyle),
                board('Moves', '$tries', textStyle)
              ],
            ),
            const Divider(height: 35, color: Colors.transparent),
            SizedBox(
              height: screenWidth,
              width: screenWidth,
              child: GridView.builder(
                  itemCount: _game.cardsImg!.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: axisNumber,
                      mainAxisSpacing: 12,
                      crossAxisSpacing: 10),
                  padding: const EdgeInsets.all(16),
                  itemBuilder: (context, index) {
                    return GestureDetector(
                        onTap: () {
                          print(_game.demo_card_list[index]);
                          setState(() {
                            //AUMENTA NUMERO MOVIMIENTOS AL TOCAR CARTAS
                            tries++; 
                            print(tries);
                            _game.cardsImg![index] =
                                _game.demo_card_list[index];

                            _game.matchCheck
                                .add({index: _game.demo_card_list[index]});
                            //ENCUENTRA PAREJAS
                            if (_game.matchCheck.length == 2) { 
                              if (_game.matchCheck[0].values.first ==
                                  _game.matchCheck[1].values.first) {
                                score += 100;
                                print(score);
                                _game.matchCheck.clear();
                                //SI LLEGAS AL PUNTAJE MAXIMO DEL JUEGO
                                if (score == 800) { 
                                  timer.cancel();
                                  _showDialog(context, '¡Ganaste!',
                                      'Tu puntuación fue: $score');
                                }
                                print('true');
                              } else {  
                                print('false');
                                //LO QUE DEMORA EN VOLVER A DARSE VUELTA LA CARTA CUANDO NO SE PILLAN PAREJAS
                                Future.delayed(
                                    const Duration(milliseconds: 500), () {
                                  setState(() {
                                    _game.cardsImg![_game.matchCheck[0].keys
                                        .first] = _game.hiddenCard;
                                    _game.cardsImg![_game.matchCheck[1].keys
                                        .first] = _game.hiddenCard;

                                    _game.matchCheck.clear();
                                  });
                                });
                              }
                            }
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(10),
                              image: DecorationImage(
                                  image: AssetImage(_game.cardsImg![index]),
                                  fit: BoxFit.cover)),
                        ));
                  }),
            ),
            const Divider(height: 170, color: Colors.transparent),
            //ICONO HOME
            IconButton( 
              icon: const Icon(Icons.home),
              color: const Color(0xffa364ff),
              iconSize: 30.0,
              onPressed: () {
                timer.cancel();
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Home()),
                );
              },
            ),
          ],
        ));
  }

  //ALERTA
  void _showDialog(BuildContext context, String title, String info) async {
    if (mounted) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(title),
            content: Text(info),
            actions: <Widget>[
              //BOTON HOME, QUE TAMBIEN SE OCUPA DE PARAR EL TIEMPO
              TextButton(
                child: const Text("Volver a Inicio"),
                onPressed: () async {
                  timer.cancel();
                  Navigator.of(context).pop();
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Home()),
                  );

                  if (widget.email != null) {
                    final nuevoPuntaje = {
                      "fecha": getCurrentDate(),
                      "puntuacion": score
                    };
                    await FirebaseFirestore.instance
                        .collection('Memoria')
                        .where('Email', isEqualTo: widget.email)
                        .get()
                        .then((QuerySnapshot<Map<String, dynamic>> snapshot) {
                      if (snapshot.docs.isNotEmpty) {
                        final documentId = snapshot.docs.first.id;
                        FirebaseFirestore.instance
                            .collection('Memoria')
                            .doc(documentId)
                            .update({
                          'puntajes': FieldValue.arrayUnion([nuevoPuntaje])
                        });
                      }
                    });
                  }
                },
              ),
              //BOTON PARA VOLVER A JUGAR, REINICIA TOdO, Y VUELVE A INICIAR EL TIEMPO
              TextButton(
                child: const Text("Volver a Jugar"),
                onPressed: () {
                  Navigator.of(context).pop();
                  setState(() {
                    _game.initGame();
                    startTime = 30;
                    tries = 0;
                    score = 0;
                  });
                  startTimer(context);
                },
              )
            ],
          );
        },
      );
    }
  }

  //FECHA ACTUAL PARA LA BDD
  String getCurrentDate() {
    return DateTime.now().toIso8601String();
  }
}
