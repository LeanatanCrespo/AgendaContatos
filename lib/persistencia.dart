import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'contato.dart';

//(tentativa) de fazer persistencia
class PersistenciaContatos {
  final String chaveContatos = "listaContatos";

  // Salva a lista de contatos na memória local
  Future<void> salvarContatos(List<Contato> contatos) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> listaContatosJson = contatos.map((c) => jsonEncode(c.toJson())).toList();
    prefs.setStringList(chaveContatos, listaContatosJson);
  }

  // Carrega a lista de contatos da memória local
  Future<List<Contato>> carregarContatos() async {
    final prefs = await SharedPreferences.getInstance();
    List<String>? listaContatosJson = prefs.getStringList(chaveContatos);

    if (listaContatosJson != null) {
      return listaContatosJson.map((json) => Contato.fromJson(jsonDecode(json))).toList();
    }
    return [];
  }
}