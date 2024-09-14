// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i7;
import 'package:flutter_secure_storage/flutter_secure_storage.dart' as _i4;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:shared_preferences/shared_preferences.dart' as _i3;

import '../helpers/prefs_helper.dart' as _i5;
import '../presentation/bloc/offline_videos_bloc.dart' as _i6;
import 'register_module.dart' as _i8;

// initializes the registration of main-scope dependencies inside of GetIt
Future<_i1.GetIt> $initGetIt(
  _i1.GetIt getIt, {
  String? environment,
  _i2.EnvironmentFilter? environmentFilter,
}) async {
  final gh = _i2.GetItHelper(
    getIt,
    environment,
    environmentFilter,
  );
  final registerModule = _$RegisterModule();
  await gh.lazySingletonAsync<_i3.SharedPreferences>(
    () => registerModule.prefs,
    preResolve: true,
  );
  gh.lazySingleton<_i4.FlutterSecureStorage>(
      () => registerModule.secureStorage);
  gh.lazySingleton<_i5.PrefsHelper>(
      () => _i5.PrefsHelper(gh<_i3.SharedPreferences>()));
  gh.factory<_i6.OfflineVideosBloc>(
      () => _i6.OfflineVideosBloc(gh<_i5.PrefsHelper>()));
  gh.lazySingleton<_i7.Dio>(
      () => registerModule.dio(gh<_i3.SharedPreferences>()));
  return getIt;
}

class _$RegisterModule extends _i8.RegisterModule {}
