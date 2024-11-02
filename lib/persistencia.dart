import 'dart:convert';
import 'package:agenda_contatos/contatoDAO.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'contato.dart';

// Implementação do DAO para contatos
class ContatoDAOImpl implements ContatoDAO {
  final String chaveContatos = "listaContatos";

  // Função para adicionar um contato
  @override
  Future<void> insert(Contato contato) async {
    final prefs = await SharedPreferences.getInstance();
    List<Contato> contatos = await getAll();
    contatos.add(contato);
    List<String> listaContatosJson = contatos.map((c) => jsonEncode(c.toJson())).toList();
    await prefs.setStringList(chaveContatos, listaContatosJson);
  }

  // Função para obter todos os contatos
  @override
  Future<List<Contato>> getAll() async {
    final prefs = await SharedPreferences.getInstance();
    List<String>? listaContatosJson = prefs.getStringList(chaveContatos);
    
    if (listaContatosJson != null) {
      return listaContatosJson.map((json) => Contato.fromJson(jsonDecode(json))).toList();
    }
    return [];
  }

  // Função para atualizar um contato
  @override
  Future<void> update(int index, Contato contato) async {
    final prefs = await SharedPreferences.getInstance();
    List<Contato> contatos = await getAll();
    if (index >= 0 && index < contatos.length) {
      contatos[index] = contato;
      List<String> listaContatosJson = contatos.map((c) => jsonEncode(c.toJson())).toList();
      await prefs.setStringList(chaveContatos, listaContatosJson);
    }
  }

  // Função para deletar um contato
  @override
  Future<void> delete(int index) async {
    final prefs = await SharedPreferences.getInstance();
    List<Contato> contatos = await getAll();
    if (index >= 0 && index < contatos.length) {
      contatos.removeAt(index);
      List<String> listaContatosJson = contatos.map((c) => jsonEncode(c.toJson())).toList();
      await prefs.setStringList(chaveContatos, listaContatosJson);
    }
  }

  // Função para adicionar todos os contatos
  @override
  Future<void> insertAll(List<Contato> contatos) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> listaContatosJson = contatos.map((c) => jsonEncode(c.toJson())).toList();
    await prefs.setStringList(chaveContatos, listaContatosJson);
  }
}
