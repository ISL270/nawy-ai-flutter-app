import 'package:injectable/injectable.dart';
import 'package:nawy_app/app/core/utils/obx_service.dart';

@module
abstract class InjectionModule {
  @preResolve
  @singleton
  Future<ObxService> get obxService async {
    final service = ObxService();
    await service.initialize();
    return service;
  }
}
