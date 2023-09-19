// To parse this JSON data, do
//
//     final getTalkResponseModel = getTalkResponseModelFromJson(jsonString);

import 'dart:convert';

GetTalkResponseModel getTalkResponseModelFromJson(String str) =>
    GetTalkResponseModel.fromJson(json.decode(str));

String getTalkResponseModelToJson(GetTalkResponseModel data) =>
    json.encode(data.toJson());

class GetTalkResponseModel {
  User? user;
  Script? script;
  Metadata? metadata;
  String? audioUrl;
  DateTime? createdAt;
  Face? face;
  Config? config;
  String? sourceUrl;
  String? createdBy;
  String? status;
  String? driverUrl;
  DateTime? modifiedAt;
  String? userId;
  bool? subtitles;
  String? id;
  double? duration;
  DateTime? startedAt;
  String? resultUrl;

  GetTalkResponseModel({
    this.user,
    this.script,
    this.metadata,
    this.audioUrl,
    this.createdAt,
    this.face,
    this.config,
    this.sourceUrl,
    this.createdBy,
    this.status,
    this.driverUrl,
    this.modifiedAt,
    this.userId,
    this.subtitles,
    this.id,
    this.duration,
    this.startedAt,
    this.resultUrl,
  });

  factory GetTalkResponseModel.fromJson(Map<String, dynamic> json) =>
      GetTalkResponseModel(
        user: json["user"] == null ? null : User.fromJson(json["user"]),
        script: json["script"] == null ? null : Script.fromJson(json["script"]),
        metadata: json["metadata"] == null
            ? null
            : Metadata.fromJson(json["metadata"]),
        audioUrl: json["audio_url"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        face: json["face"] == null ? null : Face.fromJson(json["face"]),
        config: json["config"] == null ? null : Config.fromJson(json["config"]),
        sourceUrl: json["source_url"],
        createdBy: json["created_by"],
        status: json["status"],
        driverUrl: json["driver_url"],
        modifiedAt: json["modified_at"] == null
            ? null
            : DateTime.parse(json["modified_at"]),
        userId: json["user_id"],
        subtitles: json["subtitles"],
        id: json["id"],
        duration: json["duration"]?.toDouble(),
        startedAt: json["started_at"] == null
            ? null
            : DateTime.parse(json["started_at"]),
        resultUrl: json["result_url"],
      );

  Map<String, dynamic> toJson() => {
        "user": user?.toJson(),
        "script": script?.toJson(),
        "metadata": metadata?.toJson(),
        "audio_url": audioUrl,
        "created_at": createdAt?.toIso8601String(),
        "face": face?.toJson(),
        "config": config?.toJson(),
        "source_url": sourceUrl,
        "created_by": createdBy,
        "status": status,
        "driver_url": driverUrl,
        "modified_at": modifiedAt?.toIso8601String(),
        "user_id": userId,
        "subtitles": subtitles,
        "id": id,
        "duration": duration,
        "started_at": startedAt?.toIso8601String(),
        "result_url": resultUrl,
      };
}

class Config {
  bool? stitch;
  int? padAudio;
  bool? alignDriver;
  bool? sharpen;
  bool? reduceNoise;
  bool? autoMatch;
  int? normalizationFactor;
  Logo? logo;
  int? motionFactor;
  String? resultFormat;
  bool? fluent;
  double? alignExpandFactor;

  Config({
    this.stitch,
    this.padAudio,
    this.alignDriver,
    this.sharpen,
    this.reduceNoise,
    this.autoMatch,
    this.normalizationFactor,
    this.logo,
    this.motionFactor,
    this.resultFormat,
    this.fluent,
    this.alignExpandFactor,
  });

  factory Config.fromJson(Map<String, dynamic> json) => Config(
        stitch: json["stitch"],
        padAudio: json["pad_audio"],
        alignDriver: json["align_driver"],
        sharpen: json["sharpen"],
        reduceNoise: json["reduce_noise"],
        autoMatch: json["auto_match"],
        normalizationFactor: json["normalization_factor"],
        logo: json["logo"] == null ? null : Logo.fromJson(json["logo"]),
        motionFactor: json["motion_factor"],
        resultFormat: json["result_format"],
        fluent: json["fluent"],
        alignExpandFactor: json["align_expand_factor"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "stitch": stitch,
        "pad_audio": padAudio,
        "align_driver": alignDriver,
        "sharpen": sharpen,
        "reduce_noise": reduceNoise,
        "auto_match": autoMatch,
        "normalization_factor": normalizationFactor,
        "logo": logo?.toJson(),
        "motion_factor": motionFactor,
        "result_format": resultFormat,
        "fluent": fluent,
        "align_expand_factor": alignExpandFactor,
      };
}

class Logo {
  String? url;
  List<int>? position;

  Logo({
    this.url,
    this.position,
  });

  factory Logo.fromJson(Map<String, dynamic> json) => Logo(
        url: json["url"],
        position: json["position"] == null
            ? []
            : List<int>.from(json["position"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "url": url,
        "position":
            position == null ? [] : List<dynamic>.from(position!.map((x) => x)),
      };
}

class Face {
  int? maskConfidence;
  List<int>? detection;
  String? overlap;
  int? size;
  List<int>? topLeft;
  int? faceId;
  double? detectConfidence;

  Face({
    this.maskConfidence,
    this.detection,
    this.overlap,
    this.size,
    this.topLeft,
    this.faceId,
    this.detectConfidence,
  });

  factory Face.fromJson(Map<String, dynamic> json) => Face(
        maskConfidence: json["mask_confidence"],
        detection: json["detection"] == null
            ? []
            : List<int>.from(json["detection"]!.map((x) => x)),
        overlap: json["overlap"],
        size: json["size"],
        topLeft: json["top_left"] == null
            ? []
            : List<int>.from(json["top_left"]!.map((x) => x)),
        faceId: json["face_id"],
        detectConfidence: json["detect_confidence"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "mask_confidence": maskConfidence,
        "detection": detection == null
            ? []
            : List<dynamic>.from(detection!.map((x) => x)),
        "overlap": overlap,
        "size": size,
        "top_left":
            topLeft == null ? [] : List<dynamic>.from(topLeft!.map((x) => x)),
        "face_id": faceId,
        "detect_confidence": detectConfidence,
      };
}

class Metadata {
  String? driverUrl;
  bool? mouthOpen;
  int? numFaces;
  int? numFrames;
  double? processingFps;
  List<int>? resolution;
  double? sizeKib;

  Metadata({
    this.driverUrl,
    this.mouthOpen,
    this.numFaces,
    this.numFrames,
    this.processingFps,
    this.resolution,
    this.sizeKib,
  });

  factory Metadata.fromJson(Map<String, dynamic> json) => Metadata(
        driverUrl: json["driver_url"],
        mouthOpen: json["mouth_open"],
        numFaces: json["num_faces"],
        numFrames: json["num_frames"],
        processingFps: json["processing_fps"]?.toDouble(),
        resolution: json["resolution"] == null
            ? []
            : List<int>.from(json["resolution"]!.map((x) => x)),
        sizeKib: json["size_kib"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "driver_url": driverUrl,
        "mouth_open": mouthOpen,
        "num_faces": numFaces,
        "num_frames": numFrames,
        "processing_fps": processingFps,
        "resolution": resolution == null
            ? []
            : List<dynamic>.from(resolution!.map((x) => x)),
        "size_kib": sizeKib,
      };
}

class Script {
  int? length;
  bool? ssml;
  bool? subtitles;
  String? type;

  Script({
    this.length,
    this.ssml,
    this.subtitles,
    this.type,
  });

  factory Script.fromJson(Map<String, dynamic> json) => Script(
        length: json["length"],
        ssml: json["ssml"],
        subtitles: json["subtitles"],
        type: json["type"],
      );

  Map<String, dynamic> toJson() => {
        "length": length,
        "ssml": ssml,
        "subtitles": subtitles,
        "type": type,
      };
}

class User {
  List<String?>? features;
  String? stripePlanGroup;
  String? authorizer;
  String? ownerId;
  String? id;
  String? plan;
  String? email;

  User({
    this.features,
    this.stripePlanGroup,
    this.authorizer,
    this.ownerId,
    this.id,
    this.plan,
    this.email,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        features: json["features"] == null
            ? []
            : List<String?>.from(json["features"]!.map((x) => x)),
        stripePlanGroup: json["stripe_plan_group"],
        authorizer: json["authorizer"],
        ownerId: json["owner_id"],
        id: json["id"],
        plan: json["plan"],
        email: json["email"],
      );

  Map<String, dynamic> toJson() => {
        "features":
            features == null ? [] : List<dynamic>.from(features!.map((x) => x)),
        "stripe_plan_group": stripePlanGroup,
        "authorizer": authorizer,
        "owner_id": ownerId,
        "id": id,
        "plan": plan,
        "email": email,
      };
}
