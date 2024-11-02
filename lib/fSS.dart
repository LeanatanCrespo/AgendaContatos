import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  // Instância do FlutterSecureStorage
  final _storage = FlutterSecureStorage();

  // Método para salvar o token do usuário
  Future<void> saveUserToken(String username) async {
    // Salva o nome de usuário como token
    await _storage.write(key: 'username', value: username);
  }

  // Método para obter o token do usuário
  Future<String?> getUserToken() async {
    // Lê o nome de usuário salvo
    return await _storage.read(key: 'username');
  }

  // Método para deletar o token do usuário
  Future<void> deleteUserToken() async {
    // Remove o nome de usuário salvo
    await _storage.delete(key: 'username');
  }
}
