import 'package:async_redux/async_redux.dart';
import 'package:message/AsyncReduxActions/LoginScreen/google_sign_in_action.dart';
import 'package:message/Model/user_model.dart';
import 'package:message/Views/LoginScreen/login_screen_connector.dart';
import 'package:message/app_state.dart';

// ignore: must_be_immutable
class LoginScreenViewModel extends Vm {
  final bool isLoading;
  late void Function() googleSignIn;
  final UserModel user;
  LoginScreenViewModel(
      {required this.isLoading, required this.googleSignIn, required this.user})
      : super(equals: [isLoading, user]);
}

class Factory
    extends VmFactory<AppState, LoginScreenConnector, LoginScreenViewModel> {
  Factory(connector) : super(connector);

  @override
  LoginScreenViewModel? fromStore() => LoginScreenViewModel(
      isLoading: state.loading,
      user: state.user,
      googleSignIn: () => dispatch(GoogleSignInAction()));
}
