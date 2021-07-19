import 'dart:convert';

import 'package:to_do_app/redux/app_state.dart';
import 'package:to_do_app/services/prefs_service.dart';
import 'package:to_do_app/shared/consts.dart';

class TodoRepository {
  final SharePreferencesService service;

  const TodoRepository({this.service = const SharePreferencesService()});

  Future<String?> saveAppStateToPrefs(AppState state) {
    final dataString = json.encode(state.toJson());
    return service.saveData(spAppStateKey, dataString);
  }

  Future<AppState?> loadAppStateFromPrefs() {
    return service.loadData(spAppStateKey);
  }
}