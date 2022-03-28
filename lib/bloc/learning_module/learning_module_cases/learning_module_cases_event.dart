import 'package:equatable/equatable.dart';

abstract class LearningModuleCasesEvent extends Equatable{
  const LearningModuleCasesEvent();
}

class GetLearningModuleCases extends LearningModuleCasesEvent{
  final String learningModuleId;
  final String casesId;
  const GetLearningModuleCases({required this.learningModuleId, required this.casesId});
  @override
  List<Object>? get props => [learningModuleId];
}