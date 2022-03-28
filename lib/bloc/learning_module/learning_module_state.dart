import 'package:equatable/equatable.dart';
import 'package:gamapath/model/LearningModuleModel.dart';

abstract class LearningModuleState extends Equatable{
  const LearningModuleState();
  @override
  List<Object> get props => [];
}

class LearningModuleInitial extends LearningModuleState{
  const LearningModuleInitial();
  List<Object> get props => [];
}

class LearningModuleLoading extends LearningModuleState{
  const LearningModuleLoading();
  List<Object> get props => [];
}

class LearningModuleFailure extends LearningModuleState{
  final String error;
  const LearningModuleFailure({required this.error});
  @override
  List<Object> get props => [];
  @override
  String toString() => 'Load Learning Module failure { error : $error}';
}

class LearningModuleLoaded extends LearningModuleState{
  final List<LearningModuleItem> learningModule;

  const LearningModuleLoaded({required this.learningModule});
  @override
  String toString() => 'Learning Module Loaded {data: $learningModule}';
  @override
  List<Object> get props => [learningModule];
}
