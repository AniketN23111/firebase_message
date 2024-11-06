import 'package:message/Model/user_model.dart';

class AppState {
  final bool loading;
  final UserModel user;
  AppState({required this.loading, required this.user});

  AppState copy({bool? loading, UserModel? user}) =>
      AppState(loading: loading ?? this.loading, user: user ?? this.user);

  static AppState initState() => AppState(loading: false, user: UserModel());

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AppState && loading == other.loading && user == other.user;

  @override
  int get hashCode => loading.hashCode ^ user.hashCode;
}
