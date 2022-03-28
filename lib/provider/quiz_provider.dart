import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../model/QuestionModel.dart';

class QuizProvider{
  final Dio _dio = Dio();
  final FlutterSecureStorage storage = new FlutterSecureStorage();
  static String mainUrl = "https://gamapath.fk-kmk.id/api";

  Future<List<QuestionItem>> getQuiz(String id) async{
    String userToken = await storage.read(key: 'token');
    var questionUrl = '$mainUrl/learning-modules/$id/quizzes';
    try{
      _dio.options.headers["Authorization"] = 'Bearer $userToken';
      Response response = await _dio.get(questionUrl);
      print('Question URL :  $questionUrl');
      print("User Token : $userToken");
      print("data ${response.data}");
      List<QuestionItem> question = QuestionModel.fromJson(response.data).data;
      return question;
    }catch(error, stacktrace){
      print(
          "Exception occured: $error stackTrace: $stacktrace token : $userToken");
      return <QuestionItem>[];
    }
  }

  Future<bool?> answerQuiz(String answer, String number, String id) async{
    String userToken = await storage.read(key: 'token');
    var answerUrl = '$mainUrl/learning-modules/$id/quizzes/$number/answer';

    _dio.options.headers["Authorization"] = 'Bearer $userToken';
    _dio.options.headers['Accept'] = 'application/json';
    Response response = await _dio.post(answerUrl, data: {"answer": answer});
    if(response.statusCode == 201){
      print("data: ${response.data}");
      // return response.data['success'];
      return true;
    }else{
      return false;
    }
  }

  Future<int?> finishQuiz(String id) async{
    String userToken = await storage.read(key: 'token');
    var finishUrl = '$mainUrl/learning-modules/$id/quizzes/finish';

    _dio.options.headers["Authorization"] = 'Bearer $userToken';
    _dio.options.headers['Accept'] = 'application/json';
    Response response = await _dio.post(finishUrl);
    if(response.statusCode == 201){
      print("data: ${response.data}");
      // return response.data['success'];
      return response.data['data']['point'];
    }else{
      return null;
    }
  }
  
}