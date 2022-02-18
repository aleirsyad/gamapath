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