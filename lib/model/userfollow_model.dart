import 'package:dikouba/model/firebasedate_model.dart';
import 'package:dikouba/model/firebaselocation_model.dart';
import 'package:dikouba/model/user_model.dart';

class UserFollowModel {
  String? id_users_from;
  String? id_users_to;
  FirebaseDateModel? created_at;
  FirebaseDateModel? updated_at;

  UserFollowModel({this.id_users_from, this.id_users_to, this.created_at, this.updated_at});

  factory UserFollowModel.fromJson(Map<String, dynamic> json) {
    return UserFollowModel(
      id_users_from: json["id_users_from"].toString(),
      created_at: (json["created_at"] == null || json["created_at"] == '') ? new FirebaseDateModel('', '') : FirebaseDateModel.fromJson(json["created_at"]),
      updated_at: (json["updated_at"] == null || json["updated_at"] == '') ? new FirebaseDateModel('', '') : FirebaseDateModel.fromJson(json["updated_at"]),
      id_users_to: json["id_users_to"].toString(),
    );
  }

}
