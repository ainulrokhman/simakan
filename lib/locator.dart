import 'package:get_it/get_it.dart';
import 'package:simakan/core/repository/angket_repository.dart';
import 'package:simakan/core/repository/auth_repository.dart';
import 'package:simakan/core/repository/user_repository.dart';
import 'package:simakan/core/viewmodel/angket_viewmodel.dart';
import 'package:simakan/core/viewmodel/auth_viewmodel.dart';
import 'package:simakan/core/viewmodel/home_viewmodel.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => AuthRepository());
  locator.registerLazySingleton(() => UserRepository());
  locator.registerLazySingleton(() => AngketRepository());

  locator.registerFactory(() => AuthViewModel());
  locator.registerFactory(() => HomeViewModel());
  locator.registerFactory(() => AngketViewModel());
}