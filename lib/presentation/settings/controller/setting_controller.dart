import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingController extends GetxController {
  void launchTelegramURL() async {
    const url = 'https://t.me/Mk_0934'; // Replace with your actual Telegram link
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      throw 'Could not launch $url';
    }
  }

  void launchWhatsAppURL() async {
    const phoneNumber = '0945364375';
    const url = 'whatsapp://send?phone=$phoneNumber';

    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      throw 'Could not launch $url';
    }
  }
}
