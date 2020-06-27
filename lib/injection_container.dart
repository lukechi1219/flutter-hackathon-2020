import 'package:data_connection_checker/data_connection_checker.dart';
import 'data/datasources/post_item_remote_data_source.dart';
import 'data/repositories/post_item_repository_impl.dart';
import 'domain/repositories/post_item_repository.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

import 'core/network/network_info.dart';
import 'domain/usecases/add_post_item.dart';
import 'domain/usecases/get_near_by_post_items.dart';

final getIt = GetIt.instance;

Future<void> init() async {
  //! Features - Number Trivia
  // Bloc ?

  // Use cases
  getIt.registerLazySingleton(() => GetNearByPostItems(getIt()));
  getIt.registerLazySingleton(() => AddPostItem(getIt()));
//  sl.registerLazySingleton(() => UpdatePostItem(sl()));

  // Repository
  getIt.registerLazySingleton<PostItemRepository>(() => PostItemRepositoryImpl(
        networkInfo: getIt(),
        remoteDataSource: getIt(),
//        localDataSource: sl(),
      ));

  // Data sources
  getIt.registerLazySingleton<PostItemRemoteDataSource>(
    () => PostItemRemoteDataSourceImpl(client: getIt()),
  );

//  sl.registerLazySingleton<PostItemLocalDataSource>(
//    () => PostItemLocalDataSourceImpl(sharedPreferences: sl()),
//  );

  //! Core
  getIt.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(getIt()));

  //! External
//  final sharedPreferences = await SharedPreferences.getInstance();
//  sl.registerLazySingleton(() => sharedPreferences);
  getIt.registerLazySingleton(() => http.Client());
  getIt.registerLazySingleton(() => DataConnectionChecker());
}
