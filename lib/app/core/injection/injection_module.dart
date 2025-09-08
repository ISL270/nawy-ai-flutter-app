import 'package:injectable/injectable.dart';
import 'package:nawy_app/app/core/utils/obx_service.dart';
import 'package:nawy_app/app/core/utils/app_logger.dart';

@module
abstract class InjectionModule {
  @preResolve
  @singleton
  Future<ObxService> get obxService async {
    final service = ObxService();
    await service.initialize();
    return service;
  }

  @preResolve
  @singleton
  Future<AppLogger> get appLogger async {
    final logger = AppLogger();
    logger.initialize();
    return logger;
  }
}
