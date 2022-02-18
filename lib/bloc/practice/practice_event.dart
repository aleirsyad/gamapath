import 'package:equatable/equatable.dart';

abstract class PracticeEvent extends Equatable{
  const PracticeEvent();
}

class GetPractice extends PracticeEvent{
  @override
  List<Object>? get props => null;
}