import 'package:bloc/bloc.dart';
import 'package:gamapath/bloc/posttest/posttest_event.dart';
import 'package:gamapath/bloc/posttest/posttest_state.dart';

import '../../model/QuestionModel.dart';
import '../../repositories/posttest_repository.dart';

class PosttestBloc extends Bloc<PosttestEvent, PosttestState>{
  final PosttestRepository _posttestRepository = PosttestRepository();

  @override
  PosttestState get initialState => const PosttestInitial();

  @override
  Stream<PosttestState> mapEventToState(
      PosttestEvent event
      ) async*{
    if(event is GetQuestion){
      try{
        yield PosttestLoading();

        List<QuestionItem> _posttest = await _posttestRepository.getPosttest(event.praticesId);

        _posttest.sort((a, b) => a.number.compareTo(b.number));

        int _sub = _posttest.length - 1;
        int _index = _posttest.length - _sub;
        int _nextSub = _sub - 1;


        for(var element in _posttest){
          if(element.number.toString() == _index.toString()){
            yield PosttestLoaded(question: element, sub: _nextSub);
          }
        }

      }catch(error){
        yield const PosttestFailure(error: "error");
      }
    }
    else if(event is NextQuestionButtonPressed){
      try{
        yield PosttestLoading();

        List<QuestionItem> _posttest = await _posttestRepository.getPosttest(event.praticesId);

        int _sub = event.sub;

        if(_sub > 0){
          int _index = _posttest.length - _sub;

          int _nextSub = _sub - 1;

          for(var element in _posttest){
            if(element.number.toString() == _index.toString()){
              bool? success = await _posttestRepository.answerPosttest(event.answer, event.number, event.praticesId);
              if(success == true){
                yield PosttestLoaded(question: element, sub: _nextSub);
              }

            }
          }

        }else{
          int _index = _posttest.length;

          for(var element in _posttest){
            if(element.number.toString() == _index.toString()){
              bool? success = await _posttestRepository.answerPosttest(event.answer, event.number, event.praticesId);
              if(success == true){
                yield LastQuestionLoaded(question: element);
              }
            }
          }
        }

      }
      catch(error){
        yield const PosttestFailure(error: "error");
      }
    }
    else if(event is LastQuestionButtonPressed){
      try{
        yield PosttestLoading();

        bool? success = await _posttestRepository.answerPosttest(event.answer, event.number, event.praticesId);
        int? _point = await _posttestRepository.finishPosttest(event.praticesId);

        if(success == true && _point != null){
          yield FinishQuestionLoaded(point: _point);
        }

      }catch(error){
        yield const PosttestFailure(error: "error");
      }
    }
  }
}