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

  void register() {}

  void updateUser(UserModel user) {}

  void delete(UserModel user) {}
}
