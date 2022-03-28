// import 'dart:convert';
//
// UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));
//
// String userModelToJson(UserModel data) => json.encode(data.toJson());
//
// class UserModel{
//   UserModel({
//     required this.message,
//     required this.success,
//     required this.code,
//     required this.data
//   });
//
//   String message;
//   bool success;
//   int code;
//   User data;
//
//   factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(message: json["message"], success: json["success"], code: json["code"], data: User.fromJson(json["data"]));
//
//   Map<String, dynamic> toJson() => {
//     "message": message,
//     "success":success,
//     "code": code,
//     "data" :data
//   };
// }
//
// class User{
//   User({required this.userItem});
//
//   UserItem userItem;
//
//   factory User.fromJson(Map<String, dynamic> json) => User(userItem: UserItem.fromJson(json["user"]));
//
//   Map<String, dynamic> toJson() =>{
//     "user": userItem
//   };
// }
//
//
// class UserItem{
//   UserItem({
//     required this.id,
//     required this.name,
//     required this.email,
//     required this.emailVerifiedAt,
//     required this.currentTeamId,
//     required this.profilePhotoPath,
//     required this.createdAt,
//     required this.updatedAt,
//     required this.active,
//     required this.profilePhotoUrl,
//     required this.roles,
//     required this.student
//   });
//
//   int id;
//   String name;
//   String email;
//   String emailVerifiedAt;
//   int currentTeamId;
//   String profilePhotoPath;
//   String createdAt;
//   String updatedAt;
//   int active;
//   String profilePhotoUrl;
//   List<Roles> roles;
//   Student student;
//
//   factory UserItem.fromJson(Map<String, dynamic> json) => UserItem(id: json["id"], name: json["name"], email: json["email"], emailVerifiedAt: json["email_verified_at"], currentTeamId: json["current_team_id"], profilePhotoPath: json["profile_photo_path"], createdAt: json["created_at"], updatedAt: json["updated_at"], active: json["active"], profilePhotoUrl: json["profile_photo_url"], roles: List<Roles>.from(json["roles"].map((x) => User.fromJson(x))), student: Student.fromJson(json["student"]));
//
//   Map<String, dynamic> toJson() =>{
//     "id":id,
//     "name" : name,
//     "email": email,
//     "email_verified_at": emailVerifiedAt,
//     "current_team_id": currentTeamId,
//     "profile_photo_path": profilePhotoPath,
//     "created_at": createdAt,
//     "updated_at": updatedAt,
//     "active": active,
//     "profile_photo_url": profilePhotoUrl,
//     "roles": List<dynamic>.from(roles.map((x) => x.toJson())),
//     "student":student
//   };
// }
//
// class Roles{
//   Roles({
//     required this.id,
//     required this.name,
//     required this.guardName,
//     required this.createdAt,
//     required this.updatedAt,
//     required this.pivot
//   });
//
//   factory Roles.fromJson(Map<String, dynamic> json) => Roles(id: json["id"], name: json["name"], guardName: json["guard_name"], createdAt: json["created_at"], updatedAt: json["updated_at"], pivot: Pivot.fromJson(json["pivot"]));
//
//   Map<String, dynamic> toJson() =>{
//     "id": id,
//     "name": name,
//     "guard_name": guardName,
//     "created_at": createdAt,
//     "updated_at" : updatedAt,
//     "pivot": pivot
//   };
//
//   int id;
//   String name;
//   String guardName;
//   String createdAt;
//   String updatedAt;
//   Pivot pivot;
// }
//
// class Pivot{
//   Pivot({required this.modelId, required this.roleId, required this.modelType});
//
//   factory Pivot.fromJson(Map<String, dynamic> json) => Pivot(modelId: json["model_id"], roleId: json["role_id"], modelType: json["model_type"]);
//
//   Map<String, dynamic> toJson() =>{
//     "model_id": modelId,
//     "role_id": roleId,
//     "model_type": modelType
//   };
//
//   int modelId;
//   int roleId;
//   String modelType;
// }
//
// class Student{
//   Student({
//     required this.id,
//     required this.userId,
//     required this.programStudyId,
//     required this.nim,
//     required this.group,
//     required this.year,
//     required this.createdAt,
//     required this.updatedAt,
//     required this.programStudy
//   });
//
//   factory Student.fromJson(Map<String, dynamic> json) => Student(id: json["id"], userId: json["user_id"], programStudyId: json["program_study_id"], nim: json["nim"], group: json["group"], year: json["year"], createdAt: json["created_at"], updatedAt: json["updated_at"], programStudy: json["program_study"]);
//
//   Map<String, dynamic> toJson() =>{
//     "id":id,
//     "user_id":userId,
//     "program_study_id": programStudyId,
//     "nim":nim,
//     "group": group,
//     "year": year,
//     "created_at" : createdAt,
//     "updated_at": updatedAt,
//     "program_study": programStudy
//   };
//
//   int id;
//   int userId;
//   int programStudyId;
//   String nim;
//   String group;
//   String year;
//   String createdAt;
//   String updatedAt;
//   String programStudy;
// }
//

// class UserModel {
//   UserModel({
//     required this.message,
//     required this.success,
//     required this.code,
//     required this.data
//   });
//
//   String message;
//   bool success;
//   int code;
//   DataUser data;
//
//   factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(message: json["message"], success: json["success"], code: json["code"], data: json["data"]);
//
//   Map<String, dynamic> toJson() => {
//     "message": message,
//     "success":success,
//     "code": code,
//     "data" : DataUser,
//   };
// }
//
// class DataUser{
//   DataUser({
//     required this.user
//   });
//
//   User user;
//
//   factory DataUser.fromJson(Map<String, dynamic> json) => DataUser(user: json["user"]);
//
//   Map<String, dynamic> toJson() => {
//     "user": User
//   };
// }

class User{
  final int id;
  final String name;
  final String email;
  final String profile_photo_path;
  final String profile_photo_url;

  User(this.id, this.name, this.email, this.profile_photo_path, this.profile_photo_url);

  User.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        email = json['email'],
        profile_photo_path = json['profile_photo_path'],
        profile_photo_url = json['profile_photo_url'];

  Map<String, dynamic> toJson() => {
    'id': id,
    'name' : name,
    'email' : email,
    'profile_photo_path' : profile_photo_path,
    'profile_photo_url' : profile_photo_url
  };
}
