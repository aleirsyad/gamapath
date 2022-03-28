import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gamapath/bloc/learning_module/learning_module_event.dart';
import 'package:gamapath/bloc/learning_module/learning_module_state.dart';
import 'package:gamapath/model/LearningModuleDetailModel.dart';
import 'package:gamapath/model/LearningModuleModel.dart';
import 'package:gamapath/repositories/learning_module_repository.dart';

import '../../../repositories/learning_module_detail_repository.dart';
import 'learning_module_detail_event.dart';
import 'learning_module_detail_state.dart';

class LearningModuleDetailBloc extends Bloc<LearningModuleDetailEvent, LearningModuleDetailState>{
  final LearningModuleDetailRepository _learningModuleDetailRepository = LearningModuleDetailRepository();

  @override
  LearningModuleDetailState get initialState => const LearningModuleDetailInitial();

  @override
  Stream<LearningModuleDetailState> mapEventToState(
      LearningModuleDetailEvent event
      ) async*{
    if(event is GetLearningModuleDetail){
      try{
        yield LearningModuleDetailLoading();
        
        List<CasesItem> _cases = await _learningModuleDetailRepository.getCases(event.learningModuleId);
        yield LearningModuleDetailLoaded(cases: _cases);
      }catch(error){
        yield const LearningModuleDetailFailure(error: "error");
      }
    }
  }
}