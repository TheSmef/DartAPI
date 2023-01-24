import 'package:conduit/conduit.dart';
import 'package:dart_application_1/model/financialrecord.dart';
import 'package:dart_application_1/model/getmodel.dart';
import '../model/modelresponse.dart';
import '../utilts/appresponse.dart';

class AppRestoreConroller extends ResourceController {
  AppRestoreConroller(this.managedContext);

  final ManagedContext managedContext;
}