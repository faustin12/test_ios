import 'package:dikouba/model/annoncer_model.dart';
import 'package:dikouba/model/category_model.dart';
import 'package:dikouba/model/evenement_model.dart';
import 'package:dikouba/model/firebasedate_model.dart';
import 'package:dikouba/model/firebaselocation_model.dart';
import 'package:dikouba/model/sondagereponse_model.dart';

class SondageModel {
  String title;
  FirebaseDateModel created_at;
  FirebaseDateModel updated_at;
  FirebaseDateModel start_date;
  FirebaseDateModel end_date;
  EvenementModel? evenements;
  AnnoncerModel? annoncers;
  String? start_date_tmp;
  String? end_date_tmp;
  String id_sondages;
  String description;
  String nombre_vote;
  String id_annoncers;
  String id_evenements;
  String banner_path;
  List<SondageReponseModel?>? reponses;
  List<SondageReponseModel?>? reponsesusers;

  SondageModel({
      required this.title,
      required this.created_at,
      required this.updated_at,
      required this.start_date,
      required this.end_date,
      this.evenements,
    this.annoncers,
      required this.id_sondages,
      required this.description,
      required this.nombre_vote,
      required this.id_annoncers,
      required this.id_evenements,
      required this.banner_path,
      this.reponses,
  this.reponsesusers});

  factory SondageModel.fromJson(Map<String, dynamic> json) {
    return SondageModel(
      title: json["title"].toString(),
      created_at: (json["created_at"] == null || json["created_at"] == '') ? new FirebaseDateModel('', '') : FirebaseDateModel.fromJson(json["created_at"]),
      updated_at: (json["updated_at"] == null || json["updated_at"] == '') ? new FirebaseDateModel('', '') : FirebaseDateModel.fromJson(json["updated_at"]),
      start_date: (json["start_date"] == null || json["start_date"] == '') ? new FirebaseDateModel('', '') : FirebaseDateModel.fromJson(json["start_date"]),
      end_date: (json["end_date"] == null || json["end_date"] == '') ? new FirebaseDateModel('', '') : FirebaseDateModel.fromJson(json["end_date"]),
      evenements: (json["evenements"] == null || json["evenements"] == '') ? null : EvenementModel.fromJson(json["evenements"]),
      annoncers: (json["annoncers"] == null || json["annoncers"] == '') ? null : AnnoncerModel.fromJson(json["annoncers"]),
      description: json["description"].toString(),
      id_annoncers: json["id_annoncers"].toString(),
      id_sondages: json["id_sondages"].toString(),
      banner_path: (json["banner_path"] == null) ? '' : json["banner_path"].toString(),
      id_evenements: json["id_evenements"].toString(),
      nombre_vote: json["nombre_vote"].toString(),
      reponses: (json['reponses'] as List)
          .map((e) => e == null ? null : SondageReponseModel.fromJson(e))
          ?.toList(),
      reponsesusers: (json['reponsesusers'] as List)
          .map((e) => e == null ? null : SondageReponseModel.fromJson(e))
          ?.toList(),
    );
  }

  String toRYString() => '{"description": "${this.description}","end_date": ${this.end_date.toRYString()},"start_date": ${this.start_date.toRYString()},"created_at": ${this.created_at.toRYString()},"updated_at": ${this.updated_at.toRYString()}}';
}