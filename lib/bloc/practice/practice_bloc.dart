import 'package:bloc/bloc.dart';
import 'package:gamapath/bloc/practice/practice_event.dart';
import 'package:gamapath/bloc/practice/practice_state.dart';
import 'package:gamapath/model/PracticeModel.dart';
import 'package:gamapath/repositories/practice_repository.dart';

class PracticeBloc extends Bloc<PracticeEvent, PracticeState>{
  final PracticeRepository _practiceRepository = PracticeRepository();

  @override
  PracticeState get initialState => const PracticeInitial();

  @override
  Stream<PracticeState> mapEventToState(
      PracticeEvent event
      ) async*{
    if(event is GetPractice){
      try{
        yield PracticeLoading();
        List<PracticeItem> _practice = await _practiceRepository.getPractice();
        yield PracticeLoaded(practice: _practice);
      }catch(error){
        yield const PracticeFailure(error: "error");
      }
    }
  }
}