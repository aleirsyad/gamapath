import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gamapath/repositories/user_repository.dart';

import 'auth_state.dart';
import 'auth_event.dart';

@immutable
class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState>{
  final UserRepository userRepository;
  AuthenticationBloc({required this.userRepository})
      : assert(userRepository != null);

  @override
  AuthenticationState get initialState => AuthenticationUninitialized();

  @override
  Stream<AuthenticationState> mapEventToState(AuthenticationEvent event) async*{
    if (event is AppStarted){
      final bool hasToken = await userRepository.hasToken();
      if(hasToken){
        yield AuthenticationAuthenticated();
      }else{
        yield AuthenticationUnauthenticated();
      }
    }

    if(event is LoggedIn){
      yield AuthenticationLoading();
      await userRepository.persistToken(event.token);
      yield AuthenticationAuthenticated();
    }

    if (event is Registered) {
      yield AuthenticationLoading();
      await userRepository.persistToken(event.token);
      yield AuthenticationAuthenticated();
    }

    if (event is Register){
      yield AuthenticationLoading();
      yield AuthenticationNeedRegister();
    }

    if(event is Logout){
      yield AuthenticationUnauthenticated();
    }
  }
}