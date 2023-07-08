//Entrada del diario
class Log {
  Log({
    required this.ID, 
    required this.titulo, 
    required this.fecha,
    required this.descripcion, 
    this.fotoPath, 
    this.audioPath
  });

  int ID;
  String titulo;
  String descripcion;
  DateTime fecha;
  String? fotoPath;
  String? audioPath;
}