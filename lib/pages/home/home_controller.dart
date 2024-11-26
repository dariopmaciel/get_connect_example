import 'package:get/get.dart';
import 'package:get_connect_example/models/user_model.dart';
import 'package:get_connect_example/repositories/user_repository.dart';

class HomeController extends GetxController with StateMixin<List<UserModel>> {
  final UserRepository _repository;

  HomeController({
    required UserRepository repository,
  }) : _repository = repository;

  Future<void> _findAll() async {
    change([], status: RxStatus.loading());

    final user = await _repository.findAll();
  }

  void register() {}

  void updateUser(UserModel user) {}

  void delete(UserModel user) {}
}
