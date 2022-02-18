import 'package:equatable/equatable.dart';

abstract class RegisterEvent extends Equatable {
  const RegisterEvent();
}

class RegisterButtonPressed extends RegisterEvent {
  final String role;
  final String name;
  final String email;
  final String password;
  final String password_c;
  final String program_study_id;
  final String nim;
  final String group;
  const RegisterButtonPressed(
      {required this.role,
        required this.name,
        required this.email,
        required this.password,
        required this.password_c,
        required this.program_study_id,
        required this.nim,
        required this.group});

  @override
  List<Object> get props =>
      [role, name, email, password, password_c, program_study_id, nim, group];
  @override
  String toString() =>
      'RegisterButtonPressed { role: $role, name: $name, email: $email, password: $password, password_c : $password_c, ,program_study_id : $program_study_id, nim : $nim, group : $group}';
}