import 'package:equatable/equatable.dart';
import 'package:gamapath/model/UserModel.dart';

import '../../model/CategoriesModel.dart';
import '../../model/PracticeModel.dart';

abstract class HomeState extends Equatable{
  const HomeState();
  @override
  List<Object> get props => [];
}

class HomeInitial extends HomeState{
  const HomeInitial();
  @override
  List<Object> get props => [];
}

class HomeLoading extends HomeState{
  const HomeLoading();
  @override
  List<Object> get props => [];
}

class HomeFailure extends HomeState{
  final String error;
  const HomeFailure({required this.error});
  @override
  List<Object> get props => [];
  @override
  String toString() => 'Load Home failure { error: $error}';
}

class HomeLoaded extends HomeState{
  // final User userItem;
  final User user;
  final List<PracticeItem> practice;
  final List<CategoriesItem> categories;

  const HomeLoaded({required this.user, required this.practice, required this.categories});
  @override
  String toString() => 'Home Loaded {data: $user, $practice, $categories}';
  @override
  List<Object> get props => [user, practice, categories];
}
