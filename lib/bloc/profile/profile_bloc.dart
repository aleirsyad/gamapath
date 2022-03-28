import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:gamapath/bloc/auth/auth.dart';
import 'package:gamapath/bloc/home/home_bloc.dart';
import 'package:gamapath/bloc/home/home_event.dart';
import 'package:gamapath/bloc/profile/profile_event.dart';
import 'package:gamapath/bloc/profile/profile_state.dart';

import '../../model/UserModel.dart';
import '../../repositories/user_repository.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState>{
  final UserRepository _userRepository = UserRepository();
  late final AuthenticationBloc authenticationBloc;
  @override
  ProfileState get initialState => const ProfileInitial();

  @override
  Stream<ProfileState> mapEventToState(
      ProfileEvent event
      ) async*{
    if(event is GetProfile){
      try{
        yield ProfileLoading();

        User _user = await _userRepository.getUser();
        yield ProfileLoaded(user: _user);

      }catch(error){
        yield const ProfileFailure(error: "error");
      }
    }
    if(event is GetProfilePhotoSaved){
      try{
        yield ProfileLoading();
        File _photo = event.photo;
        User _user = await _userRepository.getUser();
        yield SavePhotoLoaded(user: _user, photo: _photo);

      }catch(error){
        yield const ProfileFailure(error: "error");
      }
    }
    if(event is SaveProfileButtonPressed){
      try{
        //yield ProfileLoading();
        await _userRepository.saveProfile(event.name, event.email, event.avatar);
        // _homeBloc.add(GetHome());
        yield SaveProfileLoaded();
      }catch(error){
        yield const ProfileFailure(error: "error");
      }
    }
    if(event is SaveProfileNoPhotoButtonPressed){
      try{
        //yield ProfileLoading();
        await _userRepository.saveProfileNoPhoto(event.name, event.email);
        // _homeBloc.add(GetHome());
        yield SaveProfileLoaded();
      }catch(error){
        yield const ProfileFailure(error: "error");
      }
    }
    if(event is LogoutButtonPressed){
      try{
        await _userRepository.deleteToken();
        yield LoggedOut();
        // authenticationBloc.add(Logout());
      }catch(error){
        yield const ProfileFailure(error: "error");
      }
    }
  }
}