import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttericon/typicons_icons.dart';
import 'package:tarea8_flutter/models/log.dart';
import 'package:tarea8_flutter/theme/themeData.dart';
import 'package:flutter_sound/flutter_sound.dart';

class Visualizar extends StatefulWidget {
  const Visualizar({super.key, required this.datos});

  final Log datos;

  @override
  State<Visualizar> createState() => _VisualizarState();
}

class _VisualizarState extends State<Visualizar> {
  final FlutterSoundPlayer myPlayer = FlutterSoundPlayer();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    myPlayer.openPlayer();
    myPlayer.setVolume(1);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    myPlayer.closePlayer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Entrada del (${widget.datos.fecha.toString().split(" ")[0]})", style: Theme.of(context).appBarTheme.titleTextStyle!.copyWith(fontSize: 16.0),),
        centerTitle: true,
      ),

      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(

          children: [
            SizedBox(width: MediaQuery.of(context).size.width-20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(15.0),
                      child: widget.datos.fotoPath == null? 
                        Image.network("https://upload.wikimedia.org/wikipedia/commons/0/0a/No-image-available.png", 
                          width: 150, 
                          height: 150, 
                          fit: BoxFit.cover,)
                          
                        :Image.file(File(widget.datos.fotoPath!), 
                          width: 150, 
                          height: 150, 
                          fit: BoxFit.cover,),
                    ),
                    getSpacer(7.0),
                    Container(
                      width: 150, 
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(width: 1.0, color: buttonColors)  
                      ),
                      child:
                      widget.datos.audioPath != null?  
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          myPlayer.isStopped? 
                            IconButton(
                              onPressed: () async {
                                await myPlayer.startPlayer(fromURI :widget.datos.audioPath);
                                setState(() {});
                              }, 
                              icon:const Icon(Typicons.play)
                            ):
                          
                          myPlayer.isPlaying? 
                            IconButton(
                              onPressed: () async {
                                await myPlayer.pausePlayer();
                                setState(() {});
                              }, 
                              icon: const Icon(Typicons.pause_outline)
                            ):
                            IconButton(
                              onPressed: () async {
                                await myPlayer.resumePlayer();
                                setState(() {});
                              }, 
                              icon: const Icon(Typicons.play)
                            ),
                            
                            if (!myPlayer.isStopped)
                            IconButton(
                              onPressed: () async {
                                await myPlayer.stopPlayer();
                                setState(() {});
                              }, 
                              icon: const Icon(Typicons.stop_outline)
                            )
                        ],
                      ):
                      Center(
                        child: Text("No audio", style: Theme.of(context).textTheme.bodyMedium,),
                      )
                    )
                  ],
                ),
                  
                Expanded(
                  child: Text(widget.datos.titulo, 
                    textAlign: TextAlign.center, 
                    style: Theme.of(context).textTheme.titleSmall!.copyWith(color: accentColor),
                  )
                )
              ],
            ),
            getSpacer(25.0),
            // Text("Descripcion", style: Theme.of(context).textTheme.titleMedium,),
            Expanded(
              child: Container(
                margin: const EdgeInsets.only(top: 25.0),
                padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
                width: MediaQuery.of(context).size.width,

                decoration: BoxDecoration(
                  color: Color(0xFFFFFAEE),
                  border: Border.all(style: BorderStyle.solid, width: 1.0, color: buttonColors),
                  borderRadius: BorderRadius.circular(5.0)
                ),
                
                child: widget.datos.descripcion.isNotEmpty? Text(widget.datos.descripcion, 
                  textAlign: TextAlign.center, 
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 18.0),
                ): 
                  Text("No hay descripción disponible", 
                  textAlign: TextAlign.center, 
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 18.0),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}