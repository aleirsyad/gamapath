// import 'package:dio/dio.dart';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// import 'package:gamapath/model/UserModel.dart';
//
// class UserProvider{
//   final Dio _dio = Dio();
//   final FlutterSecureStorage storage = new FlutterSecureStorage();
//   static String mainUrl = "https://gamapath.fk-kmk.id/api";
//   var profileUrl = '$mainUrl/auth/me';
//
//   Future<String?> getUserToken() async{
//     String token = await storage.read(key: 'token');
//     return token;
//   }
//
//   Future<User> fetchUser() async{
//     String userToken = await storage.read(key: 'token');
//     try{
//       _dio.options.headers["Authorization"] = 'Bearer $userToken';
//       Response response = await _dio.get(profileUrl);
//       print('Profile URL :  $profileUrl');
//       print("User Token : $userToken");
//       print("data : ${response.data}");
//       return UserModel.fromJson(response.data).data;
//     }catch(error, stacktrace){
//       print("User Token $userToken");
//       print(
//           "Exception occured: $error stackTrace: $stacktrace token : $userToken");
//       // return UserItem(id:0,name: "name", email: "email",emailVerifiedAt: "email_verified_at", currentTeamId: "current_team_id",profilePhotoPath: "profile_photo_path",createdAt: "created_at",updatedAt: "updated_at", active: 0, profilePhotoUrl: "profile_photo_url_ini", roles: [], student: Student(id: 0, userId: 0, programStudyId: 0, nim: "nim", group: "group", year: "year", createdAt: "created_at", updatedAt: "updated_at", programStudy: "program_study" ));
//       return User(userItem: UserItem(id:0,name: "name", email: "email",emailVerifiedAt: "email_verified_at", currentTeamId: 0,profilePhotoPath: "profile_photo_path",createdAt: "created_at",updatedAt: "updated_at", active: 0, profilePhotoUrl: "profile_photo_url_ini", roles: [], student: Student(id: 0, userId: 0, programStudyId: 0, nim: "nim", group: "group", year: "year", createdAt: "created_at", updatedAt: "updated_at", programStudy: "program_study" )));
//     }
//   }
// }

import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:gamapath/model/UserModel.dart';

class UserProvider{
  final Dio _dio = Dio();
  final FlutterSecureStorage storage = new FlutterSecureStorage();
  static String mainUrl = "https://gamapath.fk-kmk.id/api";
  var profileUrl = '$mainUrl/auth/me';

  Future<String?> getUserToken() async{
    String token = await storage.read(key: 'token');
    return token;
  }

  Future<User> fetchUser() async{
    String userToken = await storage.read(key: 'token');
    try{
      _dio.options.headers["Authorization"] = 'Bearer $userToken';
      Response response = await _dio.get(profileUrl);
      print('Me URL :  $profileUrl');
      print("User Token : $userToken");
      print("data : ${response.data}");
      return User.fromJson(response.data['data']['user']);
    }catch(error, stacktrace){
      print("User Token $userToken");
      print(
          "Exception occured: $error stackTrace: $stacktrace token : $userToken");
      return User(0, "name", "email", "profile_photo_path", "profile_photo_url");
    }
  }

  Future<String?> saveProfile(String name, String email, File avatar) async{
    var saveProfileUrl = '$mainUrl/auth/change-profile';
    String userToken = await storage.read(key: 'token');
    String fileName = avatar.path.split('/').last;
    print(fileName);

    FormData data = FormData.fromMap({
      "name" : MultipartFile.fromString(name),
      "email": MultipartFile.fromString(email),
      "avatar": await MultipartFile.fromFile(
        avatar.path,
        filename: fileName,
      ),
    });

    try{
      _dio.options.headers["Authorization"] = 'Bearer $userToken';
      Response response = await _dio.post(saveProfileUrl, data: data);
      print('change profile URL :  $saveProfileUrl');
      print("User Token : $userToken");
      print("data : ${response.data}");
      return response.data['message'];
    }catch(error){
      print("User Token $userToken");
      print(error);
    }
  }

  Future<String?> saveProfileNoPhoto(String name, String email) async{
    var saveProfileUrl = '$mainUrl/auth/change-profile';
    String userToken = await storage.read(key: 'token');

    FormData data = FormData.fromMap({
      "name" : MultipartFile.fromString(name),
      "email": MultipartFile.fromString(email),
    });

    try{
      _dio.options.headers["Authorization"] = 'Bearer $userToken';
      Response response = await _dio.post(saveProfileUrl, data: data);
      print('change profile URL :  $saveProfileUrl');
      print("User Token : $userToken");
      print("data : ${response.data}");
      return response.data['message'];
    }catch(error){
      print("User Token $userToken");
      print(error);
    }
  }
}