// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:nawy_app/app/core/injection/injection_module.dart' as _i601;
import 'package:nawy_app/app/core/utils/app_logger.dart' as _i921;
import 'package:nawy_app/app/core/utils/dio_client.dart' as _i997;
import 'package:nawy_app/app/core/utils/hive_service.dart' as _i789;
import 'package:nawy_app/app/features/ai_assistant/domain/ai_service.dart'
    as _i361;
import 'package:nawy_app/app/features/favorites/data/favorites_repository.dart'
    as _i823;
import 'package:nawy_app/app/features/favorites/data/sources/local/favorites_local_source.dart'
    as _i134;
import 'package:nawy_app/app/features/favorites/presentation/bloc/favorites_bloc.dart'
    as _i565;
import 'package:nawy_app/app/features/property_search/data/sources/remote/property_search_remote_source.dart'
    as _i509;
import 'package:nawy_app/app/features/property_search/domain/property_search_repository.dart'
    as _i942;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final injectionModule = _$InjectionModule();
    await gh.singletonAsync<_i789.HiveService>(
      () => injectionModule.hiveService,
      preResolve: true,
    );
    await gh.singletonAsync<_i921.AppLogger>(
      () => injectionModule.appLogger,
      preResolve: true,
    );
    gh.factory<_i134.FavoritesLocalSource>(
      () => _i134.FavoritesLocalSource(gh<_i789.HiveService>()),
    );
    gh.singleton<_i997.DioClient>(() => _i997.DioClient(gh<_i921.AppLogger>()));
    gh.singleton<_i509.PropertySearchRemoteSource>(
      () => _i509.PropertySearchRemoteSource(gh<_i997.DioClient>()),
    );
    gh.singleton<_i823.FavoritesRepository>(
      () => _i823.FavoritesRepository(gh<_i134.FavoritesLocalSource>()),
    );
    gh.singleton<_i942.PropertySearchRepository>(
      () => _i942.PropertySearchRepository(
        gh<_i509.PropertySearchRemoteSource>(),
      ),
    );
    gh.singleton<_i361.AiService>(
      () => _i361.AiService(gh<_i942.PropertySearchRepository>()),
    );
    gh.factory<_i565.FavoritesBloc>(
      () => _i565.FavoritesBloc(
        gh<_i823.FavoritesRepository>(),
        gh<_i921.AppLogger>(),
      ),
    );
    return this;
  }
}

class _$InjectionModule extends _i601.InjectionModule {}
