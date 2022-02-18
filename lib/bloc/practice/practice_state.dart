import 'package:equatable/equatable.dart';
import 'package:gamapath/model/PracticeModel.dart';

abstract class PracticeState extends Equatable{
  const PracticeState();
  @override
  List<Object> get props => [];
}

class PracticeInitial extends PracticeState{
  const PracticeInitial();
  @override
  List<Object> get props => [];
}

class PracticeLoading extends PracticeState{
  const PracticeLoading();
  @override
  List<Object> get props => [];
}

class PracticeFailure extends PracticeState{
  final String error;
  const PracticeFailure({required this. error});
  @override
  List<Object> get props => [];
  @override
  String toString() => 'Load pratice failure { error: $error}';
}

class PracticeLoaded extends PracticeState{
  final List<PracticeItem> practice;
  const PracticeLoaded({required this.practice});
  @override
  String toString() => 'Pratice Loaded {data: $practice}';
  @override
  List<Object> get props => [practice];
}