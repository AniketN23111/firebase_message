import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class Extrapage extends StatefulWidget {
  const Extrapage({super.key});

  @override
  State<Extrapage> createState() => _ExtrapageState();
}

class _ExtrapageState extends State<Extrapage> {
  String name = '';
  TextEditingController _name = TextEditingController();
  late final userBox;

  @override
  void initState() {
    super.initState();
    userBox = Hive.box('hive_box');
    name = userBox.get('name') ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          children: [
            Text(name),
            SizedBox(
              height: 20,
            ),
            TextFormField(
              keyboardType: TextInputType.text,
              controller: _name,
              validator: (text) {
                if (text == null || text.isEmpty) {
                  return "Name is Empty";
                }
                return null;
              },
              decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: const EdgeInsets.all(15),
                  hintText: 'Name',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide.none)),
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
                onPressed: () {
                  setState(() {
                    userBox.put('name', _name.text);
                  });
                },
                child: Text('Chnage Name')),
          ],
        ),
      ),
    );
  }
}
