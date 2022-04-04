import 'package:shared_preferences/shared_preferences.dart';

class Location{

  double? lat;
  double? lon;
  String? locationName;
  String? countryName;
  //var list;

  Location({
    this.lat,
    this.lon,
    this.locationName,
    this.countryName
    //this.list,
  });

  Future<Location> newFunction(List<dynamic> json) async {
    Location location = await Location.fromJson(json);
    print('constructor finished');
    //return await Location.fromJson(json);
    await sprefAction(location.lat!, location.lon!, location.locationName!, location.countryName!);
    print('finished spref action');
    return location;
  }

  Location.fromJson(List<dynamic> json){
    lat = json[0]['lat'];
    lon = json[0]['lon'];
    locationName = json[0]['local_names']['ru'];
    countryName = json[0]['country'];
    //sprefAction();
  }

  Future<void> sprefAction(double lat, double lon, String locationName, String countryName) async {
    print('entered spref action');
    SharedPreferences spref = await SharedPreferences.getInstance();
    spref.setDouble('lat', lat);
    spref.setDouble('lon', lon);
    spref.setString('locationName', locationName);
    spref.setString('countryName', countryName);
    print('sprefAction lat $lat');
    print('sprefAction lat $lon');
    print('exited spref action');
  }
}