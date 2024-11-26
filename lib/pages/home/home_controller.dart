import 'dart:developer';

import 'package:get/get.dart';
import 'package:get_connect_example/models/user_model.dart';
import 'package:get_connect_example/repositories/user_repository.dart';

class HomeController extends GetxController with StateMixin<List<UserModel>> {
  final UserRepository _repository;

  HomeController({
    required UserRepository repository,
  }) : _repository = repository;

  @override
  onReady() {
    _findAll();
    super.onReady();
  }

  Future<void> _findAll() async {
    try {
      change([], status: RxStatus.loading());
      final users = await _repository.findAll();
      var statusReturn = RxStatus.success();
      if (users.isEmpty) {
        statusReturn = RxStatus.empty();
      }
      change(users, status: statusReturn);
    } catch (e, s) {
      log('Erro ao buscar usuparios', error: e, stackTrace: s);
      change(state, status: RxStatus.error());
    }
  }

  Future<void> register() async {
    try {
      final user = UserModel(
        name: 'Dario P. Maciel',
        email: 'dariodepaulamaciel@hotmail.com ',
        password: '1234',
      );
      await _repository.save(user);
      _findAll();
    } catch (e, s) {
      log('Erro ao salvar usuario', error: e, stackTrace: s);
      Get.snackbar('Erro', 'Erro ao salvar usuario');
    }
  }

  Future<void> updateUser(UserModel user) async {
    try {
      user.name = 'Dario P Maciel';
      user.email = 'ddmaciel@gmail.com';
      await _repository.updateUser(user);
      _findAll();
    } catch (e, s) {
      log('Erro ao atualizar usuario', error: e, stackTrace: s);
      Get.snackbar('Erro', 'Erro ao atualizar usuario');
    }
  }

  Future<void> delete(UserModel user) async {
    await _repository.deleteUser(user);
    Get.snackbar('Sucesso', "Usuario deletado com sucesso");
    _findAll();
  }
}
