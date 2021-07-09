import 'dart:convert';
import 'dart:io';

// import 'package:sunpride/constants/const.dart';
import 'package:ftpclient/ftpclient.dart';
import 'package:mini_project/Service/rmq_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FtpService {
  Future<bool> uploadFile(File file, String deskripsi) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final date = DateTime.now().millisecondsSinceEpoch.toString();
    final timestamp = date.substring(0, 10);
    print(prefs.getString('useraddress'));
    String guid = prefs.getString('guid_id');
    String Deskripsi = deskripsi;
    String company = "";
    String reportType = "report";
    String alamat = prefs.getString('useraddress');
    String nama = prefs.getString('nama');
    String latitude = prefs.getString('userlatitude');
    String longitude = prefs.getString('userlongitude');
    String kota = prefs.getString('kota');
    String prov = prefs.getString('prov');
    String gambar = '/kehadiran/image/' + '$guid$timestamp-PPTIK.jpg';
    String gambarlocal = file.toString();

    FTPClient client = FTPClient('pasar.pptik.id',
        user: 'pasar', pass: 'b4lanj!d!pas4R', port: 2121);
    try {
      client.connect();
      client.changeDirectory('/kehadiran/image/');
      await client.uploadFile(file, sRemoteName: '$guid$timestamp-PPTIK.jpg');
    } catch (e) {
      print('[uploadFile] - error ocurred $e');
      return false;
      // print("");
    } finally {
      Publish(guid, reportType, alamat, latitude, longitude, gambar, company,
          nama, kota, prov, gambarlocal, deskripsi, timestamp);
      print("sip");
      client.disconnect();
    }
    return true;
  }

  Future<void> Publish(
      String guid,
      String reportType,
      String alamat,
      String latitude,
      String longitude,
      String gambar,
      String company,
      String nama,
      String kota,
      String prov,
      String gambarlocal,
      String deskripsi,
      String timestamp) {
    RMQService rmqService = new RMQService();
    var message = {
      "NAME": nama,
      "LONG": longitude,
      "LAT": latitude,
      "ADDRESS": alamat,
      "STATUS": "HADIR",
      "LOCAL_IMAGE": gambarlocal,
      "TIMESTAMP": timestamp,
      "IMAGE": gambar,
      "GUID": guid,
      "COMPANY": company,
      "UNIT": "Uji coba",
      "DESCRIPTION": deskripsi,
      "AREA": prov,
      "DISTRICT": kota
    };
    String str = json.encode(message);
    print(str);
    rmqService.publish(str);
  }
}
