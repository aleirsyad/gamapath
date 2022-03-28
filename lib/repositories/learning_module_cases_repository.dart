import 'package:gamapath/model/LearningModuleDetailModel.dart';

import '../provider/learning_module_cases_provider.dart';
import '../provider/learning_module_detail_provider.dart';

class LearningModuleCasesRepository{
  final _LearningModuleCasesProvider = LearningModuleCasesProvider();

  Future<List<ModulesItem>> getCasesDetail(String learningModuleId, String casesId){
    return _LearningModuleCasesProvider.getCasesDetail(learningModuleId, casesId);
  }
}

class LearningModuleCasesNetworkError extends Error{}