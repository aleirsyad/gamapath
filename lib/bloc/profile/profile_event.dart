import 'dart:io';

import 'package:equatable/equatable.dart';

abstract class ProfileEvent extends Equatable{
  const ProfileEvent();
}

class GetProfile extends ProfileEvent{
  @override
  List<Object>? get props => null;
}

class GetProfilePhotoSaved extends ProfileEvent{
  final File photo;
  const GetProfilePhotoSaved({required this.photo});

  @override
  List<Object>? get props => null;
  @override
  String toString() =>
      'GetProfilePhotoSaved {photo $photo}';
}


class SaveProfileButtonPressed extends ProfileEvent{
  final String name;
  final String email;
  final File avatar;

  const SaveProfileButtonPressed({required this.name, required this.email, required this.avatar});

  @override
  List<Object> get props => [name, email, avatar];
  @override
  String toString() =>
      'NextQuestionButtonPressed {name: $name, email: $email, avatar: $avatar}' ;
}

class LogoutButtonPressed extends ProfileEvent{
  const LogoutButtonPressed();

  @override
  List<Object> get props => [];
  @override
  String toString() =>
      'LogoutButtonPressed {}' ;
}


class SaveProfileNoPhotoButtonPressed extends ProfileEvent{
  final String name;
  final String email;

  const SaveProfileNoPhotoButtonPressed({required this.name, required this.email});

  @override
  List<Object> get props => [name, email];
  @override
  String toString() =>
      'NextQuestionButtonPressed {name: $name, email: $email}' ;
}