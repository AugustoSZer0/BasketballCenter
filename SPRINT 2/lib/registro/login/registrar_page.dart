import 'package:flutter/material.dart';

import '../../menu/menu_page.dart';

class RegistrarPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Basketball Center'),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(203, 0, 0, 0),
        actions: [
          IconButton(
            icon: const Icon(Icons.account_circle_rounded),
            onPressed: () {},
          ),
        ],
      ),
      drawer: const Drawer(child: MenuPage()),
    );
  }
}
