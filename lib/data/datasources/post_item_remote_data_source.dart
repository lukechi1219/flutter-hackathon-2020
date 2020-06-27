import 'package:cloud_firestore/cloud_firestore.dart';
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
  Future<List<PostItem>> getNearByPostItems() async {
    QuerySnapshot snapshot =
        await Firestore.instance.collection('fh_posts').snapshots().first;

    print(snapshot.runtimeType);

    if (snapshot.documents.isEmpty) {
      return Future.value([]);
    }

    print('------');

    for (var data in snapshot.documents) {
      for (var entry in data.data.entries) {
        print('${entry.key}: ${entry.value}');
      }
    }
    print('------');

    return Future.value([]);
  }
}
