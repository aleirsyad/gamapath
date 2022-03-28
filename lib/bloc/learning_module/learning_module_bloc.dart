import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gamapath/bloc/learning_module/learning_module_event.dart';
import 'package:gamapath/bloc/learning_module/learning_module_state.dart';
import 'package:gamapath/model/LearningModuleModel.dart';
import 'package:gamapath/repositories/learning_module_repository.dart';

class LearningModuleBloc extends Bloc<LearningModuleEvent, LearningModuleState>{
  final LearningModuleRepository _learningModuleRepository = LearningModuleRepository();

  @override
  LearningModuleState get initialState => const LearningModuleInitial();

  @override
  Stream<LearningModuleState> mapEventToState(
      LearningModuleEvent event
      ) async*{
    if(event is GetLearningModule){
      try{
        yield LearningModuleLoading();
        
        List<LearningModuleItem> _learningModule = await _learningModuleRepository.getLearningModule(event.categoriesId);
        yield LearningModuleLoaded(learningModule: _learningModule);
      }catch(error){
        yield const LearningModuleFailure(error: "error");
      }
    }
  }
}