import 'package:bloc/bloc.dart';
import 'package:gamapath/bloc/quiz/quiz_event.dart';
import 'package:gamapath/bloc/quiz/quiz_state.dart';

import '../../model/QuestionModel.dart';
import '../../repositories/quiz_repository.dart';

class QuizBloc extends Bloc<QuizEvent, QuizState>{
  final QuizRepository _quizRepository = QuizRepository();

  @override
  QuizState get initialState => const QuizInitial();

  @override
  Stream<QuizState> mapEventToState(
      QuizEvent event
      ) async*{
    if(event is GetQuestion){
      try{
        yield QuizLoading();

        List<QuestionItem> _quiz = await _quizRepository.getQuiz(event.praticesId);

        _quiz.sort((a, b) => a.number.compareTo(b.number));

        int _sub = _quiz.length - 1;
        int _index = _quiz.length - _sub;
        int _nextSub = _sub - 1;


        for(var element in _quiz){
          if(element.number.toString() == _index.toString()){
            yield QuizLoaded(question: element, sub: _nextSub);
          }
        }

      }catch(error){
        yield const QuizFailure(error: "error");
      }
    }
    else if(event is NextQuestionButtonPressed){
      try{
        yield QuizLoading();

        List<QuestionItem> _quiz = await _quizRepository.getQuiz(event.praticesId);

        int _sub = event.sub;

        if(_sub > 0){
          int _index = _quiz.length - _sub;

          int _nextSub = _sub - 1;

          for(var element in _quiz){
            if(element.number.toString() == _index.toString()){
              bool? success = await _quizRepository.answerQuiz(event.answer, event.number, event.praticesId);
              if(success == true){
                yield QuizLoaded(question: element, sub: _nextSub);
              }

            }
          }

        }else{
          int _index = _quiz.length;

          for(var element in _quiz){
            if(element.number.toString() == _index.toString()){
              bool? success = await _quizRepository.answerQuiz(event.answer, event.number, event.praticesId);
              if(success == true){
                yield LastQuestionLoaded(question: element);
              }
            }
          }
        }

      }
      catch(error){
        yield const QuizFailure(error: "error");
      }
    }
    else if(event is LastQuestionButtonPressed){
      try{
        yield QuizLoading();

        bool? success = await _quizRepository.answerQuiz(event.answer, event.number, event.praticesId);
        int? _point = await _quizRepository.finishQuiz(event.praticesId);

        if(success == true && _point != null){
          yield FinishQuestionLoaded(point: _point);
        }

      }catch(error){
        yield const QuizFailure(error: "error");
      }
    }
  }
}