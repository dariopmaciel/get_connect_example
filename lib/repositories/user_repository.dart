import 'package:get/get.dart';
import 'package:get_connect_example/models/user_model.dart';

// class UserRepository extends GetConnect{

class UserRepository {
  final restCliente = GetConnect(timeout: const Duration(milliseconds: 600));

  UserRepository() {
    restCliente.httpClient.baseUrl = 'http://10.0.0.107:8080';
    // restCliente.httpClient.errorSafety = false;
  }

  Future<List<UserModel>> findAll() async {
    //getter
    final result = await restCliente.get(
      '/users',
    );

    if (result.hasError) {
      throw Exception(
          'Erro ao buscar usuário ->(${result.statusText})->(${result.statusCode})->(${result.status})');
    }

    return result.body
        .map<UserModel>((user) => UserModel.fromMap(user))
        .toList();
  }

  Future<void> save(UserModel user) async {
    final result = await restCliente.post('/users', user.toMap());
    if (result.hasError) {
      throw Exception(
          "Erro ao salvar usuario (${result.statusText})-(${result.statusCode})-(${result.status})");
    }
  }

  Future<void> deleteUser(UserModel user) async {
    final result = await restCliente.delete('/users/${user.id}');
    if (result.hasError) {
      throw Exception(
          "Erro ao salvar usuario (${result.statusText})-(${result.statusCode})-(${result.status})");
    }
  }

  Future<void> updateUser(UserModel user) async {
    final result = await restCliente.put('/users/${user.id}', user.toMap());
    if (result.hasError) {
      throw Exception(
          "Erro ao atualizar usuario (${result.statusText})-(${result.statusCode})-(${result.status})");
    }
  }
}
