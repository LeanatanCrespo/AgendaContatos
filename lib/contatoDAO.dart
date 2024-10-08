import 'package:agenda_contatos/contato.dart';

//classe para usar DAO
abstract class ContatoDAO {
  Future<void> insert(Contato contato);
  Future<List<Contato>> getAll();
  Future<void> update(int index, Contato contato);
  Future<void> delete(int index);

  //função para colocar lista de contatos
  Future<void> insertAll(List<Contato> contatos);
}