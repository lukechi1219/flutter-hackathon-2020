import 'package:dartz/dartz.dart';
import 'package:flutterhood/core/error/failures.dart';
import 'package:flutterhood/data/entities/post_itrm.dart';
import 'package:meta/meta.dart';

abstract class PostItemRepository {
  //
  Future<Either<Failure, List<PostItem>>> getNearByPostItems();

  Future<Either<Failure, bool>> addPostItem({@required PostItem item});

//  Future<Either<Failure, List<PostItem>>> updatePostItem();
}
