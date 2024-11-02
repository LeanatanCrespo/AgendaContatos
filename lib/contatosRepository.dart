import 'package:agenda_contatos/contato.dart';
import 'package:agenda_contatos/contatoDAO.dart';
import 'package:agenda_contatos/persistencia.dart';

//repositorio de DAO
class ContatosRepository {
  final List<Contato> contatos = [];
  final ContatoDAO contatoDAO = ContatoDAOImpl();

  ContatosRepository() {
    _carregarContatos();
  }

  // Carrega os contatos ao iniciar
  void _carregarContatos() async {
    contatos.addAll(await contatoDAO.getAll());
  }

  // Adiciona um contato e o salva
  void addContatos(Contato c) {
    contatos.add(c);
    _salvarContatos();
  }

  // Retorna a lista de contatos cadastrados
  List<Contato> getContatos() {
    return contatos;
  }

  // Deleta um contato
  void deleteContato(int index) {
    if (index >= 0 && index < contatos.length) {
      contatos.removeAt(index);
      _salvarContatos();
    }
  }

  // Edita um contato
  void editaContato(int index, Contato c) {
    if (index >= 0 && index < contatos.length) {
      contatos[index] = c;
      _salvarContatos();
    }
  }

  // Salva a lista de contatos na memória
  void _salvarContatos() async {
    await contatoDAO.insertAll(contatos);
  }
}

/*
import 'package:agenda_contatos/contato.dart';
import 'package:agenda_contatos/contatoDAO.dart';
import 'package:agenda_contatos/persistencia.dart';

class ContatosRepository {
  final List<Contato> _contatos = [];
  final ContatoDAO contatoDAO = ContatoDAOImpl();

  ContatosRepository() {
    _carregarContatos();
  }

  // Carrega os contatos ao iniciar
  Future<void> _carregarContatos() async {
    try {
      _contatos.clear();
      _contatos.addAll(await contatoDAO.getAll());
    } catch (e) {
      print("Erro ao carregar contatos: $e");
    }
  }

  // Adiciona um contato e o salva
  Future<void> addContato(Contato c) async {
    _contatos.add(c);
    await _salvarContatos();
  }

  // Retorna a lista de contatos cadastrados
  List<Contato> get contatos {
    return List.unmodifiable(_contatos); // Retorna uma lista imutável para segurança
  }

  // Deleta um contato
  Future<void> deleteContato(int index) async {
    if (index >= 0 && index < _contatos.length) {
      _contatos.removeAt(index);
      await _salvarContatos();
    }
  }

  // Edita um contato
  Future<void> editaContato(int index, Contato c) async {
    if (index >= 0 && index < _contatos.length) {
      _contatos[index] = c;
      await _salvarContatos();
    }
  }

  // Salva a lista de contatos na memória
  Future<void> _salvarContatos() async {
    try {
      await contatoDAO.insertAll(_contatos);
    } catch (e) {
      print("Erro ao salvar contatos: $e");
    }
  }

  // Método para recarregar a lista de contatos (caso necessário)
  Future<void> refreshContatos() async {
    await _carregarContatos();
  }
}
*/

/*
import 'package:agenda_contatos/contato.dart';
import 'package:agenda_contatos/persistencia.dart';

//repositorios do CRUD do codigo
class ContatosRepository {
  final List<Contato> contatos = [];
  final PersistenciaContatos persistencia = PersistenciaContatos();

  ContatosRepository() {
    _carregarContatos();
  }

  // Carrega os contatos ao iniciar
  void _carregarContatos() async {
    contatos.addAll(await persistencia.carregarContatos());
    print('Contatos carregados: $contatos');
  }

  // Adiciona um contato e o salva
  void addContatos(Contato c) {
    contatos.add(c);
    _salvarContatos();
  }

  // Retorna a lista de contatos cadastrados
  List<Contato> getContatos() {
    return contatos;
  }

  // Deleta um contato
  void deleteContato(int index) {
    if (index >= 0 && index < contatos.length) {
      contatos.removeAt(index);
      _salvarContatos();
    }
  }

  // Edita um contato
  void editaContato(int index, Contato c) {
    if (index >= 0 && index < contatos.length) {
      contatos[index] = c;
      _salvarContatos();
    }
  }

  // Salva a lista de contatos na memória
  void _salvarContatos() async {
    await persistencia.salvarContatos(contatos);
    print('Contatos salvos: ${contatos.map((c) => c.toJson()).toList()}');
  }
}
*/