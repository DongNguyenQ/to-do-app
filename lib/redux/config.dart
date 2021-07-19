import 'package:redux/redux.dart';
import 'package:to_do_app/redux/app_state.dart';
import 'package:to_do_app/redux/reducers.dart';

import 'middleware.dart';

class ReduxConfig {

  Future<Store<AppState>> getStore() async {
    return Store<AppState>(
        appStateReducer,
        initialState: AppState.initialState(),
        middleware: appStateMiddleware()
    );
  }

}