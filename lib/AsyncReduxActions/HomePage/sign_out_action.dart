import 'dart:async';

import 'package:async_redux/async_redux.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:message/Model/user_model.dart';
import 'package:message/app_state.dart';

class SignOutAction extends ReduxAction<AppState> {
  @override
  Future<AppState?> reduce() async {
    await FirebaseAuth.instance.signOut();
    return state.copy(user: UserModel());
  }
}
