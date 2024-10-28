import 'package:message/Model/personal_details.dart';
import 'package:hive_flutter/hive_flutter.dart';

class PersonService {
  final String _boxName = "personal_details";

  Future<Box<PersonalDetails>> get _box async =>
      await Hive.openBox<PersonalDetails>(_boxName);

//create
  Future<void> addPerson(PersonalDetails personModel) async {
    var box = await _box;
    await box.add(personModel);
  }

//read
  Future<List<PersonalDetails>> getAllPerson() async {
    var box = await _box;
    return box.values.toList();
  }

//update
  Future<void> updateDeck(int index, PersonalDetails personModel) async {
    var box = await _box;
    await box.putAt(index, personModel);
  }

//delete
  Future<void> deletePerson(int index) async {
    var box = await _box;
    await box.deleteAt(index);
  }
}
