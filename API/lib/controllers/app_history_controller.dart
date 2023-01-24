import 'package:conduit/conduit.dart';
import 'package:dart_application_1/model/financialrecord.dart';
import 'package:dart_application_1/model/historyrecord.dart';
import '../utilts/appresponse.dart';

class AppHistoryConroller extends ResourceController {
  AppHistoryConroller(this.managedContext);

  final ManagedContext managedContext;

  @Operation.put("restoreFinancialRecord")
  Future<Response> restoreRecord(@Bind.query("id") int? id) async {
    try {
      final qUpdateRecord = Query<FinancialRecord>(managedContext)
        ..where((element) => element.id).equalTo(id)
        ..values.status = true;
      var record = await qUpdateRecord.updateOne();
      await managedContext.transaction((transaction) async {
        final qCreateHistory = Query<HistoryRecord>(transaction)
          ..values.operation = "Востановление записи"
          ..values.date = DateTime.now()
          ..values.record = record;
        await qCreateHistory.insert();
      });
      return AppResponse.ok(
        message: 'Успешное востановление данных',
      );
    } catch (e) {
      return AppResponse.serverError(e,
          message: 'Ошибка восстановления данных');
    }
  }

  @Operation.get()
  Future<Response> getHistory() async {
    try {
      var records = Query<HistoryRecord>(managedContext)
        ..join(
          object: (x) => x.record,
        );
      final List<HistoryRecord> response = await records.fetch();
      if (response.isEmpty) {
        return Response.noContent();
      }
      return Response.ok(response);
    } catch (e) {
      return AppResponse.serverError(e, message: 'Ошибка получения данных');
    }
  }

  @Operation.delete()
  Future<Response> clearHistory() async {
    try {
      var query = Query<HistoryRecord>(managedContext)
        ..canModifyAllInstances = true;
      var response = await query.delete();
      return AppResponse.ok(
          message:
              'Успешная очистка истории, количество удалённых записей $response');
    } catch (e) {
      return AppResponse.serverError(e, message: 'Ошибка получения данных');
    }
  }
}
