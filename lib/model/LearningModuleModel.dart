import 'dart:convert';

import 'package:flutter/cupertino.dart';

LearningModuleModel LearningModuleModelFromJson(String str) => LearningModuleModel.fromJson(json.decode(str));

String LearningModuleModelToJson(LearningModuleModel data) => json.encode(data.toJson());

class LearningModuleModel {
  LearningModuleModel({
    required this.message,
    required this.success,
    required this.code,
    required this.data
  });

  String message;
  bool success;
  int code;
  List<LearningModuleItem> data;

  factory LearningModuleModel.fromJson(Map<String, dynamic> json) => LearningModuleModel(message: json["message"], success: json["success"], code: json["code"], data: List<LearningModuleItem>.from(json["data"].map((x) => LearningModuleItem.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
      "message": message,
      "success":success,
      "code": code,
      "data" : List<dynamic>.from(data.map((x) => x.toJson())),
  };
}


class LearningModuleItem{
  LearningModuleItem({
    required this.id,
    required this.teacherId,
    required this.name,
    required this.createdAt,
    required this.updatedAt,
    required this.categoryId,
    required this.teacher,
    required this.myQuizResult
  });

  int id;
  int teacherId;
  String name;
  String createdAt;
  String updatedAt;
  int categoryId;
  Teacher teacher;
  String myQuizResult;

  factory LearningModuleItem.fromJson(Map<String, dynamic> json) => LearningModuleItem(id: json["id"], teacherId:json["teacher_id"], name: json["name"], createdAt: json["created_at"], updatedAt: json["updated_at"], categoryId: json["category_id"], teacher: Teacher.fromJson(json["teacher"]), myQuizResult: json["my_quiz_result"]);

  Map<String, dynamic> toJson() =>{
    "id": id,
    "teacher_id" : teacherId,
    "name": name,
    "created_at": createdAt,
    "updated_at": updatedAt,
    "category_id" : categoryId,
    "teacher": teacher,
    "my_quiz_result": myQuizResult
  };
}

class Teacher{
  Teacher({
    required this.id,
    required this.name,
    required this.profilePhotoUrl
  });

  factory Teacher.fromJson(Map<String, dynamic> json) => Teacher(id: json["id"], name: json["name"], profilePhotoUrl: json["profile_photo_url"]);

  Map<String, dynamic> toJson() =>{
    "id":id,
    "name":name,
    "profile_photo_url":profilePhotoUrl
  };

  int id;
  String name;
  String profilePhotoUrl;
}