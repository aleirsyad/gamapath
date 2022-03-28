import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gamapath/bloc/pratices/pratices_event.dart';
import 'package:gamapath/bloc/pratices/pratices_state.dart';
import 'package:gamapath/model/CategoriesModel.dart';
import 'package:gamapath/model/UserModel.dart';

import '../../model/PracticeModel.dart';
import '../../repositories/categories_repository.dart';
import '../../repositories/practice_repository.dart';
import '../../repositories/user_repository.dart';

class PraticesBloc extends Bloc<PraticesEvent, PraticesState>{
  final PracticeRepository _practiceRepository = PracticeRepository();

  @override
  PraticesState get initialState => const PraticesInitial();

  @override
  Stream<PraticesState> mapEventToState(
      PraticesEvent event
      ) async*{
    if(event is GetPratices){
      try{
        yield PraticesLoading();

        List<PracticeItem> _practice = await _practiceRepository.getPractice();
        yield PraticesLoaded(practice: _practice);

      }catch(error){
        yield const PraticesFailure(error: "error");
      }
    }
  }
}