import 'dart:async';

import 'package:async_redux/async_redux.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:message/AsyncReduxActions/LoadingActions/is_loaded.dart';
import 'package:message/AsyncReduxActions/LoadingActions/is_loading.dart';
import 'package:message/Model/user_model.dart';
import 'package:message/app_state.dart';

class GoogleSignInAction extends ReduxAction<AppState> {
  @override
  Future<AppState?> reduce() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    UserCredential userCredential =
        await FirebaseAuth.instance.signInWithCredential(credential);

    User? currentUser = userCredential.user;
    if (currentUser != null) {
      final userModel = UserModel.fromFirebaseUser(currentUser);
      return state.copy(user: userModel);
    } else {
      return state.copy(user: UserModel());
    }
  }

  @override
  void after() {
    dispatch(IsLoaded());
    super.after();
  }

  @override
  void before() {
    dispatch(IsLoading());
    super.before();
  }
}
