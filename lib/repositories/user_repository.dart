import 'dart:developer';
import 'dart:io';
import 'dart:math';

import 'package:dio/src/options.dart' as Opt;
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:gamapath/model/UserModel.dart';
import 'package:gamapath/provider/user_provider.dart';

class UserRepository{
  static String mainUrl = "https://gamapath.fk-kmk.id/api";
  var loginUrl = '$mainUrl/auth/login';
  var registerUrl = '$mainUrl/auth/register';

  final _userProvider = UserProvider();
  
  final FlutterSecureStorage storage = new FlutterSecureStorage();
  final Dio _dio = Dio();
  
  Future<bool> hasToken() async{
    String token = await storage.read(key: 'token');
    return token != null ? true : false;
  }

  Future<void> persistToken(String token) async{
    await storage.write(key: 'token', value: token);
  }

  Future<void> deleteToken() async{
    await storage.delete(key: 'token');
  }

  Future<String?> login(String email, String password) async{
    Response response =
        await _dio.post(loginUrl, data: {"email": email, "password":password});
    // log(response.data.toString());
    if(response.statusCode == 200){
      persistToken(response.data['data']['token']);
      return response.data['data']['token'];
    }else{
      return null;
    }
  }

  Future<String?> register(
      String role,
      String name,
      String email,
      String password,
      String password_c,
      String program_study_id,
      String nim,
      String group,
      ) async {
    Response response = await _dio.post(registerUrl,
        data: {
          "role":role,
          "name": name,
          "email": email,
          "password": password,
          "password_confirmation": password_c,
          "program_study_id": program_study_id,
          "nim": nim,
          "group":group
        },
        options: Opt.Options(
            followRedirects: false,
            validateStatus: (status) {
              return status < 500;
            }));
    // log(response.data.toString());
    if (response.statusCode == 200) {
      persistToken(response.data['data']['token']);
      return response.data['data']['token'];
    } else {
      return null;
    }
  }

  Future<User> getUser() {
    return _userProvider.fetchUser();
  }

  Future<String?> saveProfile(String name, String email, File avatar){
    return _userProvider.saveProfile(name, email, avatar);
  }

  Future<String?> saveProfileNoPhoto(String name, String email){
    return _userProvider.saveProfileNoPhoto(name, email);
  }
}