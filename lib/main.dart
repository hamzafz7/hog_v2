import 'dart:async';
import 'dart:io';
import 'dart:isolate';
import 'dart:ui';

import 'package:async/async.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:encrypt/encrypt.dart' as enc;
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_windowmanager_plus/flutter_windowmanager_plus.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get_it/get_it.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hog_v2/common/routes/app_routes.dart';
import 'package:hog_v2/common/themes/themes.dart';
import 'package:hog_v2/common/utils/screen_secuirity.dart';
import 'package:hog_v2/data/http_client.dart';
import 'package:hog_v2/data/providers/apiProvider/api_provider.dart';
import 'package:hog_v2/data/providers/casheProvider/cashe_provider.dart';
import 'package:hog_v2/data/providers/notificationProvider/notification_provider.dart';
import 'package:hog_v2/data/repositories/account_repo.dart';
import 'package:hog_v2/firebase_options.dart';
import 'package:hog_v2/presentation/splashpage/page/splash_page.dart';
import 'package:path_provider/path_provider.dart';

// import 'package:video_player_media_kit/video_player_media_kit.dart';

import 'offline_videos_feature/dependency_injection/injection_container.dart';
import 'offline_videos_feature/presentation/bloc/offline_videos_bloc.dart';
import 'offline_videos_feature/presentation/controllers/video_downloader.dart';

@pragma('vm:entry-point')
void writeVideoBytes(List arg) async {
  DartPluginRegistrant.ensureInitialized();
  SendPort? sendPort = IsolateNameServer.lookupPortByName("iso_${arg[0]}");
  String basePath = await VideoDownloader().createBasePathFolder("hog_v2 Offline Videos");

  const keyEnc = "we4RYhsG7DFOdCfEDKjSLsOXcvXsdA3=";

  const int chunkSize = 1024 * 1024; // 1 MB

  // ignore: unused_local_variable
  StreamSubscription<ResponseBody>? stream;
  ChunkedStreamReader<int>? reader;
  File file = File('$basePath/video${arg[0]}.professor');
  deleteFile('$basePath/video${arg[0]}.professor');
  final key = enc.Key.fromUtf8(keyEnc);
  final iv = enc.IV.fromUtf8("e16ce888a20dadb8");
  final encrypter = enc.Encrypter(enc.AES(key, mode: enc.AESMode.sic, padding: null));
  if (kDebugMode) {
    debugPrint("DDDDDD");
  }
  int offset = 0;
  final dio = Dio(BaseOptions(
    connectTimeout: const Duration(hours: 1),
    receiveTimeout: const Duration(hours: 1),
    sendTimeout: const Duration(hours: 1),
  ));
  // ignore: unused_local_variable
  final response = await dio.get(
    arg[1],
    onReceiveProgress: (received, total) {
      double percent = (received / total * 100);
      String value =
          "${(received / total * 100).toStringAsFixed(0)}% - ${(total / 1024 / 1024).toStringAsFixed(2)}/${(received / 1024 / 1024).toStringAsFixed(2)} MB";
      sendPort?.send({"percent": percent, "value": value});
    },
    options: Options(
        responseType: ResponseType.stream,
        followRedirects: true,
        validateStatus: (status) {
          return status! < 500;
        }),
  ).then((value) async {
    int fileSize = int.tryParse((value.headers.map['content-length'])?.first ?? '-1') ?? -1;
    reader = ChunkedStreamReader((value.data as ResponseBody).stream);
    try {
      Uint8List buffer;
      do {
        buffer = await reader!.readBytes(chunkSize);
        offset += buffer.length;
        sendPort?.send(offset / fileSize);
        final encrypted = encrypter.encryptBytes(buffer, iv: iv);
        await file.writeAsBytes(encrypted.bytes, mode: FileMode.append);
      } while (buffer.length == chunkSize);
      sendPort?.send("done");
      // ignore: unused_catch_stack
    } catch (error, s) {
      await file.delete();

      if (kDebugMode) {
        print("error = ${error.toString()}");
      }
      sendPort?.send("error");
    } finally {
      reader?.cancel();
    }
  });
}

@pragma('vm:entry-point')
void decryptFile(List arg) async {
  DartPluginRegistrant.ensureInitialized();
  SendPort? sendPort = IsolateNameServer.lookupPortByName("readVideo");

  // BackgroundIsolateBinaryMessenger.ensureInitialized(arg[1]);
  try {
    const int chunkSize = 1024 * 1024; // 1 MB
    const keyEnc = "we4RYhsG7DFOdCfEDKjSLsOXcvXsdA3=";
    final key = enc.Key.fromUtf8(keyEnc);
    final iv = enc.IV.fromUtf8("e16ce888a20dadb8");
    final encrypter = enc.Encrypter(enc.AES(key, mode: enc.AESMode.sic, padding: null));
    Uint8List buffer;
    ChunkedStreamReader<int>? reader;
    var tempDir = await getApplicationDocumentsDirectory();
    String fullPath = "${tempDir.path}/test.mp4";
    String basePath = await VideoDownloader().createBasePathFolder("hog_v2 Offline Videos");
    String pathToRead = "$basePath/video${arg[0]}.professor";
    Uri myUri = Uri.parse(pathToRead);
    File eFile = File.fromUri(myUri);
    File file = File(fullPath);
    if (file.existsSync()) {
      await file.delete();
    }
    await file.create();

    reader = ChunkedStreamReader(eFile.openRead());

    final int size = await eFile.length(); //bytes
    int bufferRead = 0;
    do {
      bufferRead++;
      buffer = await reader.readBytes(chunkSize);

      final encrypted = encrypter.decryptBytes(enc.Encrypted(buffer), iv: iv);
      await file.writeAsBytes(encrypted, mode: FileMode.append);
      sendPort?.send((bufferRead * chunkSize) / size);
    } while (buffer.length == chunkSize);
    reader.cancel();
    sendPort?.send("done");

    reader.cancel();
    sendPort?.send("done");
  } catch (e, s) {
    if (kDebugMode) {
      debugPrint("****************exc writeVideoBytes");
      debugPrint(e.toString());
      debugPrint(s.toString());
    }
  }
}

Future<void> deleteFile(String filePath) async {
  try {
    final file = File(filePath);

    // Check if the file exists
    if (await file.exists()) {
      await file.delete();
      if (kDebugMode) {
        debugPrint('File deleted successfully');
      }
    } else {
      if (kDebugMode) {
        debugPrint('File not found');
      }
    }
  } catch (e) {
    if (kDebugMode) {
      debugPrint('Error deleting file: $e');
    }
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  final caCert = await rootBundle.loadString('assets/certs/caCert.pem');
  HttpOverrides.global = AppHttpOverrides(caCert);

  await GetStorage.init();

  await init();

  await GetIt.instance<CacheProvider>().init();

  await GetIt.instance<ApiProvider>().init();

  Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform).whenComplete(() {
    FireBaseAPi().initNotifications();
  });

  if (Platform.isAndroid) secureScreen();

  checkSecurityFromApi();

  await setupDi();

  // VideoPlayerMediaKit.ensureInitialized(android: true, iOS: false);

  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
  AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
  String manufacturer = androidInfo.manufacturer;
  if (kDebugMode) {
    print("manufacturer : $manufacturer");
    print("manufacturer == 'samsung' : ${manufacturer == 'samsung'}");
  }
  if (Platform.isAndroid && manufacturer == 'samsung') {
    runApp(MyAppKeyboardSamsungHandler());
  } else {
    runApp(MyApp());
  }
}

checkSecurityFromApi() async {
  AccountRepo accountRepo = AccountRepo();
  var response = await accountRepo.getScreenShoots();
  if (Platform.isIOS) {
    if (response.success) {
      if (kDebugMode) {
        print(response.data);
      }
      if (response.data["screenshot"] == true) {
        GetIt.instance<ScreenSecurity>().toggleScreenSecurity(true);
      } else {
        GetIt.instance<ScreenSecurity>().toggleScreenSecurity(false);
      }
    } else {
      GetIt.instance<ScreenSecurity>().toggleScreenSecurity(true);
    }
  }
}

Future<void> secureScreen() async {
  await FlutterWindowManagerPlus.addFlags(FlutterWindowManagerPlus.FLAG_SECURE);
}

class MyAppKeyboardSamsungHandler extends StatefulWidget {
  const MyAppKeyboardSamsungHandler({super.key});

  @override
  State<MyAppKeyboardSamsungHandler> createState() => _MyAppKeyboardSamsungHandlerState();
}

class _MyAppKeyboardSamsungHandlerState extends State<MyAppKeyboardSamsungHandler> {
  late KeyboardVisibilityController keyboardVisibilityController;

  @override
  void initState() {
    super.initState();
    keyboardVisibilityController = GetIt.instance<KeyboardVisibilityController>();
  }

  @override
  void didChangeDependencies() {
    FocusManager.instance.primaryFocus?.unfocus();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return KeyboardVisibilityProvider(
      controller: keyboardVisibilityController,
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
        child: MyApp(),
      ),
    );
  }
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var appKey = UniqueKey();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<OfflineVideosBloc>(create: (context) => getIt<OfflineVideosBloc>()),
      ],
      child: ScreenUtilInit(
        designSize: const Size(393, 852),
        minTextAdapt: true,
        splitScreenMode: true,
        fontSizeResolver: (fontSize, instance) {
          final display = View.of(context).display;
          final screenSize = display.size / display.devicePixelRatio;
          final scaleWidth = screenSize.width / 393;
          return fontSize * scaleWidth;
        },
        builder: (_, __) => GetMaterialApp(
          key: appKey,
          debugShowCheckedModeBanner: false,
          theme: lighttheme,
          darkTheme: darkTheme,
          themeMode:
              GetIt.instance<CacheProvider>().getAppTheme() ? ThemeMode.dark : ThemeMode.light,
          locale: const Locale('ar'),
          getPages: AppRoute.pages,
          home: const SplashPage(),
        ),
      ),
    );
  }
}
