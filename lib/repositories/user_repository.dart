import 'dart:developer';

import 'package:get/get.dart';
import 'package:get_connect_example/models/user_model.dart';

// class UserRepository extends GetConnect{

class UserRepository {
  final restCliente = GetConnect(timeout: const Duration(milliseconds: 600));

  UserRepository() {
    restCliente.httpClient.baseUrl = 'http://10.0.0.107:8080';
    // restCliente.httpClient.errorSafety = false;

    restCliente.httpClient.addRequestModifier<Object?>(
      (request) {
        //calculo de tempo de resposta
        log('URL que está sendo chamada>>>${request.url.toString()}');
        //alteração do request
        request.headers['start-time'] = DateTime.now().toIso8601String();
        return request;
      },
    );
    restCliente.httpClient.addResponseModifier((request, response) {
      response.headers?['end-time'] = DateTime.now().toIso8601String();
      return response;
    });
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

    log(result.request?.headers['start-time'] ?? '');
    log(result.headers?['end-time'] ?? '');

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
