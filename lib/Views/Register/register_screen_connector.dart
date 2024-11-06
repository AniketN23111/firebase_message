import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:message/Views/Register/register_screen.dart';
import 'package:message/Views/Register/register_screen_view_model.dart';

class RegisterScreenConnector extends StatelessWidget {
  final bool? isLoading;
  const RegisterScreenConnector({super.key, this.isLoading});

  @override
  Widget build(BuildContext context) {
    return StoreConnector(
      vm: () => Factory(this),
      builder: (context, RegisterScreenViewModel vm) => RegisterScreen(
        isLoading: vm.isLoading,
      ),
    );
  }
}
