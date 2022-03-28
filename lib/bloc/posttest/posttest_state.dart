import 'package:equatable/equatable.dart';
import 'package:gamapath/model/QuestionModel.dart';

abstract class PosttestState extends Equatable{
  const PosttestState();
  @override
  List<Object> get props => [];
}

class PosttestInitial extends PosttestState{
  const PosttestInitial();
  List<Object> get props => [];
}

class PosttestLoading extends PosttestState{
  const PosttestLoading();
  List<Object> get props => [];
}

class PosttestFailure extends PosttestState{
  final String error;
  const PosttestFailure({required this.error});
  @override
  List<Object> get props => [];
  @override
  String toString() => 'Posttest failure { error : $error}';
}

class PosttestLoaded extends PosttestState{
  final QuestionItem question;
  final int sub ;

  const PosttestLoaded({required this.question, required this.sub});
  @override
  String toString() => 'Posttest Loaded {data: $question, sub: $sub}';
  @override
  List<Object> get props => [question, sub];
}

class NextQuestionLoaded extends PosttestState{
  final QuestionItem question;
  final int sub ;

  const NextQuestionLoaded({required this.question, required this.sub});
  @override
  String toString() => 'Next Question Loaded {data: $question, amount: $sub}';
  @override
  List<Object> get props => [question, sub];
}

class LastQuestionLoaded extends PosttestState{
  final QuestionItem question;

  const LastQuestionLoaded({required this.question});
  @override
  String toString() => 'Next Question Loaded {data: $question}';
  @override
  List<Object> get props => [question];
}

class FinishQuestionLoaded extends PosttestState{
  final int point;

  const FinishQuestionLoaded({required this.point});
  @override
  String toString() => 'Finish Question Loaded {point: $point}';
  @override
  List<Object> get props => [point];
}

// class FirstQuestionLoaded extends PosttestState{
//   final List<QuestionItem> question;
//   final int amount;
//
//   const FirstQuestionLoaded({required this.question, required this.amount});
//   @override
//   String toString() => 'First Question Loaded {data: $question, amount:$amount}';
//   @override
//   List<Object> get props => [question, amount];
// }