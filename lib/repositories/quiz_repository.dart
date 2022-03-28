import 'package:gamapath/model/CategoriesModel.dart';
import 'package:gamapath/model/QuestionModel.dart';
import 'package:gamapath/provider/categories_provider.dart';

import '../provider/quiz_provider.dart';

class QuizRepository{
  final _quizProvider = QuizProvider();

  Future<List<QuestionItem>> getQuiz(String id){
    return _quizProvider.getQuiz(id);
  }

  Future<bool?> answerQuiz(String answer, String number, String id){
    return _quizProvider.answerQuiz(answer, number, id);
  }

  Future<int?> finishQuiz(String id){
    return _quizProvider.finishQuiz(id);
  }
}

class QuizNetworkError extends Error{}