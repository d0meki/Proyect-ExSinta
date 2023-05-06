import 'dart:io';

import 'package:path_provider/path_provider.dart' as path;
import 'package:proy_sistemas_expertos/model/base_conocimiento.dart';

class Archivos {
  Archivos();
  Future<String> getLocalPath() async {
    final directory = await path.getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> getLocalFile(String name) async {
    final pathFile = await getLocalPath();
    return File('$pathFile/$name');
  }

  Future<bool> createLocalFile(String name) async {
    try {
      final pathFile = await getLocalPath();
      // final file = File('$pathFile/$name.bcm');
      final file = File('$pathFile/$name');
      file.create(recursive: true);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<List<String>> getListDir() async {
    final List<String> nombreArchivos = [];
    final dir = await getLocalPath();
    final directory = Directory(dir);
    List<FileSystemEntity> archivos = directory.listSync();
    archivos.forEach((archivo) {
      if (archivo is File) {
        String pathPosition = archivo.path.split('/').last;
        if (pathPosition.substring(pathPosition.length - 4) == '.bcm') {
          nombreArchivos.add(pathPosition);
        }
      }
    });
    return nombreArchivos;
  }

  Future<bool> writeLocalFile(String texto, String nameFile) async {
    try {
      final file = await getLocalFile(nameFile);
      file.writeAsString(texto);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> deleteFile(String nameFile) async {
    try {
      final file = await getLocalFile(nameFile);
      file.delete();
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<BaseConocimiento> readLocalFile(String nameFile) async {
    try {
      final file = await getLocalFile(nameFile);
      String contents = await file.readAsString();
      BaseConocimiento baseConocimiento = baseConocimientoFromJson(contents);
      return baseConocimiento;
    } catch (e) {
      throw UnimplementedError("No se encontró El Archivo con ese nombre");
    }
  }
}
