import 'package:equatable/equatable.dart';

abstract class PretestEvent extends Equatable{
  const PretestEvent();
}

class GetQuestion extends PretestEvent{
  final String praticesId;
  const GetQuestion({required this.praticesId});
  @override
  List<Object> get props => [praticesId];
}

class NextQuestionButtonPressed extends PretestEvent{
  final String praticesId;
  final int sub;
  final String answer;
  final String number;
  // final String answer;
  const NextQuestionButtonPressed({required this.praticesId, required this.sub, required this.answer, required this.number});

  @override
  List<Object> get props => [praticesId, sub, answer, number];
  @override
  String toString() =>
      'NextQuestionButtonPressed {pratices_id: $praticesId, amount: $sub, answer : $answer, number: $number}' ;
}

class PreviousQuestionButtonPressed extends PretestEvent{
  final String praticesId;
  final int amount;
  // final String answer;
  const PreviousQuestionButtonPressed({required this.praticesId, required this.amount});

  @override
  List<Object> get props => [praticesId, amount];
  @override
  String toString() =>
      'PreviousQuestionButtonPressed {pratices_id: $praticesId, amount: $amount';
}

class LastQuestionButtonPressed extends PretestEvent{
  final String praticesId;
  // final String answer;
  final String answer;
  final String number;
  const LastQuestionButtonPressed({required this.praticesId, required this.answer, required this.number});

  @override
  List<Object> get props => [praticesId, answer, number];
  @override
  String toString() =>
      'LastQuestionButtonPressed {pratices_id: $praticesId answer : $answer, number: $number}';
}



