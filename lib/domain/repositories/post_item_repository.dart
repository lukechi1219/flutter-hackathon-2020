import 'package:dartz/dartz.dart';
import 'package:flutterhood/core/error/failures.dart';
import 'package:flutterhood/data/entities/post_itrm.dart';

abstract class PostItemRepository {
  Future<Either<Failure, List<PostItem>>> getNearByPostItems();
//  Future<Either<Failure, List<PostItem>>> addPostItem();
//  Future<Either<Failure, List<PostItem>>> updatePostItem();
}
