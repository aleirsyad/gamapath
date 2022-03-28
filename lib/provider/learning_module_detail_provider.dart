import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:gamapath/model/LearningModuleModel.dart';

import '../model/LearningModuleDetailModel.dart';

class LearningModuleDetailProvider{
  final Dio _dio = Dio();
  final FlutterSecureStorage storage = new FlutterSecureStorage();
  static String mainUrl = "https://gamapath.fk-kmk.id/api";

  Future<List<CasesItem>> getCases(String learningModuleId) async{
    String userToken = await storage.read(key: 'token');
    var casesUrl = '$mainUrl/learning-modules/$learningModuleId';
    try{
      _dio.options.headers["Authorization"] = 'Bearer $userToken';
      Response response = await _dio.get(casesUrl);
      print('learningModule URL :  $casesUrl');
      print("User Token : $userToken");
      print("data ${response.data}");
      List<CasesItem> cases = LearningModuleDetailModel.fromJson(response.data).data.cases;
      return cases;
    }catch(error, stacktrace){
      print(
      "Exception occured: $error stackTrace: $stacktrace token : $userToken");
    return <CasesItem>[];
    }
  }
}