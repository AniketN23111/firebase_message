import 'package:async_redux/async_redux.dart';
import 'package:message/Views/Register/register_screen_connector.dart';
import 'package:message/app_state.dart';

class RegisterScreenViewModel extends Vm {
  final bool isLoading;
  RegisterScreenViewModel({required this.isLoading})
      : super(equals: [isLoading]);
}

class Factory extends VmFactory<AppState, RegisterScreenConnector,
    RegisterScreenViewModel> {
  Factory(connector) : super(connector);

  @override
  RegisterScreenViewModel? fromStore() =>
      RegisterScreenViewModel(isLoading: state.loading);
}
