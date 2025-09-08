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
import 'package:nawy_app/app/core/utils/dio_client.dart' as _i997;
import 'package:nawy_app/app/core/utils/obx_service.dart' as _i664;
import 'package:nawy_app/app/features/search/data/sources/remote/property_remote_source.dart'
    as _i32;
import 'package:nawy_app/app/features/search/domain/property_repository.dart'
    as _i938;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final injectionModule = _$InjectionModule();
    gh.singleton<_i997.DioClient>(() => _i997.DioClient.new());
    await gh.singletonAsync<_i664.ObxService>(
      () => injectionModule.obxService,
      preResolve: true,
    );
    gh.singleton<_i32.PropertyRemoteSource>(
      () => _i32.PropertyRemoteSource(gh<_i997.DioClient>()),
    );
    gh.singleton<_i938.PropertyRepository>(
      () => _i938.PropertyRepository(gh<_i32.PropertyRemoteSource>()),
    );
    return this;
  }
}

class _$InjectionModule extends _i601.InjectionModule {}
