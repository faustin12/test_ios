import 'package:dikouba/model/evenement_model.dart';
import 'package:dikouba/model/firebasedate_model.dart';
import 'package:dikouba/model/firebaselocation_model.dart';
import 'package:dikouba/model/user_model.dart';

class EvenementLikeModel {
  String? id_evenements;
  String? id_users;
  String? note;
  String? is_suspended;
  FirebaseDateModel? created_at;
  FirebaseDateModel? updated_at;
  EvenementModel? evenements;

  EvenementLikeModel({this.id_evenements, this.note, this.is_suspended,
      this.id_users, this.created_at, this.updated_at, this.evenements});

  factory EvenementLikeModel.fromJson(Map<String, dynamic> json) {
    return EvenementLikeModel(
      created_at: (json["created_at"] == null || json["created_at"] == '') ? new FirebaseDateModel('', '') : FirebaseDateModel.fromJson(json["created_at"]),
      updated_at: (json["updated_at"] == null || json["updated_at"] == '') ? new FirebaseDateModel('', '') : FirebaseDateModel.fromJson(json["updated_at"]),
      id_evenements: json["id_evenements"].toString(),
      id_users: json["id_users"].toString(),
      note: json["note"].toString(),
      is_suspended: json["is_suspended"].toString(),
      evenements: (json["evenements"] == null || json["evenements"] == '') ? null : EvenementModel.fromJson(json["evenements"]),
    );
  }
}
