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