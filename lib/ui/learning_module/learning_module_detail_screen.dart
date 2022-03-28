import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gamapath/bloc/learning_module/learning_module_bloc.dart';
import 'package:gamapath/bloc/learning_module/learning_module_event.dart';
import 'package:gamapath/model/LearningModuleDetailModel.dart';
import 'package:gamapath/styles/theme.dart' as Style;
import 'package:gamapath/ui/learning_module/quiz/quiz_screen.dart';

import '../../bloc/learning_module/learning_module_detail/learning_module_detail_bloc.dart';
import '../../bloc/learning_module/learning_module_detail/learning_module_detail_event.dart';
import '../../bloc/learning_module/learning_module_detail/learning_module_detail_state.dart';
import '../../bloc/learning_module/learning_module_state.dart';
import '../../model/LearningModuleModel.dart';
import 'learning_module_cases_screen.dart';

class LearningModuleDetailScreen extends StatefulWidget{
  final String learningModuleName;
  final String learningModuleId;
  const LearningModuleDetailScreen({Key? key, required this.learningModuleName, required this.learningModuleId}): super(key: key);

  @override
  _LearningModuleDetailScreenState createState() => _LearningModuleDetailScreenState();
}

class _LearningModuleDetailScreenState extends State<LearningModuleDetailScreen>{
  final LearningModuleDetailBloc _learningModuleDetailBloc = LearningModuleDetailBloc();

  @override
  void initState(){
    _learningModuleDetailBloc.add(GetLearningModuleDetail(learningModuleId: widget.learningModuleId));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Style.Colors.mainColor,
        title: Text(widget.learningModuleName),
      ),
      body: _buildLearningModuleDetail(),
    );
  }

  Widget _buildLearningModuleDetail(){
    return Container(
      margin: EdgeInsets.all(8.0),
      child: Column(
        children: [
          BlocProvider(
            create: (_) => _learningModuleDetailBloc,
            child: BlocListener<LearningModuleDetailBloc, LearningModuleDetailState>(
              listener: (context, state) {
                if(state is LearningModuleDetailFailure){
                  Scaffold.of(context).showSnackBar(
                    SnackBar(content: Text(state.error)),
                  );
                }
              },
              child: BlocBuilder<LearningModuleDetailBloc, LearningModuleDetailState>(
                builder: (context, state){
                  if(state is LearningModuleInitial){
                    return _buildLoading();
                  }else if(state is LearningModuleDetailLoading){
                    return _buildLoading();
                  }else if(state is LearningModuleDetailLoaded){
                    return _buildLearningModuleDetailLoaded(context, state.cases);
                  }else if(state is LearningModuleDetailFailure){
                    return Container();
                  }
                  return Container();
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLearningModuleDetailLoaded(BuildContext context, List<CasesItem> cases){
    return Expanded(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(8.0),
                width: double.infinity,
                height: 450,
                child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: cases.length,
                    itemBuilder: (context, index){
                      return GestureDetector(
                        child: Container(
                          child: Card(
                            child: Container(
                              margin:  EdgeInsets.all(16.0),
                              child: Column(
                                children: <Widget>[
                                  Text(cases[index].name)
                                ],
                              ),
                            ),
                          ),
                        ),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LearningModuleCasesScreen(
                                    casesName: cases[index].name,
                                    learningModuleId: widget.learningModuleId.toString(),
                                    casesId: cases[index].id.toString(),
                                  )
                              )
                          );
                        },
                      );
                    }),
              ),
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
                      onPressed: (){
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>QuizScreen(
                                  praticesId: '21',
                                )
                            )
                        );
                      },
                      child: Center(
                        child: Text(
                          "Quiz",
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
              )
            ],
          )
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