import 'package:gamapath/model/CategoriesModel.dart';
import 'package:gamapath/model/QuestionModel.dart';
import 'package:gamapath/provider/categories_provider.dart';

import '../provider/pretest_provider.dart';

class PretestRepository{
  final _pretestProvider = PretestProvider();

  Future<List<QuestionItem>> getPretest(String id){
    return _pretestProvider.getPretest(id);
  }

  Future<bool?> answerPretest(String answer, String number, String id){
    return _pretestProvider.answerPretest(answer, number, id);
  }

  Future<int?> finishPretest(String id){
    return _pretestProvider.finishPretest(id);
  }
}

class PretestNetworkError extends Error{}