import 'package:equatable/equatable.dart';
import 'package:gamapath/model/LearningModuleDetailModel.dart';
import 'package:gamapath/model/LearningModuleModel.dart';

abstract class LearningModuleDetailState extends Equatable{
  const LearningModuleDetailState();
  @override
  List<Object> get props => [];
}

class LearningModuleDetailInitial extends LearningModuleDetailState{
  const LearningModuleDetailInitial();
  List<Object> get props => [];
}

class LearningModuleDetailLoading extends LearningModuleDetailState{
  const LearningModuleDetailLoading();
  List<Object> get props => [];
}

class LearningModuleDetailFailure extends LearningModuleDetailState{
  final String error;
  const LearningModuleDetailFailure({required this.error});
  @override
  List<Object> get props => [];
  @override
  String toString() => 'Load Learning Module Detail failure { error : $error}';
}

class LearningModuleDetailLoaded extends LearningModuleDetailState{
  final List<CasesItem> cases;

  const LearningModuleDetailLoaded({required this.cases});
  @override
  String toString() => 'Learning Module Detail Loaded {data: $cases}';
  @override
  List<Object> get props => [cases];
}
