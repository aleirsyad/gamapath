import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:gamapath/model/PracticeModel.dart';

class PracticeProvider{
  final Dio _dio = Dio();
  final FlutterSecureStorage storage = new FlutterSecureStorage();
  static String mainUrl = "https://gamapath.fk-kmk.id/api";

  Future<List<PracticeItem>> getPractice() async{
    String userToken = await storage.read(key: 'token');
    var practiceUrl = '$mainUrl/pratices';
    try{
      _dio.options.headers["Authorization"] = 'Bearer $userToken';
      Response response = await _dio.get(practiceUrl);
      print('Practice URL :  $practiceUrl');
      print("User Token : $userToken");
      print("data ${response.data}");
      List<PracticeItem> practices = PracticeModel.fromJson(response.data).data;
      return practices;
    }catch(error, stacktrace){
      print(
      "Exception occured: $error stackTrace: $stacktrace token : $userToken");
    return <PracticeItem>[];
    }
  }
}