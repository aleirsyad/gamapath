import 'package:equatable/equatable.dart';

abstract class LearningModuleDetailEvent extends Equatable{
  const LearningModuleDetailEvent();
}

class GetLearningModuleDetail extends LearningModuleDetailEvent{
  final String learningModuleId;
  const GetLearningModuleDetail({required this.learningModuleId});
  @override
  List<Object>? get props => [learningModuleId];
}