import 'dart:io';

import 'package:path_provider/path_provider.dart';

class CreateDir_Helper{

Future<String> CreateDir(String name)  async {
    final dirName = 'Image/$name';
    final docDir = await getApplicationDocumentsDirectory();
    final myDir = Directory('${docDir.path}/$dirName');

    final dir = await myDir.create(recursive: true);

    return dir.path;
  }
  
  
}

