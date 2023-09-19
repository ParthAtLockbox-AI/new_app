// To parse this JSON data, do
//
//     final createTalkResponseModel = createTalkResponseModelFromJson(jsonString);

import 'dart:convert';

CreateTalkResponseModel createTalkResponseModelFromJson(String str) =>
    CreateTalkResponseModel.fromJson(json.decode(str));

String createTalkResponseModelToJson(CreateTalkResponseModel data) =>
    json.encode(data.toJson());

class CreateTalkResponseModel {
  String? id;
  DateTime? createdAt;
  String? createdBy;
  String? status;
  String? object;

  CreateTalkResponseModel({
    this.id,
    this.createdAt,
    this.createdBy,
    this.status,
    this.object,
  });

  factory CreateTalkResponseModel.fromJson(Map<String, dynamic> json) =>
      CreateTalkResponseModel(
        id: json["id"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        createdBy: json["created_by"],
        status: json["status"],
        object: json["object"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "created_at": createdAt?.toIso8601String(),
        "created_by": createdBy,
        "status": status,
        "object": object,
      };
}
