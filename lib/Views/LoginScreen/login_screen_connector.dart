import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:message/Model/user_model.dart';
import 'package:message/Views/LoginScreen/login_screen.dart';
import 'package:message/Views/LoginScreen/login_screen_view_model.dart';

class LoginScreenConnector extends StatelessWidget {
  final bool? isLoading;
  final UserModel? user;
  const LoginScreenConnector({super.key, this.isLoading, this.user});

  @override
  Widget build(BuildContext context) {
    return StoreConnector(
      vm: () => Factory(this),
      builder: (context, LoginScreenViewModel vm) => LoginScreen(
        isLoading: vm.isLoading,
        googleSignIn: () => vm.googleSignIn(),
      ),
    );
  }
}
