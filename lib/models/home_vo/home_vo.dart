import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'home_vo.g.dart';

@JsonSerializable()
class HomeVo  with ChangeNotifier {
  final bool? logined;

  HomeVo({this.logined});

  @override
  String toString() => 'HomeVo(logined: $logined)';

  factory HomeVo.fromJson(Map<String, dynamic> json) {
    return _$HomeVoFromJson(json);
  }

  Map<String, dynamic> toJson() => _$HomeVoToJson(this);

  HomeVo copyWith({
    bool? logined,
  }) {
    return HomeVo(
      logined: logined ?? this.logined,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! HomeVo) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toJson(), toJson());
  }

  @override
  int get hashCode => logined.hashCode;
}
