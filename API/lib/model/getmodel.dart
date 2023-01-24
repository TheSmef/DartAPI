import 'package:conduit/conduit.dart';

class GetModel extends Serializable {
  String? option;
  String? type;
  bool status = true;
  int fetch = 0;
  int offset = 0;

  @override
  Map<String, dynamic>? asMap() {
    return {
      'option': option,
      'type': type,
      'status': status,
      'fetch': fetch,
      'offset': offset
    };
  }

  @override
  void readFromMap(Map<String, dynamic> object) {
    option = object["option"];
    type = object["type"];
    status = object["status"] ?? true;
    fetch = object["fetch"] ?? 0;
    offset = object["offset"] ?? 0;
  }
}
