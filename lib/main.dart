import 'package:flutter/material.dart';
import 'package:tarea8_flutter/theme/themeData.dart';
import 'package:fluttericon/linecons_icons.dart';
import 'package:tarea8_flutter/entradas.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Tarea#8_Flutter App",
      debugShowCheckedModeBanner: false,
      theme: styles,

      initialRoute: '/',
      routes: {
        '/': (context) => const MainPage(),
        '/List': (context) => const Entradas(),
      }
    );
  }
}

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: const Center(child: Text("Tu diario :3")),
    ),

    body: 
        Padding(
          padding: const EdgeInsets.all(5.0),
          child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.network("https://cdn.pixabay.com/photo/2017/03/19/10/49/friendship-2156174_1280.jpg"),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
              Text("Guardamos tus secretos ", style: Theme.of(context).textTheme.titleMedium,),
              Icon(Linecons.heart, color: Colors.red, size: Theme.of(context).textTheme.titleMedium!.fontSize,)
            ],),
            getSpacer(20.0),
            Expanded(
              child: Center(
                child: ElevatedButton(
                  onPressed: () => Navigator.pushNamed(context, '/List'), 
                  style: Theme.of(context).elevatedButtonTheme.style!.copyWith(
                    minimumSize: const MaterialStatePropertyAll<Size>(Size(300.0, 0.0)),
                    textStyle: MaterialStatePropertyAll<TextStyle>(TextStyle(
                      fontSize: 30.0, 
                      fontFamily: secondaryFont,
                      fontWeight: FontWeight.bold,
                      // backgroundColor: accentColor
                    )),
                  ),
                  child: const Text("Entrar al Diario")
                ),
              )
            ),
            getSpacer(20.0)
          ],
        ),
        )
  );
}