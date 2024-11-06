import 'package:firebase_auth/firebase_auth.dart';

class UserModel {
  int? id;
  String? email;
  String? name;

  UserModel({this.id, this.email, this.name});

  // Method to create a UserModel from Firebase User
  factory UserModel.fromFirebaseUser(User user) {
    return UserModel(
      email: user.email,
      name: user.displayName,
      id: user.uid.hashCode,
    );
  }
}
