import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gamapath/bloc/learning_module/learning_module_cases/learning_module_cases_event.dart';
import 'package:gamapath/bloc/learning_module/learning_module_cases/learning_module_cases_state.dart';
import 'package:gamapath/model/LearningModuleDetailModel.dart';


import '../../../repositories/learning_module_cases_repository.dart';


class LearningModuleCasesBloc extends Bloc<LearningModuleCasesEvent, LearningModuleCasesState>{
  final LearningModuleCasesRepository _learningModuleCasesRepository = LearningModuleCasesRepository();

  @override
  LearningModuleCasesState get initialState => const LearningModuleCasesInitial();

  @override
  Stream<LearningModuleCasesState> mapEventToState(
      LearningModuleCasesEvent event
      ) async*{
    if(event is GetLearningModuleCases){
      try{
        yield LearningModuleCasesLoading();
        
        List<ModulesItem> _modules = await _learningModuleCasesRepository.getCasesDetail(event.learningModuleId, event.casesId);
        yield LearningModuleCasesLoaded(modules: _modules);
      }catch(error){
        yield const LearningModuleCasesFailure(error: "error");
      }
    }
  }
}