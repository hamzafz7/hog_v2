import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:hog_v2/common/utils/screen_secuirity.dart';
import 'package:hog_v2/common/utils/utils.dart';
import 'package:hog_v2/data/providers/apiProvider/api_provider.dart';
import 'package:hog_v2/data/providers/casheProvider/cashe_provider.dart';
import 'package:hog_v2/data/repositories/account_repo.dart';
import 'package:injectable/injectable.dart';

import 'injection_container.config.dart';

final getIt = GetIt.instance;

@InjectableInit(
  initializerName: r'$initGetIt', // default
  preferRelativeImports: true, // default
  asExtension: false, // default
)
Future<void> setupDi() => $initGetIt(getIt);

Future<void> init() async {
  if (kDebugMode) {
    print("Start init di");
  }

  GetIt.instance.registerLazySingleton<AccountRepo>(() => AccountRepo());
  GetIt.instance.registerLazySingleton<ApiProvider>(() => ApiProvider());
  GetIt.instance.registerLazySingleton<ScreenSecurity>(() => ScreenSecurity());
  GetIt.instance.registerLazySingleton<Utils>(() => Utils());
  GetIt.instance.registerLazySingleton<CacheProvider>(() => CacheProvider());

  if (kDebugMode) {
    print("End init di");
  }
}
