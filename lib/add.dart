import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttericon/linecons_icons.dart';
import 'package:tarea8_flutter/db.dart';
import 'package:tarea8_flutter/models/log.dart';
import 'package:tarea8_flutter/main.dart';
import 'package:tarea8_flutter/theme/themeData.dart';
import 'package:image_picker/image_picker.dart';
import 'package:gallery_saver/gallery_saver.dart';


class AgregarEntrada extends StatefulWidget{
  const AgregarEntrada({super.key});

  @override
  State<AgregarEntrada> createState() => _AgregarEntradaState();
}

class _AgregarEntradaState extends State<AgregarEntrada> with RouteAware{

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
  void didPush() {
    super.didPush();
    print("Me llamaron?");
  }
  // route events

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Row(children: [Text("Registrando... "), Icon(Linecons.pencil)]),),

      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Text("Fomulario de ingreso", style: Theme.of(context).textTheme.titleLarge, textAlign: TextAlign.center,),
            SizedBox(width: MediaQuery.of(context).size.width,),
            const FormAgregar()
          ],
        ),
      ),
    );
  }
}

class FormAgregar extends StatefulWidget with RouteAware {
  const FormAgregar({super.key});

  @override
  State<FormAgregar> createState() => _FormAgregarState();
}

class _FormAgregarState extends State<FormAgregar> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController tituloController = TextEditingController();
  final TextEditingController descripcionController= TextEditingController();
  
  String? imagePath;
  bool fromGallery = true;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          TextFormField(
            controller: tituloController,
            decoration: const InputDecoration(
              label: Text("Evento: "),
              hintText: "¿Qué paso hoy?",
            ),
            validator: (value) {
              if (value!.isEmpty) return "No deje el campo vacio";
              return null;
            },
          ),
          TextFormField(
            controller: descripcionController,
            decoration: const InputDecoration(
              label: Text("Descripcion: "),
              hintText: "Escribe los detalles...",
            )
          ),
          getSpacer(20.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Imagen: ", 
                style: Theme.of(context).textTheme.titleSmall!.copyWith(color: accentColor, fontSize: 20.0)
              ),
              Row(
                children: [
                  IconButton(
                    onPressed: () {imagePicker(ImageSource.camera);}, 
                    icon: const Icon(Linecons.camera)
                  ),
                  IconButton(
                    onPressed: () {imagePicker(ImageSource.gallery);}, 
                    icon: const Icon(Linecons.photo)
                  )
                ],
              )
            ],
          ),

          const Divider(height: 15.0,),
          ElevatedButton(
            onPressed: () async {
              if(formKey.currentState!.validate()) {
                if (!fromGallery) {
                  try {
                    GallerySaver.saveImage(imagePath!);

                  }catch (e) {
                    print("Error: $e");
                  }
                }
                

                Log newItem = Log(
                  titulo: tituloController.text,
                  descripcion: descripcionController.text,
                  fecha: DateTime.now(),
                  fotoPath: imagePath
                );
                
                final db = AppDatabase();
                await db.insertLog(newItem);

                // ignore: use_build_context_synchronously
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text("Entrada agregada correctamente..."),
                    duration: Duration(seconds: 3),
                  )
                ); 



                // ignore: use_build_context_synchronously
                Navigator.pop(context);              


              }
            }, 
            style: Theme.of(context).elevatedButtonTheme.style!.copyWith(
              minimumSize: const MaterialStatePropertyAll<Size>(Size(200.0, 0)),
            ),
            child: const Text("Guardar")
          ),
          imagePath != null? Image.file(File(imagePath!), width: 100, height: 100, fit: BoxFit.cover, alignment: Alignment.center,):SizedBox()
        ],
      ),
    );
  }



  // ImagePicker
  Future<void> imagePicker(ImageSource source) async {
    

    try {
      final picker = ImagePicker();
      final image = await  picker.pickImage(source: source);
      if (image == null) return;

      setState(()=> imagePath = image.path);
      source == ImageSource.camera? fromGallery = false: fromGallery=true;
    }on PlatformException catch(e) {
      print("Error: $e"); 
    }

  }

}