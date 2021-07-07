import 'dart:io';

// import 'package:sunpride/constants/const.dart';
import 'package:ftpclient/ftpclient.dart';

class FtpService {
  Future<bool> uploadFile(File file, String guid, String ts) async {
    FTPClient client =
        FTPClient('', user: 'pasar', pass: 'b4lanj!d!pas4R', port: 2121);
    try {
      client.connect();
      client.changeDirectory('/kehadiran/image/');
      await client.uploadFile(file, sRemoteName: '$guid$ts-PPTIK.jpg');
    } catch (e) {
      print('[uploadFile] - error ocurred $e');
      return false;
    } finally {
      print("sip");
      client.disconnect();
    }

    return true;
  }
}
