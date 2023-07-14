import 'package:dikouba/model/annoncer_model.dart';
import 'package:dikouba/model/evenement_model.dart';
import 'package:dikouba/model/firebasedate_model.dart';
import 'package:dikouba/model/sondagereponse_model.dart';

class PostModel {
  String id_evenements;
  String nbre_likes;
  FirebaseDateModel? created_at;
  FirebaseDateModel? updated_at;
  String id_annoncers;
  String media;
  String id_posts;
  String type;
  String nbre_comments;
  EvenementModel? evenements;
  AnnoncerModel? annoncers;
  String description;

  PostModel(
      {this.created_at,
      this.updated_at,
      required this.nbre_likes,
      required this.id_annoncers,
      this.evenements,
      this.annoncers,
      required this.media,
      required this.description,
      required this.id_posts,
      required this.type,
      required this.id_evenements,
      required this.nbre_comments});

  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
      created_at: (json["created_at"] == null || json["created_at"] == '')
          ? new FirebaseDateModel('', '')
          : FirebaseDateModel.fromJson(json["created_at"]),
      updated_at: (json["updated_at"] == null || json["updated_at"] == '')
          ? new FirebaseDateModel('', '')
          : FirebaseDateModel.fromJson(json["updated_at"]),
      evenements: (json["evenements"] == null || json["evenements"] == '')
          ? null
          : EvenementModel.fromJson(json["evenements"]),
      annoncers: (json["annoncers"] == null || json["annoncers"] == '')
          ? null
          : AnnoncerModel.fromJson(json["annoncers"]),
      description: json["description"].toString(),
      id_annoncers: json["id_annoncers"].toString(),
      nbre_comments: json["nbre_comments"].toString(),
      nbre_likes: json["nbre_likes"].toString(),
      media: (json["media"] == null) ? '' : json["media"].toString(),
      id_evenements: json["id_evenements"].toString(),
      type: json["type"].toString(),
      id_posts: json["id_posts"].toString(),
    );
  }
  String toRYString() =>
      '{"media": "${this.media}","description": "${this.description}","evenements": ${this.evenements?.toRYString()},"nbre_comments": ${this.nbre_comments},"nbre_likes": ${this.nbre_likes},"type": ${this.type},"created_at": ${this.created_at?.toRYString()},"updated_at": ${this.updated_at?.toRYString()}}';
}
