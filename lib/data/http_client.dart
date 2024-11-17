import 'dart:convert';
import 'dart:io';

/// fix network issue on Android 7.0
class AppHttpOverrides extends HttpOverrides {
  final String caCert;

  AppHttpOverrides(this.caCert);

  @override
  HttpClient createHttpClient(SecurityContext? context) {
    context ??= SecurityContext(withTrustedRoots: false);
    context.setTrustedCertificatesBytes(utf8.encode(caCert));
    final httpClient = super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port) => true;
    return httpClient;
  }
}
