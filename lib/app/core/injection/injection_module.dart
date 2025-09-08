import 'package:injectable/injectable.dart';
import 'package:nawy_app/app/core/utils/isar_service.dart';

@module
abstract class InjectionModule {
  @preResolve
  @singleton
  Future<IsarService> get isarService async {
    final service = IsarService();
    await service.initialize();
    return service;
  }
}
