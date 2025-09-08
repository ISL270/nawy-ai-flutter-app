// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:nawy_app/app/core/injection/injection_module.dart' as _i7;
import 'package:nawy_app/app/core/utils/dio_client.dart' as _i3;
import 'package:nawy_app/app/core/utils/isar_service.dart' as _i4;
import 'package:nawy_app/app/features/search/data/sources/remote/property_remote_source.dart'
    as _i5;
import 'package:nawy_app/app/features/search/domain/property_repository.dart'
    as _i6;

extension GetItInjectableX on _i1.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  Future<_i1.GetIt> init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final injectionModule = _$InjectionModule();
    gh.singleton<_i3.DioClient>(() => _i3.DioClient());
    await gh.singletonAsync<_i4.IsarService>(
      () => injectionModule.isarService,
      preResolve: true,
    );
    gh.singleton<_i5.PropertyRemoteSource>(
        () => _i5.PropertyRemoteSource(gh<_i3.DioClient>()));
    gh.singleton<_i6.PropertyRepository>(
        () => _i6.PropertyRepository(gh<_i5.PropertyRemoteSource>()));
    return this;
  }
}

class _$InjectionModule extends _i7.InjectionModule {}
