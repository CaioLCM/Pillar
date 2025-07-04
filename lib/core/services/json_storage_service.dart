import 'dart:convert';
import 'dart:io';

import 'package:pillar/core/models/user_data.dart';
import 'package:path_provider/path_provider.dart';

class JsonStorageService {
  // GET WHERE TO SAVE ON DEVICE
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  // CRIA REFERÊNCIA DO ARQUIVO (AINDA NÃO EXISTE)
  Future<File> get _userFile async {
    final path = await _localPath;
    return File("$path/user_data.json"); // <-- Apenas um ponteiro
  }

  // VERIFICA SE O ARQUIVO EXISTE
  Future<bool> hasUserData() async {
    final file = await _userFile;
    return file.exists(); // <-- Flutter verifica automaticamente
  }

  // QUANDO SALVAR, ARQUIVO É CRIADO AUTOMATICAMENTE
  Future<void> saveUserData(UserData userData) async {
    final file = await _userFile;
    final jsonString = jsonEncode(userData.toJson());
    await file.writeAsString(jsonString); // <-- Cria o arquivo
  }

  Future<UserData?> loadUserData() async {
    final file = await _userFile;

    if (!await file.exists()){
      return null;
    }

    final jsonString = await file.readAsString();

    final jsonMap = jsonDecode(jsonString) as Map<String, dynamic>;

    return UserData.fromJson(jsonMap);
  }
}