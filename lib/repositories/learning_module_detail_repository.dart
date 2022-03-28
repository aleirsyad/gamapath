import 'package:gamapath/model/LearningModuleDetailModel.dart';

import '../provider/learning_module_detail_provider.dart';

class LearningModuleDetailRepository{
  final _LearningModuleDetailProvider = LearningModuleDetailProvider();

  Future<List<CasesItem>> getCases(String learningModuleId){
    return _LearningModuleDetailProvider.getCases(learningModuleId);
  }
}

class LearningModuleDetailNetworkError extends Error{}