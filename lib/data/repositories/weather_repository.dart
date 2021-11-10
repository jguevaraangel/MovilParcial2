import 'package:loggy/loggy.dart';

class WeatherRepository {
  late WeatherRepositoryRemote remoteDataSource;
  late WeatherRepositoryLocal localDataSource;

  WeatherRepository() {
    logInfo("Starting UserRepository");
    remoteDataSource = WeatherRepositoryRemote();
    localDataSource = WeatherRepositoryLocal();
  }

  // Future<bool> getUser() async {
  //   UserModel user = await remoteDataSource.getUser();
  //   await localDataSource.addUser(user);
  //   return Future.value(true);
  // }

  // Future<List<UserModel>> getAllUsers() async =>
  //     await localDataSource.getAllUsers();

  // Future<void> deleteUser(id) async => await localDataSource.deleteUser(id);

  // Future<void> deleteAll() async => await localDataSource.deleteAll();

  // Future<void> updateUser(user) async => await localDataSource.updateUser(user);
}
