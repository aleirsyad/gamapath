import 'package:gamapath/model/LearningModuleModel.dart';
import 'package:gamapath/provider/learning_module_provider.dart';

class LearningModuleRepository{
  final _LearningModuleProvider = LearningModuleProvider();

  Future<List<LearningModuleItem>> getLearningModule(String categoriesId){
    return _LearningModuleProvider.getLearningModule(categoriesId);
  }
}

class LearningModuleNetworkError extends Error{}