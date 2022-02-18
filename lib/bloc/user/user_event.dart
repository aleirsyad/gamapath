import 'package:equatable/equatable.dart';

abstract class UserEvent extends Equatable{
  const UserEvent();
}

class GetUser extends UserEvent{
  @override
  List<Object>? get props => null;
}