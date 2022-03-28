import 'package:bloc/bloc.dart';
import 'package:gamapath/bloc/pretest/pretest_event.dart';
import 'package:gamapath/bloc/pretest/pretest_state.dart';

import '../../model/QuestionModel.dart';
import '../../repositories/pretest_repository.dart';

class PretestBloc extends Bloc<PretestEvent, PretestState>{
  final PretestRepository _pretestRepository = PretestRepository();

  @override
  PretestState get initialState => const PretestInitial();

  @override
  Stream<PretestState> mapEventToState(
      PretestEvent event
      ) async*{
    if(event is GetQuestion){
      try{
        yield PretestLoading();

        List<QuestionItem> _pretest = await _pretestRepository.getPretest(event.praticesId);

        _pretest.sort((a, b) => a.number.compareTo(b.number));

        int _sub = _pretest.length - 1;
        int _index = _pretest.length - _sub;
        int _nextSub = _sub - 1;


        for(var element in _pretest){
          if(element.number.toString() == _index.toString()){
            yield PretestLoaded(question: element, sub: _nextSub);
          }
        }

      }catch(error){
        yield const PretestFailure(error: "error");
      }
    }
    else if(event is NextQuestionButtonPressed){
      try{
        yield PretestLoading();

        List<QuestionItem> _pretest = await _pretestRepository.getPretest(event.praticesId);

        int _sub = event.sub;

        if(_sub > 0){
          int _index = _pretest.length - _sub;

          int _nextSub = _sub - 1;

          for(var element in _pretest){
            if(element.number.toString() == _index.toString()){
              bool? success = await _pretestRepository.answerPretest(event.answer, event.number, event.praticesId);
              if(success == true){
                yield PretestLoaded(question: element, sub: _nextSub);
              }

            }
          }

        }else{
          int _index = _pretest.length;

          for(var element in _pretest){
            if(element.number.toString() == _index.toString()){
              bool? success = await _pretestRepository.answerPretest(event.answer, event.number, event.praticesId);
              if(success == true){
                yield LastQuestionLoaded(question: element);
              }
            }
          }
        }

      }
      catch(error){
        yield const PretestFailure(error: "error");
      }
    }
    else if(event is LastQuestionButtonPressed){
      try{
        yield PretestLoading();

        bool? success = await _pretestRepository.answerPretest(event.answer, event.number, event.praticesId);
        int? _point = await _pretestRepository.finishPretest(event.praticesId);

        if(success == true && _point != null){
          yield FinishQuestionLoaded(point: _point);
        }

      }catch(error){
        yield const PretestFailure(error: "error");
      }
    }
    // else if(event is PreviousQuestionButtonPressed){
    //   try{
    //     yield PretestLoading();
    //
    //     List<QuestionItem> _pretest = await _pretestRepository.getPretest(event.praticesId);
    //
    //     int _amount = event.amount;
    //
    //
    //
    //     if((_amount + 2) < _pretest.length){
    //       int _index = _pretest.length - _amount - 1;
    //
    //       int _nextAmount = _amount + 1;
    //
    //       List<QuestionItem> _questions = [];
    //
    //       for(var element in _pretest){
    //         if(element.number.toString() == _index.toString()){
    //           _questions.addAll(_pretest);
    //         }
    //       }
    //       yield NextQuestionLoaded(pretest: _questions, amount: _nextAmount);
    //     }else{
    //       int _index = _pretest.length - _amount - 1;
    //
    //       List<QuestionItem> _questions = [];
    //       for(var element in _pretest){
    //         if(element.number.toString() == _index.toString()){
    //           _questions.addAll(_pretest);
    //         }
    //       }
    //
    //       int _nextAmount = event.amount;
    //       yield FirstQuestionLoaded(question: _questions, amount: _nextAmount);
    //     }
    //
    //
    //   }
    //   catch(error){
    //     yield const PretestFailure(error: "error");
    //   }
    // }
  }
}