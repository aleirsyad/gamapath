import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../model/LearningModuleDetailModel.dart';

class LearningModuleCasesProvider{
  final Dio _dio = Dio();
  final FlutterSecureStorage storage = new FlutterSecureStorage();
  static String mainUrl = "https://gamapath.fk-kmk.id/api";

  Future<List<ModulesItem>> getCasesDetail(String learningModuleId, String casesId) async{
    String userToken = await storage.read(key: 'token');
    var casesUrl = '$mainUrl/learning-modules/$learningModuleId';
    try{
      _dio.options.headers["Authorization"] = 'Bearer $userToken';
      Response response = await _dio.get(casesUrl);
      print('learningModule URL :  $casesUrl');
      print("User Token : $userToken");
      print("data ${response.data}");

      List<ModulesItem> modules = [];
      for (var element in LearningModuleDetailModel.fromJson(response.data).data.cases) {
        for(var elements in element.modules){
          if(elements.parentId.toString() == casesId){
            modules.addAll(element.modules);
          }
        }
      }
      return modules;
    }catch(error, stacktrace){
      print(
          "Exception occured: $error stackTrace: $stacktrace token : $userToken");
      return <ModulesItem>[];
    }
  }
}