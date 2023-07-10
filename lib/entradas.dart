import 'package:flutter/material.dart';
import 'package:fluttericon/linearicons_free_icons.dart';
import 'package:fluttericon/linecons_icons.dart';
import 'package:tarea8_flutter/db.dart';
import 'package:tarea8_flutter/globals.dart';
import 'package:tarea8_flutter/models/log.dart';
import 'package:tarea8_flutter/theme/themeData.dart';
import 'package:tarea8_flutter/main.dart';
import 'package:tarea8_flutter/visualizar.dart';



class Entradas extends StatefulWidget {
  const Entradas({super.key});

  @override
  State<Entradas> createState() => EntradasState();
}
class EntradasState extends State<Entradas> with RouteAware {
  final List<Log> entradas = [];

  EntradasState() {
    cargarDatos();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context) as PageRoute);
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }

  @override
  void didPopNext() {
    super.didPopNext();
    setState(() {
      entradas.removeRange(0, entradas.length);
    });
    cargarDatos();
  }

  
  Future<void> cargarDatos() async {
    AppDatabase db = AppDatabase();

    final datos = await db.getAllEntries();
    setState(() => entradas.addAll(datos));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:const Row(children: [Text("Lista de vivencias "), Icon(Linecons.heart)],)),

      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, '/add'),
        child: const Icon(LineariconsFree.plus_circle_1),
      ),
      persistentFooterButtons: [
        ElevatedButton(
          onPressed: entradas.isEmpty? null:() {
            generarModalEliminar(
              context, 
              "¿Seguro que desea eliminar todo?", 
              () {
                AppDatabase db = AppDatabase();
                db.deleteAll();
                setState(() => entradas.removeRange(0, entradas.length));
              });
          }, 
          child: const Row(
            children: [
              Text("Eliminar todo"),
              Icon(Linecons.trash)
            ],
          )
        )
      ],
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
        child: entradas.isEmpty? 
      Center(
        child: Text("No hay entradas en el diario",
          style: Theme.of(context).textTheme.titleMedium!.copyWith(fontSize: 20.0),)
      )
    :
      ListView.separated(
        itemBuilder: (context, index) => GestureDetector(

          onTap: null,

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
                      onPressed: () {
                        showDialog(
                          context: context, 
                          builder: (context) {
                            return Visualizar(datos: entradas[index]);
                          });
                      },
                      icon: const Icon(Icons.ads_click),
                      ), 
                    IconButton(
                      onPressed: () {
                        generarModalEliminar(
                        context, 
                        "¿Seguro que desea eliminar?",
                        () async {
                          AppDatabase db = AppDatabase();
                          await db.deleteLog(entradas[index].ID);
                          setState(() => entradas.remove(entradas[index])); // Actualizando el state
                        }
                      );
                      }, 
                      icon: const Icon(Linecons.trash))
                    ],
                  )
                ]
              ),
            ),
          ), 
          separatorBuilder: (context, index) => Divider(height: 15.0, color: buttonColors,), 
          itemCount: entradas.length
        )
      )
    );
  }    


}


