import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_connect_example/pages/home/home_controller.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
      body: controller.obx(
        (state) {
          if (state == null) {
            return const Center(
              child: Text("Nenhum usuário cadastradp"),
            );
          }
          return ListView.builder(
              itemBuilder: (context, index) {
                final user = state[index];
                return ListTile(
                  title: Text(user.name),
                  subtitle: Text(user.email),
                );
              },
              itemCount: state.length);
        },
        onEmpty: const Center(child: Text('Nenhum usuário cadastrado')),
        onError: (error) =>
            const Center(child: Text('Erro ao buscar usuários')),
      ),
    );
  }
}
