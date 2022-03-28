import 'package:bloc/bloc.dart';
import 'package:gamapath/bloc/auth/auth_bloc.dart';
import 'package:gamapath/bloc/auth/auth_event.dart';
import 'package:equatable/equatable.dart';
import 'package:gamapath/bloc/register/register_event.dart';
import 'package:gamapath/repositories/user_repository.dart';
part 'login_event.dart';
part 'login_state.dart';


class LoginBloc extends Bloc<LoginEvent, LoginState>{
  final UserRepository userRepository;
  final AuthenticationBloc authenticationBloc;
  LoginBloc({
    required this.userRepository,
    required this.authenticationBloc,
  })  : assert(userRepository != null),
        assert(authenticationBloc != null);
  @override
  LoginState get initialState => LoginInitial();

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is LoginButtonPressed) {
      yield LoginLoading();
      try {
        final token = await userRepository.login(event.email, event.password);
        authenticationBloc.add(LoggedIn(token: token));
        yield LoginInitial();
      } catch (error) {
        yield LoginFailure(error: error.toString());
      }
    }
    if(event is RegisterButtonPressed){
      yield LoginLoading();
      try{
        authenticationBloc.add(Register());
      }catch(error){
        yield LoginFailure(error: error.toString());
      }
    }
  }
}