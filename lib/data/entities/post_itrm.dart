import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:meta/meta.dart';

class PostItem extends Equatable {
  final String text;
  final LatLng location;
  final String creator;
  final DateTime createTime;

  // 截止時間
  final DateTime postEndTime;

  PostItem({
    @required this.text,
    @required this.location,
    @required this.creator,
    @required this.createTime,
    // 如果是接單 才有 截止時間. 純發佈消息不一定要有截止時間
    this.postEndTime,
  });

  @override
  List<Object> get props => [
        text,
        location.toString(),
        creator,
        createTime.millisecond,
        (postEndTime == null) ? '' : postEndTime.millisecond,
      ];

  Map<String, dynamic> toFirestoreDoc() {
    return {
      'createTime': this.createTime,
      'creator': this.creator,
      'latitude': this.location.latitude,
      'longitude': this.location.longitude,
      'postEndTime': this.postEndTime,
      'text': this.text,
    };
  }
}
