import 'package:dikouba/model/firebasedate_model.dart';
import 'package:dikouba/model/firebaselocation_model.dart';

class PackageModel {
  String id_packages;
  String id_evenements;
  String name;
  String max_ticket_count;
  FirebaseDateModel? created_at;
  FirebaseDateModel? updated_at;
  String price;

  PackageModel(
      {required this.id_packages,
      required this.id_evenements,
      required this.name,
      this.created_at,
      this.updated_at,
      required this.max_ticket_count,
      required this.price});

  factory PackageModel.fromJson(Map<String, dynamic> json) {
    return PackageModel(
      id_packages: json["id_packages"].toString(),
      created_at: (json["created_at"] == null || json["created_at"] == '')
          ? new FirebaseDateModel('', '')
          : FirebaseDateModel.fromJson(json["created_at"]),
      updated_at: (json["updated_at"] == null || json["updated_at"] == '')
          ? new FirebaseDateModel('', '')
          : FirebaseDateModel.fromJson(json["updated_at"]),
      id_evenements: json["id_evenements"].toString(),
      name: json["name"].toString(),
      price: json["price"].toString(),
      max_ticket_count: json["max_ticket_count"].toString(),
    );
  }
  String toRYString() =>
      '{"id_packages": "${this.id_packages}","id_evenements": "${this.id_evenements}","max_ticket_count": "${this.max_ticket_count}","name": "${this.name}","price": "${this.price}"}';
}
