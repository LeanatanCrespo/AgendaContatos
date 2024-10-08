import 'dart:convert';
import 'package:agenda_contatos/contatoDAO.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'contato.dart';

//(testando)persistencia em DAO
class ContatoDAOImpl implements ContatoDAO {
  final String chaveContatos = "listaContatos";

  //função DAO cadastrar
  @override
  Future<void> insert(Contato contato) async {
    final prefs = await SharedPreferences.getInstance();
    List<Contato> contatos = await getAll();
    contatos.add(contato);
    List<String> listaContatosJson = contatos.map((c) => jsonEncode(c.toJson())).toList();
    prefs.setStringList(chaveContatos, listaContatosJson);
  }

  //função DAO cadastrar
  @override
  Future<List<Contato>> getAll() async {
    final prefs = await SharedPreferences.getInstance();
    List<String>? listaContatosJson = prefs.getStringList(chaveContatos);
    
    if (listaContatosJson != null) {
      return listaContatosJson.map((json) => Contato.fromJson(jsonDecode(json))).toList();
    }
    return [];
  }

  //função DAO cadastrar
  @override
  Future<void> update(int index, Contato contato) async {
    final prefs = await SharedPreferences.getInstance();
    List<Contato> contatos = await getAll();
    if (index >= 0 && index < contatos.length) {
      contatos[index] = contato;
      List<String> listaContatosJson = contatos.map((c) => jsonEncode(c.toJson())).toList();
      prefs.setStringList(chaveContatos, listaContatosJson);
    }
  }

  //função DAO cadastrar
  @override
  Future<void> delete(int index) async {
    final prefs = await SharedPreferences.getInstance();
    List<Contato> contatos = await getAll();
    if (index >= 0 && index < contatos.length) {
      contatos.removeAt(index);
      List<String> listaContatosJson = contatos.map((c) => jsonEncode(c.toJson())).toList();
      prefs.setStringList(chaveContatos, listaContatosJson);
    }
  }


  //função DAO cadastrar
  @override
  Future<void> insertAll(List<Contato> contatos) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> listaContatosJson = contatos.map((c) => jsonEncode(c.toJson())).toList();
    await prefs.setStringList('listaContatos', listaContatosJson);
  }
}

/*
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
*/