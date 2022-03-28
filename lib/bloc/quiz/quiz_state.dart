import 'package:equatable/equatable.dart';
import 'package:gamapath/model/QuestionModel.dart';

abstract class QuizState extends Equatable{
  const QuizState();
  @override
  List<Object> get props => [];
}

class QuizInitial extends QuizState{
  const QuizInitial();
  List<Object> get props => [];
}

class QuizLoading extends QuizState{
  const QuizLoading();
  List<Object> get props => [];
}

class QuizFailure extends QuizState{
  final String error;
  const QuizFailure({required this.error});
  @override
  List<Object> get props => [];
  @override
  String toString() => 'Quiz failure { error : $error}';
}

class QuizLoaded extends QuizState{
  final QuestionItem question;
  final int sub ;

  const QuizLoaded({required this.question, required this.sub});
  @override
  String toString() => 'Quiz Loaded {data: $question, sub: $sub}';
  @override
  List<Object> get props => [question, sub];
}

class NextQuestionLoaded extends QuizState{
  final QuestionItem question;
  final int sub ;

  const NextQuestionLoaded({required this.question, required this.sub});
  @override
  String toString() => 'Next Question Loaded {data: $question, amount: $sub}';
  @override
  List<Object> get props => [question, sub];
}

class LastQuestionLoaded extends QuizState{
  final QuestionItem question;

  const LastQuestionLoaded({required this.question});
  @override
  String toString() => 'Next Question Loaded {data: $question}';
  @override
  List<Object> get props => [question];
}

class FinishQuestionLoaded extends QuizState{
  final int point;

  const FinishQuestionLoaded({required this.point});
  @override
  String toString() => 'Finish Question Loaded {point: $point}';
  @override
  List<Object> get props => [point];
}