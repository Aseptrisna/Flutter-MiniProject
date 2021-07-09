/*
Bandung 23-Juni-2021
*/
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
// import 'package:shared_preferences/shared_preferences.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:shared_preferences_platform_interface/method_channel_shared_preferences.dart';
// import 'package:sharedpref/models/user_location.dart';

class getLocation {
  var locationMessage = '';
  String latitude = '0';
  String longitude = '0';
  void getCurrentLocation() async {
    var position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    var lat = position.latitude;
    var long = position.longitude;
    latitude = "$lat";
    longitude = "$long";
    getAddress(latitude, longitude);
  }

  void getAddress(lat, long) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    // final SharedPreferences prefs = await _prefs;
    // SharedPreferences? preferences;
    // preferences = await SharedPreferences.getInstance();

    // UserLocation userLocation = new UserLocation();
    double latitude = double.parse(lat);
    double longitude = double.parse(long);
    List<Placemark> placemarks =
        await placemarkFromCoordinates(latitude, longitude);
    Placemark placeMark = placemarks[0];
    String jalan = '${placeMark.street}';
    String kelurhan = '${placeMark.subLocality}';
    String kecamatan = '${placeMark.locality}';
    String kota = '${placeMark.subAdministrativeArea}';
    String prov = '${placeMark.administrativeArea}';
    String kodepos = '${placeMark.postalCode}';
    String Address =
        '${jalan},${kelurhan},${kecamatan},${kota},${prov} ${kodepos}';
    // print(Address);
    // userLocation.latitude = latitude;
    // userLocation.longitude = longitude;
    // userLocation.address = Address;
    // kirimtoRmq();
    // print("model user");
    // print(userLocation.address);
    // print("model user latitude");
    // print(userLocation.latitude);
    // print(userLocation.longitude);
    // UserLocation userLocation = UserLocation(
    //     latitude: latitude, longitude: longitude, address: Address);
    prefs.setString('userlatitude', latitude.toString());
    prefs.setString('userlongitude', longitude.toString());
    prefs.setString('prov', prov.toString());
    prefs.setString('kota', kota.toString());
    prefs.setString('useraddress', Address);
    // print(userLocation);
  }
}
