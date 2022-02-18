import 'package:equatable/equatable.dart';
import 'package:gamapath/model/UserModel.dart';

abstract class UserState extends Equatable{
  const UserState();
  @override
  List<Object> get props => [];
}

class UserInitial extends UserState{
  const UserInitial();
  @override
  List<Object> get props => [];
}

class UserLoading extends UserState{
  const UserLoading();
  @override
  List<Object> get props => [];
}

class UserFailure extends UserState{
  final String error;
  const UserFailure({required this.error});
  @override
  List<Object> get props => [];
  @override
  String toString() => 'Load user failure { error: $error}';
}

class UserLoaded extends UserState{
  final User user;
  const UserLoaded({required this.user});
  @override
  String toString() => 'User Loaded {data: $user}';
  @override
  List<Object> get props => [user];
}
