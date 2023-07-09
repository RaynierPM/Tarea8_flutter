import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:fluttericon/linecons_icons.dart';
import 'package:sqflite/sqflite.dart';
import 'package:tarea8_flutter/db.dart';
import 'package:tarea8_flutter/models/log.dart';
import 'package:fluttericon/linearicons_free_icons.dart';
import 'package:tarea8_flutter/theme/themeData.dart';


class Entradas extends StatelessWidget {
  const Entradas({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:const Row(children: [Text("Lista de vivencias "), Icon(Linecons.heart)],)),

      body: const Padding(
        padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
        child: ListaEntradas(),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: null,
        child: Icon(Icons.add),
      ),
    );
  }
}








class ListaEntradas extends StatefulWidget {
  const ListaEntradas({super.key});

  @override
  State<ListaEntradas> createState() => ListaEntradasState();
}

class ListaEntradasState extends State<ListaEntradas> {
  final List<Log> entradas = [];
  
  ListaEntradasState() {
    cargarDatos();
  }
  
  Future<void> cargarDatos() async {
    AppDatabase db = AppDatabase();

    final datos = await db.getAllEntries();
    setState(() => entradas.addAll(datos));
  }

  @override
  Widget build(BuildContext context) {
    return entradas.isEmpty? 
      Center(
        child: Text("No hay entradas en el diario",
          style: Theme.of(context).textTheme.titleMedium!.copyWith(fontSize: 20.0),)
      )
    :
      ListView.separated(
        itemBuilder: (context, index) => GestureDetector(
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(width: 1.0, color: buttonColors),
              borderRadius: BorderRadius.circular(15.0)
            ),
            padding: const EdgeInsets.all (20.0),
            margin: const EdgeInsets.all (5.0),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("${entradas[index].titulo} - (${entradas[index].fecha.toString().split(" ")[0]})", 
                  style: Theme.of(context).textTheme.titleSmall!.copyWith(color: accentColor)
                ),
                getSpacer(15.0),
                 Row(
                  mainAxisSize: MainAxisSize.max, 
                  mainAxisAlignment: MainAxisAlignment.end, 
                  children: [
                    IconButton(
                      onPressed: null,
                      icon: Icon(Icons.ads_click),
                      ), 
                    IconButton(
                      onPressed: () async {
                        AppDatabase db = AppDatabase();
                        await db.deleteLog(entradas[index].ID);
                        setState(() => entradas.remove(entradas[index])); // Actualizando el state
                      }, 
                      icon: Icon(Icons.delete))
                  ],
                )
              ]
            ),
          ),
          onTap: () => null,
        ), 
        separatorBuilder: (context, index) => Divider(height: 15.0, color: buttonColors,), 
        itemCount: entradas.length
      );
  }
}