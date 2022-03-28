import 'dart:io';

import 'package:equatable/equatable.dart';

import '../../model/UserModel.dart';

abstract class ProfileState extends Equatable{
  const ProfileState();
  @override
  List<Object> get props => [];
}

class ProfileInitial extends ProfileState{
  const ProfileInitial();
  @override
  List<Object> get props => [];
}

class ProfileLoading extends ProfileState{
  const ProfileLoading();
  @override
  List<Object> get props => [];
}

class ProfileFailure extends ProfileState{
  final String error;
  const ProfileFailure({required this.error});
  @override
  List<Object> get props => [];
  @override
  String toString() => 'Load Profile failure { error: $error}';
}

class ProfileLoaded extends ProfileState{
  // final User userItem;
  final User user;

  const ProfileLoaded({required this.user});
  @override
  String toString() => 'Profile Loaded {data: $user}';
  @override
  List<Object> get props => [user];
}

class SavePhotoLoaded extends ProfileState{
  // final User userItem;
  final User user;
  final File photo;

  const SavePhotoLoaded({required this.user, required this.photo});
  @override
  String toString() => 'Save Photo Loaded {data: $user, photo: $photo}';
  @override
  List<Object> get props => [user, photo];
}

class SaveProfileLoaded extends ProfileState{
  const SaveProfileLoaded();
  @override
  String toString() => 'Save Profile Loaded {}';
  @override
  List<Object> get props => [];
}

class LoggedOut extends ProfileState{
  const LoggedOut();
  @override
  String toString() => 'Logged Out {}';
  @override
  List<Object> get props => [];
}