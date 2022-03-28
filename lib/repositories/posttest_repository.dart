import 'package:gamapath/model/CategoriesModel.dart';
import 'package:gamapath/model/QuestionModel.dart';
import 'package:gamapath/provider/categories_provider.dart';

import '../provider/posttest_provider.dart';

class PosttestRepository{
  final _posttestProvider = PosttestProvider();

  Future<List<QuestionItem>> getPosttest(String id){
    return _posttestProvider.getPosttest(id);
  }

  Future<bool?> answerPosttest(String answer, String number, String id){
    return _posttestProvider.answerPosttest(answer, number, id);
  }

  Future<int?> finishPosttest(String id){
    return _posttestProvider.finishPosttest(id);
  }
}

class PosttestNetworkError extends Error{}