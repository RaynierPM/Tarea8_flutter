//Entrada del diario

class Log {
  Log({
    // ignore: non_constant_identifier_names
    this.ID, 
    required this.titulo, 
    required this.fecha,
    required this.descripcion, 
    this.fotoPath, 
    this.audioPath
  });

  // ignore: non_constant_identifier_names
  int? ID;
  String titulo;
  String descripcion;
  DateTime fecha;
  String? fotoPath;
  String? audioPath;


  Map<String, dynamic> toMap() => {
    "ID":ID,
    "titulo": titulo,
    "descripcion": descripcion,
    "fecha": fecha.millisecondsSinceEpoch,
    "fotoPath": fotoPath,
    "audioPath": audioPath 
  };


  factory Log.fromMap(Map map) => Log(
    ID: map["ID"], 
    titulo: map["titulo"], 
    descripcion: map["descripcion"],
    fecha: DateTime.fromMillisecondsSinceEpoch(map["fecha"]),
    fotoPath: map["fotoPath"],
    audioPath: map["audioPath"]  
  );
}