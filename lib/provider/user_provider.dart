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
      print('Practice URL :  $profileUrl');
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
}