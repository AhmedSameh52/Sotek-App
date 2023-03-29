import 'package:url_launcher/url_launcher.dart';

class MapUtils {
  MapUtils();

  static Future<void> openMap(String place) async {
    String googleUrl = "https://www.google.com/maps/search/?api=1&query=$place";
    if (await canLaunch(googleUrl)) {
      await launch(googleUrl);
    } else {
      throw 'Could not open the map.';
    }
  }
}
