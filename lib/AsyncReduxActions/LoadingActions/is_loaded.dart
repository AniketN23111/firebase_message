import 'package:async_redux/async_redux.dart';
import 'package:message/app_state.dart';

class IsLoaded extends ReduxAction<AppState> {
  @override
  AppState reduce() => state.copy(loading: false);
}
