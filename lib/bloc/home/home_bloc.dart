import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gamapath/bloc/home/home_event.dart';
import 'package:gamapath/bloc/home/home_state.dart';
import 'package:gamapath/model/CategoriesModel.dart';
import 'package:gamapath/model/UserModel.dart';

import '../../model/PracticeModel.dart';
import '../../repositories/categories_repository.dart';
import '../../repositories/practice_repository.dart';
import '../../repositories/user_repository.dart';
import 'home_event.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState>{
  //final UserProfileRepository _userProfileRepository = UserProfileRepository();
  final UserRepository _userRepository = UserRepository();
  final PracticeRepository _practiceRepository = PracticeRepository();
  final CategoriesRepository _categoriesRepository = CategoriesRepository();

  @override
  HomeState get initialState => const HomeInitial();

  @override
  Stream<HomeState> mapEventToState(
      HomeEvent event
      ) async*{
    if(event is GetHome){
      try{
        yield HomeLoading();

        //User _userItem = await _userProfileRepository.getUser();

        User _user = await _userRepository.getUser();
        List<PracticeItem> _practice = await _practiceRepository.getPractice();
        List<CategoriesItem> _categories = await _categoriesRepository.getCategories();
        yield HomeLoaded(user: _user, practice: _practice, categories: _categories);

      }catch(error){
        yield const HomeFailure(error: "error");
      }
    }
  }
}