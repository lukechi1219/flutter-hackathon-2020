import 'package:flutterhood/core/error/exceptions.dart';

import '../entities/post_itrm.dart';

abstract class PostItemLocalDataSource {
  /// Gets the cached [] which was gotten the last time
  /// the user had an internet connection.
  ///
  /// Throws [CacheException] if no cached data is present.
  Future<List<PostItem>> getLastItemList();

  Future<void> cachePostItemList(List<PostItem> postItems);
}

const CACHED_POST_ITEM_LIST = 'CACHED_POST_ITEM_LIST';

class PostItemLocalDataSourceImpl implements PostItemLocalDataSource {
//  final SharedPreferences sharedPreferences;
//
//  PostItemLocalDataSourceImpl({@required this.sharedPreferences});

  @override
  Future<List<PostItem>> getLastItemList() {
//    final jsonString = sharedPreferences.getString(CACHED_POST_ITEM_LIST);
//    if (jsonString != null) {
////      return Future.value([]);
////      return Future.value(PostItem.fromJson(json.decode(jsonString)));
//    }
    return Future.value([]);
//    throw CacheException();
  }

  @override
  Future<void> cachePostItemList(List<PostItem> postItems) {
    return Future.value(null);
//    return sharedPreferences.setString(
//      CACHED_POST_ITEM_LIST,
//      json.encode(postItems.),
//    );
  }
}
