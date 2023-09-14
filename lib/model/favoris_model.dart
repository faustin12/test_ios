import 'package:dikouba/model/evenement_model.dart';
import 'package:dikouba/model/firebasedate_model.dart';
import 'package:dikouba/model/firebaselocation_model.dart';
import 'package:dikouba/model/transaction_model.dart';

class FavorisModel {
  String? id_users; //
  String? id_evenements; //
  EvenementModel? evenements;
  FirebaseDateModel? created_at;
  FirebaseDateModel? updated_at;

  FavorisModel(
      {
      this.id_users,
      this.id_evenements,
      this.created_at,
      this.updated_at,
      this.evenements});

  factory FavorisModel.fromJson(Map<String, dynamic> json) {
    return FavorisModel(
      id_users: json["id_users"].toString(),
      id_evenements: json["id_evenements"].toString(),
      evenements: (json["evenements"] == null || json["evenements"] == '')
          ? null
          : EvenementModel.fromJson(json["evenements"]),
      created_at: (json["created_at"] == null || json["created_at"] == '')
          ? new FirebaseDateModel('', '')
          : FirebaseDateModel.fromJson(json["created_at"]),
      updated_at: (json["updated_at"] == null || json["updated_at"] == '')
          ? new FirebaseDateModel('', '')
          : FirebaseDateModel.fromJson(json["updated_at"]),
    );
  }
  String toDKBString() =>
      '{"id_evenements": "${this.id_evenements}","id_users": "${this.id_users}","created_at": ${this.created_at?.toDKBString()},"updated_at": ${this.updated_at?.toDKBString()}}';
}
