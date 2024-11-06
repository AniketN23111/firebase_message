import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:message/Model/user_model.dart';
import 'package:message/Views/MyHomePage/my_home_page.dart';
import 'package:message/Views/MyHomePage/my_home_page_view_model.dart';

class MyHomePageConnector extends StatelessWidget {
  final bool? isLoading;
  final UserModel? userModel;

  const MyHomePageConnector({super.key, this.isLoading, this.userModel});

  @override
  Widget build(BuildContext context) {
    return StoreConnector(
      vm: () => Factory(this),
      builder: (context, MyHomePageViewModel vm) => MyHomePage(
        isLoading: vm.isLoading,
        userModel: vm.userModel,
        signOut: vm.signOut,
      ),
    );
  }
}
