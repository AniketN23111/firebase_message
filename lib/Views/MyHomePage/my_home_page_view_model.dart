import 'package:async_redux/async_redux.dart';
import 'package:message/AsyncReduxActions/HomePage/sign_out_action.dart';
import 'package:message/Model/user_model.dart';
import 'package:message/Views/MyHomePage/my_home_page_connector.dart';
import 'package:message/app_state.dart';

// ignore: must_be_immutable
class MyHomePageViewModel extends Vm {
  final bool isLoading;
  final UserModel userModel;
  late void Function() signOut;
  MyHomePageViewModel(
      {required this.isLoading, required this.userModel, required this.signOut})
      : super(equals: [isLoading, userModel]);
}

class Factory
    extends VmFactory<AppState, MyHomePageConnector, MyHomePageViewModel> {
  Factory(connector) : super(connector);

  @override
  MyHomePageViewModel? fromStore() => MyHomePageViewModel(
      isLoading: state.loading,
      userModel: state.user,
      signOut: () => dispatch(SignOutAction()));
}
