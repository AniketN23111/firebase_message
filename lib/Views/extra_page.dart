import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:message/Constants/person_service.dart';
import 'package:message/Model/personal_details.dart';

class ExtraPage extends StatefulWidget {
  const ExtraPage({super.key});

  @override
  State<ExtraPage> createState() => _ExtraPageState();
}

class _ExtraPageState extends State<ExtraPage> {
  String name = '';
  int salary = 0;
  TextEditingController _nameController = TextEditingController();
  TextEditingController _salaryController = TextEditingController();
  late Box<PersonalDetails> userBox;
  final PersonService _personService = PersonService();

  @override
  void initState() {
    super.initState();
  }

  void saveData() async {
    String name = _nameController.text.trim();
    int salary = int.parse(_salaryController.text);
    var person = PersonalDetails(name, salary);
    await _personService.addPerson(person);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 20),
            TextFormField(
              keyboardType: TextInputType.text,
              controller: _nameController,
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
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            SizedBox(height: 20),
            TextFormField(
              keyboardType: TextInputType.number,
              controller: _salaryController,
              validator: (text) {
                if (text == null || text.isEmpty) {
                  return "Salary is Empty";
                }
                return null;
              },
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                contentPadding: const EdgeInsets.all(15),
                hintText: 'Salary',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(onPressed: saveData, child: Text('Save Data')),
            SizedBox(height: 20),
            FutureBuilder(
              future: _personService.getAllPerson(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return ValueListenableBuilder(
                    valueListenable:
                        Hive.box<PersonalDetails>('personal_details')
                            .listenable(),
                    builder: (context, Box<PersonalDetails> box, _) {
                      if (box.values.isEmpty) {
                        return const Center(
                            child: Text("No person available."));
                      }
                      return Expanded(
                        child: ListView.builder(
                          itemCount: box.values.length,
                          itemBuilder: (context, index) {
                            final person = box.getAt(index);
                            return ListTile(
                              title: Text(person?.name ?? 'N/A'),
                              subtitle: Text('Salary: ${person?.salary ?? 0}'),
                              trailing: IconButton(
                                  onPressed: () {
                                    _personService.deletePerson(index);
                                  },
                                  icon: Icon(Icons.delete)),
                            );
                          },
                        ),
                      );
                    },
                  );
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
