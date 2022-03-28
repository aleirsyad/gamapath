import 'package:equatable/equatable.dart';
import '../../../model/LearningModuleDetailModel.dart';

abstract class LearningModuleCasesState extends Equatable{
  const LearningModuleCasesState();
  @override
  List<Object> get props => [];
}

class LearningModuleCasesInitial extends LearningModuleCasesState{
  const LearningModuleCasesInitial();
  List<Object> get props => [];
}

class LearningModuleCasesLoading extends LearningModuleCasesState{
  const LearningModuleCasesLoading();
  List<Object> get props => [];
}

class LearningModuleCasesFailure extends LearningModuleCasesState{
  final String error;
  const LearningModuleCasesFailure({required this.error});
  @override
  List<Object> get props => [];
  @override
  String toString() => 'Load Learning Module Cases failure { error : $error}';
}

class LearningModuleCasesLoaded extends LearningModuleCasesState{
  final List<ModulesItem> modules;

  const LearningModuleCasesLoaded({required this.modules});
  @override
  String toString() => 'Learning Module Cases Loaded {data: $modules}';
  @override
  List<Object> get props => [modules];
}
