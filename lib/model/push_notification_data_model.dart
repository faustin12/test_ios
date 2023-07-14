import 'package:dikouba/model/firebasedate_model.dart';

class PushNotificationDataModel {
  String type;
  String page;
  String exist;

  PushNotificationDataModel(
      {required this.type,
        required this.page,
      required this.exist});

  factory PushNotificationDataModel.fromJson(Map<String, dynamic> json) {
    return PushNotificationDataModel(
        type: json["type"].toString(),
      page: json["page"].toString(),
      exist: json["exist"].toString(),
    );
  }

  factory PushNotificationDataModel.fromJsonDb(Map<String, dynamic> json) {
    return PushNotificationDataModel(
      type: json["type"].toString(),
      page: json["page"].toString(),
      exist: json["exist"].toString(),
    );
  }
}