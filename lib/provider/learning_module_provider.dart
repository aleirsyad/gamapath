import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:gamapath/model/LearningModuleModel.dart';

class LearningModuleProvider{
  final Dio _dio = Dio();
  final FlutterSecureStorage storage = new FlutterSecureStorage();
  static String mainUrl = "https://gamapath.fk-kmk.id/api";

  Future<List<LearningModuleItem>> getLearningModule(String categoriesId) async{
    String userToken = await storage.read(key: 'token');
    var learningModuleUrl = '$mainUrl/learning-modules';
    Map<String, String> queryParams = {
      'category_id': categoriesId
    };
    String queryString = Uri(queryParameters: queryParams).query;
    var requestUrl = learningModuleUrl + '?' + queryString;
    try{
      _dio.options.headers["Authorization"] = 'Bearer $userToken';
      Response response = await _dio.get(requestUrl);
      print('learningModule URL :  $requestUrl');
      print("User Token : $userToken");
      print("data ${response.data}");
      List<LearningModuleItem> learningModule = LearningModuleModel.fromJson(response.data).data;
      return learningModule;
    }catch(error, stacktrace){
      print(
      "Exception occured: $error stackTrace: $stacktrace token : $userToken");
    return <LearningModuleItem>[];
    }
  }
}