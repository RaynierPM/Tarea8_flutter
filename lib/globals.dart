import 'package:flutter/material.dart';
import 'package:tarea8_flutter/theme/themeData.dart';


void generarModalEliminar(BuildContext context,String texto, void Function() accion) {
      showDialog(
        context: context, 
        builder: (context) => Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
            side: const BorderSide(
              width: 2.0
            )
          ),
          child: Container(
            padding: const EdgeInsets.all(15.0),
            height: 200,
            child: Center(
              child:  Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(texto, style: const TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
                  Container(
                    margin: const EdgeInsets.only(top: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: accentColor
                          ),
                          onPressed: () => {
                            accion(),
                            Navigator.pop(context)
                          },
                          child: const Row(children: [Text("Si, borralo"), Icon(Icons.delete_forever)]),
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red
                          ),
                          onPressed: () => {
                            Navigator.pop(context)
                          },
                          child: const Row(children: [Text("Cancelar"), Icon(Icons.cancel)]),
                        )
                      ],
                    ),
                  )
                ],
              ),
            )
          ),
        ));
    }