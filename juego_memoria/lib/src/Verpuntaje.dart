// ignore: duplicate_ignore
// ignore: file_names
// ignore_for_file: library_private_types_in_public_api, file_names

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Verpuntaje extends StatefulWidget {
  const Verpuntaje({Key? key}) : super(key: key);

  @override
  _VerpuntajeState createState() => _VerpuntajeState();
}

class _VerpuntajeState extends State<Verpuntaje> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Puntuaciones',style: TextStyle(color:Colors.white,fontFamily: 'Teko',fontSize: 30),),
        backgroundColor: const Color(0xff241b35),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      backgroundColor: const Color(0xff241b35),
      body: FutureBuilder(
        future: FirebaseFirestore.instance.collection('Memoria').get(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          }

          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }

          List<DocumentSnapshot> documents = snapshot.data!.docs;

          Map<String, List<int>> scoresMap = {};

          for (int index = 0; index < documents.length; index++) {
            final Map<String, dynamic> data =
                documents[index].data() as Map<String, dynamic>;

            String nombre = data['Nombre'].toString();
            String email = data['Email'].toString();

            List<Map<String, dynamic>>? puntajeList = data['puntajes'] != null
                ? List<Map<String, dynamic>>.from(data['puntajes'])
                : null;

            if (puntajeList != null) {
              List<int> scores = scoresMap[nombre + email] ?? [];

              for (var puntaje in puntajeList) {
                int puntuacion = puntaje['puntuacion'] ?? 0;
                scores.add(puntuacion);
              }

              scores.sort((a, b) => b.compareTo(a));

              scoresMap[nombre + email] = scores.take(3).toList();
            }
          }

          List<DataRow> dataRows = [];

          double rowHeight = 50.0;

          for (int index = 0; index < documents.length; index++) {
            final Map<String, dynamic> data =
                documents[index].data() as Map<String, dynamic>;

            String nombre = data['Nombre'].toString();
            String email = data['Email'].toString();

            List<int> scores = scoresMap[nombre + email] ?? [];


            Widget puntajesWidget = Padding(
              padding: const EdgeInsets.all(4.0),
              child: SizedBox(
                height: rowHeight, 
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: scores.map((score) {
                      return Container(
                        width: 50.0, 
                        alignment: Alignment.center,
                        child: Text(
                          score.toString(),
                          style: const TextStyle(fontSize: 20, color: Colors.white,fontFamily: 'Teko'),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
            );

            dataRows.add(DataRow(
              cells: [
                DataCell(Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    nombre,
                    style: const TextStyle(fontSize: 20, color: Colors.white,fontFamily: 'Teko'),
                  ),
                )),
                DataCell(puntajesWidget),
              ],
            ));
          }

          double headerHeight = 60.0;

  
          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Container(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 2.0, 
              ),
              child: DataTable(
                columnSpacing: 125.0, 
                headingRowHeight: headerHeight, 
                // ignore: deprecated_member_use
                dataRowHeight: rowHeight, 
                dataRowColor: MaterialStateColor.resolveWith((states) => const Color(0xffa364ff)),
                headingRowColor: MaterialStateColor.resolveWith((states) => const Color(0xff6c35de)),
                columns: const [
                  DataColumn(label: Text('Nombre', style: TextStyle(fontSize: 13, color: Colors.white,fontFamily: 'Silk'))),
                  DataColumn(
                    label: Text('Mejores Puntajes', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white,fontFamily: 'Silk',fontSize: 13)),
                  ),
                ],
                rows: dataRows,
              ),
            ),
          );
        },
      ),
    );
  }
}
