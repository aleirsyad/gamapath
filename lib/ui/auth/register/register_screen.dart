import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gamapath/bloc/auth/auth_bloc.dart';
import 'package:gamapath/bloc/register/register_bloc.dart';
import 'package:gamapath/repositories/user_repository.dart';
import 'package:gamapath/ui/auth/register/register_form.dart';

class RegisterScreen extends StatelessWidget {
  final UserRepository userRepository;
  RegisterScreen({Key? key, required this.userRepository})
      : assert(userRepository != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: BlocProvider(
        create: (context) {
          return RegisterBloc(
            authenticationBloc: BlocProvider.of<AuthenticationBloc>(context),
            userRepository: userRepository,
          );
        },
        child: RegisterForm(userRepository: userRepository),
      ),
    );
  }
}