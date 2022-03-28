import 'package:equatable/equatable.dart';
import 'package:gamapath/model/UserModel.dart';

import '../../model/CategoriesModel.dart';
import '../../model/PracticeModel.dart';

abstract class PraticesState extends Equatable{
  const PraticesState();
  @override
  List<Object> get props => [];
}

class PraticesInitial extends PraticesState{
  const PraticesInitial();
  @override
  List<Object> get props => [];
}

class PraticesLoading extends PraticesState{
  const PraticesLoading();
  @override
  List<Object> get props => [];
}

class PraticesFailure extends PraticesState{
  final String error;
  const PraticesFailure({required this.error});
  @override
  List<Object> get props => [];
  @override
  String toString() => 'Load Pratices failure { error: $error}';
}

class PraticesLoaded extends PraticesState{
  // final User userItem;
  final List<PracticeItem> practice;

  const PraticesLoaded({required this.practice});
  @override
  String toString() => 'Pratices Loaded {data: $practice}';
  @override
  List<Object> get props => [practice];
}
