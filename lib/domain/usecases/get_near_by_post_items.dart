import 'package:dartz/dartz.dart';
import 'package:flutterhood/core/error/failures.dart';
import 'package:flutterhood/core/usecases/usecase.dart';
import 'package:flutterhood/data/entities/post_itrm.dart';
import 'package:flutterhood/domain/repositories/post_item_repository.dart';

class GetNearByPostItems implements UseCase<List<PostItem>, NoParams> {
  final PostItemRepository repository;

  GetNearByPostItems(this.repository);

  @override
  Future<Either<Failure, List<PostItem>>> call(NoParams params) async {
    return await repository.getNearByPostItems();
  }
}
