import 'package:get_it/get_it.dart';
import 'package:simakan/core/repository/auth_repository.dart';
import 'package:simakan/core/viewmodel/auth_viewmodel.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => AuthRepository());

  locator.registerFactory(() => AuthViewModel());
}