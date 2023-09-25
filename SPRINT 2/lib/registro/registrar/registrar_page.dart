import 'package:flutter/material.dart';

class RegistrarPage extends StatefulWidget {
  @override
  _RegistrarPageState createState() => _RegistrarPageState();
}

class _RegistrarPageState extends State<RegistrarPage> {
  String? _selectedItem; // Altera o tipo de dados para String?

  final List<String> _items = [
    'Time 1',
    'Time 2',
    'Time 3',
    'Time 4',
    'Time 5',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registrar'),
        backgroundColor: const Color.fromARGB(203, 0, 0, 0),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Registrar',
              style: TextStyle(
                fontSize: 32.0,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16.0),
            Container(
              width: 280.0,
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Username',
                  hintStyle: TextStyle(color: Colors.black),
                  border: OutlineInputBorder(),
                ),
                style: TextStyle(color: Colors.black),
              ),
            ),
            SizedBox(height: 16.0),
            Container(
              width: 280.0,
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Email',
                  hintStyle: TextStyle(color: Colors.black),
                  border: OutlineInputBorder(),
                ),
                style: TextStyle(color: Colors.black),
              ),
            ),
            SizedBox(height: 16.0),
            Container(
              width: 280.0,
              child: TextField(
                obscureText: true,
                decoration: InputDecoration(
                  hintText: 'Senha',
                  hintStyle: TextStyle(color: Colors.black),
                  border: OutlineInputBorder(),
                ),
                style: TextStyle(color: Colors.black),
              ),
            ),
            SizedBox(height: 16.0),
            DropdownButton<String>(
                value: _selectedItem,
                items: _items.map((String item) {
                    return DropdownMenuItem<String>(
                    value: item,
                    child: Text(item),
                    );
                }).toList(),
                onChanged: (String? selectedItem) {
                    setState(() {
                    _selectedItem = selectedItem;
                    });
                },
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {},
              child: Text('Registrar'),
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(100, 50),
                backgroundColor: const Color.fromARGB(203, 0, 0, 0),
              ),
            ),
          ],
        ),
      ),
    );
  }
}