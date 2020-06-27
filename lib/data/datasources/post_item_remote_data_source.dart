import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;

import '../entities/post_itrm.dart';

abstract class PostItemRemoteDataSource {
  /// Calls the http://numbersapi.com/{number} endpoint.
  ///
  /// Throws a [ServerException] for all error codes.
  Future<List<PostItem>> getNearByPostItems();
}

class PostItemRemoteDataSourceImpl implements PostItemRemoteDataSource {
  final http.Client client;

  PostItemRemoteDataSourceImpl({@required this.client});

  @override
  Future<List<PostItem>> getNearByPostItems() {
    return Future.value([]);
  }
}
