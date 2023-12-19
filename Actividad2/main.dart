import 'package:flutter/material.dart';
//import 'package:url_launcher/link.dart';
import 'package:url_launcher/url_launcher.dart';


void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
   const MyApp({super.key});

  Future<void> _launchURL(String url) async {
    final Uri uri = Uri(scheme: "https", host: url);
    if(!await launchUrl(
      uri,
      mode: LaunchMode.externalApplication,
    )) {
      throw "Can not launch url";
    }
  }

  @override
  Widget build(BuildContext context){
    const appTitle = 'Mostrar Imagen';
    return MaterialApp(
      title: appTitle,
      home: Scaffold(
        appBar: AppBar(
          title: const Text(appTitle),
        ),
        body: Center(
          child:Column(
            children: [
              SizedBox(
                height: 220.0,
                width: 500.0,
                child: Image.network('https://www.ulagos.cl/wp-content/uploads/2020/11/1-1-1-scaled.jpg',fit: BoxFit.cover,),
              ),
              Container(child: const Text('Sede Puerto Montt')),
              
              SizedBox(
                height: 210.0,
                width: 500.0,
                child: Image.network('https://www.ulagos.cl/wp-content/uploads/2020/11/Imagen-002.jpg',fit: BoxFit.cover,)
              ),
              Container(child: const Text('Sede Osorno')),

              SizedBox(
                height: 210.0,
                width: 500.0,
                child: Image.network('https://www.ulagos.cl/wp-content/uploads/2020/12/chiloe-scaled.jpg',fit: BoxFit.cover,)
              ),
              Container(child: const Text('Sede Chiloe')),

              Container(
                height: 50.0,
                width: 150.0,
                child: ElevatedButton(
              onPressed: () {
                _launchURL("www.ulagos.cl");
              },
              child: const Text('Ir a ulagos'),
              ),
              )
            ],
            
          ),
              
        ),
      ),
    );
  }
}



