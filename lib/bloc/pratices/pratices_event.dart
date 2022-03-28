import 'package:equatable/equatable.dart';

abstract class PraticesEvent extends Equatable{
  const PraticesEvent();
}

class GetPratices extends PraticesEvent{
  @override
  List<Object>? get props => null;
}
