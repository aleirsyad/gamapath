import 'package:bloc/bloc.dart';
import 'package:gamapath/bloc/auth/auth_bloc.dart';
import 'package:gamapath/bloc/auth/auth_event.dart';
import 'package:gamapath/bloc/register/register_event.dart';
import 'package:gamapath/bloc/register/register_state.dart';
import 'package:gamapath/repositories/user_repository.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final UserRepository userRepository;
  final AuthenticationBloc authenticationBloc;
  RegisterBloc({required this.userRepository, required this.authenticationBloc})
      : assert(userRepository != null),
        assert(authenticationBloc != null);
  @override
  RegisterState get initialState => RegisterInitial();

  @override
  Stream<RegisterState> mapEventToState(RegisterEvent event) async* {
    if (event is RegisterButtonPressed) {
      yield RegisterLoading();
      try {
        final token = await userRepository.register(
          event.role,
            event.name,
            event.email,
            event.password,
            event.password_c,
            event.program_study_id,
            event.nim,
            event.group);
        authenticationBloc.add(Registered(token: token));
        yield RegisterInitial();
      } catch (error) {
        yield RegisterFailure(error: error.toString());
      }
    }
  }
}