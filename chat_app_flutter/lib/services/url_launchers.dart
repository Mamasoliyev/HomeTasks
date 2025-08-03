import 'package:url_launcher/url_launcher.dart';

Future<void> phoneLauncher(String phoneNumber) async {
  String telephoneNumber = phoneNumber;
  String telephoneUrl = "tel:$telephoneNumber";
  if (await canLaunchUrl(Uri.parse(telephoneUrl))) {
    await launchUrl(Uri.parse(telephoneUrl));
  } else {
    throw "Error occured trying to call that number.";
  }
}

Future<void> instagramLauncher(String instagramUsername) async {
  var url = 'https://www.instagram.com/$instagramUsername/';

  if (await canLaunchUrl(Uri.parse(url))) {
    await launchUrl(Uri.parse(url));
  } else {
    throw 'There was a problem to open the url: $url';
  }
}

Future<void> emailLauncher(String recieverEmail) async {
  String email = recieverEmail;
  String subject = 'I want to connect with you';
  String body = 'This is a test email body';

  String emailUrl = "mailto:$email?subject=$subject&body=$body";

  if (await canLaunchUrl(Uri.parse(emailUrl))) {
    await launchUrl(Uri.parse(emailUrl));
  } else {
    throw "Error occured sending an email";
  }
}

Future<void> telegramLauncher(String userName) async {
  var url = 'https://www.t.me/$userName/';

  if (await canLaunchUrl(Uri.parse(url))) {
    await launchUrl(Uri.parse(url));
  } else {
    throw 'There was a problem to open the url: $url';
  }
}

Future<void> whatsappLauncher(String whatsappNumber) async {
  var whatsappUrl = 'https://wa.me/$whatsappNumber';
  if (await canLaunchUrl(Uri.parse(whatsappUrl))) {
    await launchUrl(Uri.parse(whatsappUrl));
  } else {
    throw 'There was a problem to open the url: $whatsappUrl';
  }
}
