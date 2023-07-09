import 'dart:io';

import 'package:flutter/material.dart';
import 'package:tarea8_flutter/models/log.dart';
import 'package:tarea8_flutter/theme/themeData.dart';



class Visutalizar extends StatelessWidget {
  const Visutalizar({super.key, required this.datos});

  final Log datos;

  @override
  Widget build(BuildContext context) {
    datos.fotoPath=null;
    return Scaffold(
      appBar: AppBar(
        title: Text("Titulo: ${datos.titulo}", style: Theme.of(context).appBarTheme.titleTextStyle!.copyWith(fontSize: 16.0),),
        centerTitle: true,
      ),

      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(

          children: [
            SizedBox(width: MediaQuery.of(context).size.width-20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                datos.fotoPath == null? 
                Image.network("https://upload.wikimedia.org/wikipedia/commons/0/0a/No-image-available.png", 
                  width: 150, 
                  height: 150, 
                  fit: BoxFit.cover,)
                  
                :Image.file(File(datos.fotoPath!), 
                  width: 150, 
                  height: 150, 
                  fit: BoxFit.cover,),
                  
                Expanded(
                  child: Column(
                    children: [
                      Text("Descripcion", style: Theme.of(context).textTheme.titleSmall,),
                      getSpacer(10.0),
                      Text(datos.descripcion, style: Theme.of(context).textTheme.bodyMedium,)
                    ],
                  )
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}