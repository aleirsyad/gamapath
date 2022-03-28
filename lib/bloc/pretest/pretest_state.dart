import 'package:equatable/equatable.dart';
import 'package:gamapath/model/QuestionModel.dart';

abstract class PretestState extends Equatable{
  const PretestState();
  @override
  List<Object> get props => [];
}

class PretestInitial extends PretestState{
  const PretestInitial();
  List<Object> get props => [];
}

class PretestLoading extends PretestState{
  const PretestLoading();
  List<Object> get props => [];
}

class PretestFailure extends PretestState{
  final String error;
  const PretestFailure({required this.error});
  @override
  List<Object> get props => [];
  @override
  String toString() => 'Pretest failure { error : $error}';
}

class PretestLoaded extends PretestState{
  final QuestionItem question;
  final int sub ;

  const PretestLoaded({required this.question, required this.sub});
  @override
  String toString() => 'Pretest Loaded {data: $question, sub: $sub}';
  @override
  List<Object> get props => [question, sub];
}

class NextQuestionLoaded extends PretestState{
  final QuestionItem question;
  final int sub ;

  const NextQuestionLoaded({required this.question, required this.sub});
  @override
  String toString() => 'Next Question Loaded {data: $question, amount: $sub}';
  @override
  List<Object> get props => [question, sub];
}

class LastQuestionLoaded extends PretestState{
  final QuestionItem question;

  const LastQuestionLoaded({required this.question});
  @override
  String toString() => 'Next Question Loaded {data: $question}';
  @override
  List<Object> get props => [question];
}

class FinishQuestionLoaded extends PretestState{
  final int point;

  const FinishQuestionLoaded({required this.point});
  @override
  String toString() => 'Finish Question Loaded {point: $point}';
  @override
  List<Object> get props => [point];
}

// class FirstQuestionLoaded extends PretestState{
//   final List<QuestionItem> question;
//   final int amount;
//
//   const FirstQuestionLoaded({required this.question, required this.amount});
//   @override
//   String toString() => 'First Question Loaded {data: $question, amount:$amount}';
//   @override
//   List<Object> get props => [question, amount];
// }