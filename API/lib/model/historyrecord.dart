import 'package:conduit/conduit.dart';
import 'package:dart_application_1/model/financialrecord.dart';

class HistoryRecord extends ManagedObject<_HistoryRecord>
    implements _HistoryRecord {}

class _HistoryRecord {
  @primaryKey
  int? id;
  @Column(indexed: true)
  String? operation;
  @Column(nullable: false)
  DateTime? date;
  @Relate(#history, isRequired: true, onDelete: DeleteRule.cascade)
  FinancialRecord? record;
}
