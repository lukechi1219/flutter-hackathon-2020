import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;

import '../entities/post_itrm.dart';

abstract class PostItemRemoteDataSource {
  /// Calls the http://numbersapi.com/{number} endpoint.
  ///
  /// Throws a [ServerException] for all error codes.
  Future<List<PostItem>> getNearByPostItems();

  Future<bool> addPostItem(PostItem item);
}

class PostItemRemoteDataSourceImpl implements PostItemRemoteDataSource {
  final http.Client client;

  PostItemRemoteDataSourceImpl({@required this.client});

  @override
  Future<List<PostItem>> getNearByPostItems() async {
    QuerySnapshot snapshot =
        await Firestore.instance.collection('fh_posts').getDocuments();

    print(snapshot.runtimeType);

    if (snapshot.documents.isEmpty) {
      return Future.value([]);
    }

    var list = <PostItem>[];

    print('------');

    for (var doc in snapshot.documents) {
      for (var entry in doc.data.entries) {
        print('${entry.key}: ${entry.value}');
      }
      var _postEndTime =
          (doc.data['postEndTime'] == null) ? null : doc.data['postEndTime'].toDate();

      var postItem = PostItem(
        text: doc.data['text'],
        location: LatLng(
          doc.data['latitude'],
          doc.data['longitude'],
        ),
        creator: doc.data['creator'],
        createTime: doc.data['createTime'].toDate(),
        postEndTime: _postEndTime,
      );
      list.add(postItem);
      print('------');
    }

    return Future.value(list);
  }

  @override
  Future<bool> addPostItem(PostItem item) async {
    //
    var map = item.toFirestoreDoc();
    //
    DocumentReference ref = await Firestore.instance.collection('fh_posts').add(map);

    print(ref.documentID);

    return Future.value(true);
  }
}
