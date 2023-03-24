import 'package:conduit/conduit.dart';
import 'package:dart_application_1/controllers/app_financialrecord_controller.dart';
import 'package:dart_application_1/controllers/app_history_controller.dart';
import 'dart:io';

import 'controllers/app_auth_conroller.dart';
import 'controllers/app_token_controller.dart';
import 'controllers/app_user_controller.dart';


class AppService extends ApplicationChannel {
  late final ManagedContext managerContext;

  @override
  Future prepare() {
    final persistentStore = _initDatabase();

    managerContext = ManagedContext(
        ManagedDataModel.fromCurrentMirrorSystem(), persistentStore);
    return super.prepare();
  }

  @override
  Controller get entryPoint => Router()
    ..route('token/[:refresh]').link(
      () => AppAuthContoller(managerContext),
    )
    ..route('user')
        .link(AppTokenContoller.new)!
        .link(() => AppUserConttolelr(managerContext))
    ..route(
      'records/[:getRecord]',
    )
        .link(AppTokenContoller.new)!
        .link(() => AppFinancialRecordConroller(managerContext))
    ..route('history/[:restoreFinancialRecord]')
        .link(AppTokenContoller.new)!
        .link(() => AppHistoryConroller(managerContext));

  PersistentStore _initDatabase() {
    final username = Platform.environment['DB_USERNAME'] ?? 'postgres';
    final password = Platform.environment['DB_PASSWORD'] ?? '123';
    final host = Platform.environment['DB_HOST'] ?? '127.0.0.1';
    final port = int.parse(Platform.environment['DB_PORT'] ?? '5432');
    final databaseName = Platform.environment['DB_NAME'] ?? 'dartbase';
    return PostgreSQLPersistentStore(
        username, password, host, port, databaseName);
  }
}
