import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:redux_dev_tools/redux_dev_tools.dart';
import 'package:to_do_app/redux/app_state.dart';
import 'package:to_do_app/redux/actions.dart';
import 'package:to_do_app/redux/middleware.dart';
import 'package:to_do_app/redux/reducers.dart';

import 'main_bottom_nav_bar.dart';

final store = DevToolsStore<AppState>(
  appStateReducer,
  initialState: AppState.initialState(),
  middleware: appStateMiddleware()
);

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp(store: store));
}

class MyApp extends StatelessWidget {

  final Store<AppState> store;

  const MyApp({Key? key, required this.store}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreProvider(
      store: store,
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Colors.black,
          primarySwatch: Colors.blue,
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              // elevation: 0.0,
              // backgroundColor:
              primary: Colors.black
            )
          )
        ),
        home: StoreBuilder<AppState>(
          onInit: (store) => store.dispatch(GetAllTodoAction()),
          builder: (BuildContext context, Store<AppState> store) {
            return MainNavigationWrapper();
          },
        )
      ),
    );
  }
}




