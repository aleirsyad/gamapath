import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gamapath/bloc/user/user_event.dart';
import 'package:gamapath/bloc/user/user_state.dart';
import 'package:gamapath/model/UserModel.dart';
import 'package:gamapath/repositories/user_repository.dart';

class UserBloc extends Bloc<UserEvent, UserState>{
  final UserRepository _userRepository = UserRepository();

  @override
  UserState get initialState => const UserInitial();

  @override
  Stream<UserState> mapEventToState(
      UserEvent event
      ) async*{
    if(event is GetUser){
      try{
        yield UserLoading();
        User _user = await _userRepository.getUser();
        yield UserLoaded(user: _user);
      }catch(error){
        yield const UserFailure(error: "error");
      }
    }
  }
}