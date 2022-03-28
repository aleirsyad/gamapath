import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:gamapath/bloc/posttest/posttest_bloc.dart';
import 'package:gamapath/bloc/posttest/posttest_event.dart';
import 'package:gamapath/styles/theme.dart' as Style;

import '../../../bloc/posttest/posttest_state.dart';
import '../../../model/QuestionModel.dart';


class PosttestScreen extends StatefulWidget{
  final String praticesId;
  const PosttestScreen({Key? key, required this.praticesId}): super(key: key);

  @override
  _PosttestScreenState createState() => _PosttestScreenState();
}

class _PosttestScreenState extends State<PosttestScreen>{
  final PosttestBloc _posttestBloc = PosttestBloc();

  @override
  void initState(){
    _posttestBloc.add(GetQuestion(praticesId: widget.praticesId));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar:
      AppBar(
        backgroundColor: Style.Colors.mainColor,
        title: Text("Post-Test"),
      ),
      body: _buildPosttest(),
    );
  }


  Widget _buildPosttest(){
    return Container(
      margin: EdgeInsets.all(8.0),
      child: Column(
        children: [
          BlocProvider(create: (_) => _posttestBloc,
          child: BlocListener<PosttestBloc, PosttestState>(
            listener: (context, state){
              if(state is PosttestFailure){
                Scaffold.of(context).showSnackBar(
                  SnackBar(content: Text(state.error)),
                );
              }
            },
            child: BlocBuilder<PosttestBloc, PosttestState>(
              builder: (context, state){
                if(state is PosttestInitial){
                  return _buildLoading();
                }else if(state is PosttestLoading){
                  return _buildLoading();
                }else if(state is PosttestLoaded){
                  return _buildPosttestLoaded(context, state.question, state.sub);
                }
                else if(state is LastQuestionLoaded){
                  return _buildLastQuestionLoaded(context, state.question);
                }
                else if(state is FinishQuestionLoaded){
                  return _buildFinishQuestionLoaded(context, state.point);
                }
                else if(state is PosttestFailure){
                  return Container();
                }
                return Container();
              }
            ))
          )
        ],
      ),
    );
  }

  void onNextQuestionButtonPressed(BuildContext context, String _praticesId, int _sub, String _answer, String _number){
    BlocProvider.of<PosttestBloc>(context).add(
        NextQuestionButtonPressed(praticesId: widget.praticesId , sub: _sub, answer: _answer,number: _number)
    );
  }

  void onLastQuestionButtonPressed(BuildContext context, String _praticesId, String _answer, String _number){
    BlocProvider.of<PosttestBloc>(context).add(
        LastQuestionButtonPressed(praticesId: widget.praticesId, answer: _answer, number:_number)
    );
  }

  Widget _buildPosttestLoaded(BuildContext context, QuestionItem question, int _sub){

    return Container(
        margin: EdgeInsets.all(8.0),
          child: Column(
            children: [
              Container(
                  margin: EdgeInsets.all(8.0),
                  child:
                  Row(
                    children: [
                      Text(question.number.toString() + ". "),
                      Expanded(
                          child: Container(
                            margin: EdgeInsets.all(8.0),
                            child: Html(data: question.question),
                          )
                      )
                    ],
                  )
              ),
              Container(
                height: 56,
                margin: EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Style.Colors.fourthColor,
                  borderRadius: BorderRadius.circular(14.0),),
                child: Material(
                  color: Colors.transparent,
                  child:  RaisedButton(
                    color: Style.Colors.fourthColor,
                    disabledColor: Style.Colors.textWhiteGrey,
                    disabledTextColor: Style.Colors.textGrey,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14.0)),
                    onPressed: (){onNextQuestionButtonPressed(context, widget.praticesId, _sub, "A", question.number.toString());},
                    child: Center(
                      child: Html(data: question.optionA)
                    ),
                  ),
                ),
              ),
              Container(
                height: 56,
                margin: EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Style.Colors.fourthColor,
                  borderRadius: BorderRadius.circular(14.0),),
                child: Material(
                  color: Colors.transparent,
                  child:  RaisedButton(
                    color: Style.Colors.fourthColor,
                    disabledColor: Style.Colors.textWhiteGrey,
                    disabledTextColor: Style.Colors.textGrey,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14.0)),
                    onPressed: (){onNextQuestionButtonPressed(context, widget.praticesId, _sub, "B", question.number.toString());},
                    child: Center(
                      child:Html(data: question.optionB)
                    ),
                  ),
                ),
              ),
              Container(
                height: 56,
                margin: EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Style.Colors.fourthColor,
                  borderRadius: BorderRadius.circular(14.0),),
                child: Material(
                  color: Colors.transparent,
                  child:  RaisedButton(
                    color: Style.Colors.fourthColor,
                    disabledColor: Style.Colors.textWhiteGrey,
                    disabledTextColor: Style.Colors.textGrey,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14.0)),
                    onPressed: (){onNextQuestionButtonPressed(context, widget.praticesId, _sub, "C", question.number.toString());},
                    child: Center(
                      child: Html(data: question.optionC)
                    ),
                  ),
                ),
              ),
              Container(
                height: 56,
                margin: EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Style.Colors.fourthColor,
                  borderRadius: BorderRadius.circular(14.0),),
                child: Material(
                  color: Colors.transparent,
                  child:  RaisedButton(
                    color: Style.Colors.fourthColor,
                    disabledColor: Style.Colors.textWhiteGrey,
                    disabledTextColor: Style.Colors.textGrey,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14.0)),
                    onPressed: (){onNextQuestionButtonPressed(context, widget.praticesId, _sub, "D", question.number.toString());},
                    child: Center(
                      child: Html(data: question.optionD)
                    ),
                  ),
                ),
              ),
              Container(
                height: 56,
                margin: EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Style.Colors.fourthColor,
                  borderRadius: BorderRadius.circular(14.0),),
                child: Material(
                  color: Colors.transparent,
                  child:  RaisedButton(
                    color: Style.Colors.fourthColor,
                    disabledColor: Style.Colors.textWhiteGrey,
                    disabledTextColor: Style.Colors.textGrey,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14.0)),
                    onPressed: (){onNextQuestionButtonPressed(context, widget.praticesId, _sub, "E", question.number.toString());},
                    child: Center(
                      child:
                      Html(data: question.optionE.toString())
                    ),
                  ),
                ),
              )
            ],
          )
        );
  }

  Widget _buildLastQuestionLoaded(BuildContext context, QuestionItem question){
    return Container(
      margin: EdgeInsets.all(8.0),
      child: Column(
        children: [
          Container(
              margin: EdgeInsets.all(8.0),
              child:
              Row(
                children: [
                  Text(question.number.toString() + ". "),
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.all(8.0),
                      child: Html(data: question.question),
                    )
                  )
                ],
              )
          ),
          Container(
            height: 56,
            margin: EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Style.Colors.fourthColor,
              borderRadius: BorderRadius.circular(14.0),),
            child: Material(
              color: Colors.transparent,
              child:  RaisedButton(
                color: Style.Colors.fourthColor,
                disabledColor: Style.Colors.textWhiteGrey,
                disabledTextColor: Style.Colors.textGrey,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14.0)),
                onPressed:(){onLastQuestionButtonPressed(context, widget.praticesId, "A", question.number.toString());},
                child: Center(
                  child: Html(data: question.optionA)
                ),
              ),
            ),
          ),
          Container(
            height: 56,
            margin: EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Style.Colors.fourthColor,
              borderRadius: BorderRadius.circular(14.0),),
            child: Material(
              color: Colors.transparent,
              child:  RaisedButton(
                color: Style.Colors.fourthColor,
                disabledColor: Style.Colors.textWhiteGrey,
                disabledTextColor: Style.Colors.textGrey,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14.0)),
                onPressed:(){onLastQuestionButtonPressed(context, widget.praticesId, "B", question.number.toString());},
                child: Center(
                  child: Html(data: question.optionB)
                ),
              ),
            ),
          ),
          Container(
            height: 56,
            margin: EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Style.Colors.fourthColor,
              borderRadius: BorderRadius.circular(14.0),),
            child: Material(
              color: Colors.transparent,
              child:  RaisedButton(
                color: Style.Colors.fourthColor,
                disabledColor: Style.Colors.textWhiteGrey,
                disabledTextColor: Style.Colors.textGrey,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14.0)),
                onPressed:(){onLastQuestionButtonPressed(context, widget.praticesId, "C", question.number.toString());},
                child: 
                Center(
                  child: 
                    Html(data: question.optionC)
                ),
              ),
            ),
          ),
          Container(
            height: 56,
            margin: EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Style.Colors.fourthColor,
              borderRadius: BorderRadius.circular(14.0),),
            child: Material(
              color: Colors.transparent,
              child:  RaisedButton(
                color: Style.Colors.fourthColor,
                disabledColor: Style.Colors.textWhiteGrey,
                disabledTextColor: Style.Colors.textGrey,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14.0)),
                onPressed:(){onLastQuestionButtonPressed(context, widget.praticesId, "D", question.number.toString());},
                child: Center(
                  child:
                  Html(data: question.optionD)
                ),
              ),
            ),
          ),
          Container(
            height: 56,
            margin: EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Style.Colors.fourthColor,
              borderRadius: BorderRadius.circular(14.0),),
            child: Material(
              color: Colors.transparent,
              child:  RaisedButton(
                color: Style.Colors.fourthColor,
                disabledColor: Style.Colors.textWhiteGrey,
                disabledTextColor: Style.Colors.textGrey,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14.0)),
                onPressed:(){onLastQuestionButtonPressed(context, widget.praticesId, "E", question.number.toString());},
                child: Center(
                  child: Html(data: question.optionE)
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildFinishQuestionLoaded(BuildContext context, int _point){
    return Container(
      margin: EdgeInsets.all(8.0),
      child: Column(
        children: [
          Text("Skor Post-Test Anda :"+_point.toString()),
          Container(
            height: 56,
            margin: EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Style.Colors.mainColor,
              borderRadius: BorderRadius.circular(14.0),),
            child: Material(
              color: Colors.transparent,
              child:  RaisedButton(
                color: Style.Colors.mainColor,
                disabledColor: Style.Colors.textWhiteGrey,
                disabledTextColor: Style.Colors.textGrey,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14.0)),
                onPressed: (){ Navigator.pop(context);},
                child: Center(
                  child: Text(
                    "Selesai",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600)
                        .copyWith(
                        color:
                        Style.Colors.colorWhite),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLoading() {
    return Center(
        child: Container(
          padding: EdgeInsets.only(top: 160.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children:  [
              CircularProgressIndicator()
            ],
          ),
        )
    );
  }
}