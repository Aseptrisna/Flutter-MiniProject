import 'package:uuid/uuid.dart';

class GuidService {
  String generateGuid() {
    try {
      final uuid = Uuid();
      final guid = uuid.v4();
      print('[GenerateGUID] Error Ocurred $guid');
      return guid;
    } catch (e) {
      print('[GenerateGUID] Error Ocurred $e');

      return null;
    }
  }
}
