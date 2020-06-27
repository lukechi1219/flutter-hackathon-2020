import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutterhood/core/error/failures.dart';
import 'package:flutterhood/core/usecases/usecase.dart';
import 'package:flutterhood/data/entities/post_itrm.dart';
import 'package:flutterhood/domain/repositories/post_item_repository.dart';
import 'package:meta/meta.dart';

class AddPostItem implements UseCase<bool, Params> {
  final PostItemRepository repository;

  AddPostItem(this.repository);

  @override
  Future<Either<Failure, bool>> call(Params params) async {
    return await repository.addPostItem(item: params.item);
  }
}

class Params extends Equatable {
  final PostItem item;

  Params({@required this.item});

  @override
  List<Object> get props => [item];
}
