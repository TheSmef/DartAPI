
import 'package:conduit/conduit.dart';
import 'package:dart_application_1/model/historyrecord.dart';

class FinancialRecord extends ManagedObject<_FinancialRecord>
    implements _FinancialRecord {
        Map<String,dynamic> toJson()=> asMap();
    }

class _FinancialRecord {
  @primaryKey
  int? id;
  @Column(indexed: true)
  String? operationName;
  @Column(nullable: true)
  String? description;
  @Column(nullable: false)
  String? category;
  @Column(nullable: false)
  DateTime? date;
  @Column(nullable: false)
  double? sum;
  @Column(nullable: false, indexed: true)
  bool? status;
  @Serialize(input: false, output: false)
  ManagedSet<HistoryRecord>? history;
}
