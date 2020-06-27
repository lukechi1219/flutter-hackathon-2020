import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutterhood/core/error/failures.dart';
import 'package:flutterhood/data/datasources/post_item_remote_data_source.dart';
import 'package:flutterhood/data/entities/post_itrm.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:meta/meta.dart';
import 'package:flutterhood/core/network/network_info.dart';
import 'package:flutterhood/domain/repositories/post_item_repository.dart';

class PostItemRepositoryImpl implements PostItemRepository {
  final NetworkInfo networkInfo;
  final PostItemRemoteDataSource remoteDataSource;

//  final PostItemLocalDataSource localDataSource;

  PostItemRepositoryImpl({
    @required this.remoteDataSource,
//    @required this.localDataSource,
    @required this.networkInfo,
  });

  /*
   * 取回附近的求助單
   */
  @override
  Future<Either<Failure, List<PostItem>>> getNearByPostItems() async {
    //
    if (await networkInfo.isConnected) {
      // 跟 firebase 要資料
      return Right(await remoteDataSource.getNearByPostItems());
    }
    // 假資料
    var list = <PostItem>[];
    //
    list.add(PostItem(
      text: 'Help!',
      location: LatLng(25.0326811, 121.5646961),
      creator: 'Luke',
      createTime: DateTime.now(),
    ));
    //
    return Right(list);
  }

  @override
  Future<Either<Failure, bool>> addPostItem({@required PostItem item}) async {
    //
    if (await networkInfo.isConnected) {
      return Right(await remoteDataSource.addPostItem(item));
    }
    return Right(true);
  }
}
