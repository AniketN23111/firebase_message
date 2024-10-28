import 'package:hive/hive.dart';
part 'personal_details.g.dart';

@HiveType(typeId: 0)
class PersonalDetails {
  @HiveField(0)
  final String name;
  @HiveField(1)
  final int salary;
  const PersonalDetails(this.name, this.salary);
}
