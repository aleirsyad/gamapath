import 'package:equatable/equatable.dart';

abstract class LearningModuleEvent extends Equatable{
  const LearningModuleEvent();
}

class GetLearningModule extends LearningModuleEvent{
  final String categoriesId;
  const GetLearningModule({required this.categoriesId});
  @override
  List<Object>? get props => [categoriesId];
}