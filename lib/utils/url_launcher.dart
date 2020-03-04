import 'package:url_launcher/url_launcher.dart';

class UrlLauncherUtil {
  static Future<bool> launchGoogleSearch(String searchString) async {
    String query = searchString.replaceAll(' ', '+');
    String url = 'https://www.google.com/search?q=$query';
    var result;

    if (await canLaunch(url)) {
      await launch(url, forceSafariVC: false);
      result = true;
    } else {
      result = false;
    }
    return result;
  }

  static Future<bool> launchEmail(String email) async {
    //String query = searchString.replaceAll(' ', '+');
    String url = 'mailto:';
    var result;

    if (await canLaunch(url)) {
      await launch(url, forceSafariVC: false);
      result = true;
    } else {
      result = false;
    }
    return result;
  }

  static Future<bool> launchPhone(String number) async {
    //String query = searchString.replaceAll(' ', '+');
    String url = 'tel:';
    var result;

    if (await canLaunch(url)) {
      await launch(url, forceSafariVC: false);
      result = true;
    } else {
      result = false;
    }
    return result;
  }
}
