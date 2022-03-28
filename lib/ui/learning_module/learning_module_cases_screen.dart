import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gamapath/bloc/learning_module/learning_module_cases/learning_module_cases_event.dart';
import 'package:gamapath/styles/theme.dart' as Style;

import '../../bloc/learning_module/learning_module_cases/learning_module_cases_bloc.dart';
import '../../bloc/learning_module/learning_module_cases/learning_module_cases_state.dart';
import '../../model/LearningModuleDetailModel.dart';

class LearningModuleCasesScreen extends StatefulWidget{
  final String casesName;
  final String learningModuleId;
  final String casesId;

  const LearningModuleCasesScreen({Key? key, required this.casesName, required this.learningModuleId, required this.casesId}): super(key: key);

  @override
  _LearningModuleCasesScreenState createState() => _LearningModuleCasesScreenState();

}

class _LearningModuleCasesScreenState extends State<LearningModuleCasesScreen>{
  final LearningModuleCasesBloc _learningModuleCasesBloc = LearningModuleCasesBloc();

  @override
  void initState(){
    _learningModuleCasesBloc.add(GetLearningModuleCases(learningModuleId: widget.learningModuleId, casesId: widget.casesId));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Style.Colors.mainColor,
        title: Text(widget.casesName),
      ),
      body: _buildLearningModuleCases(),
    );
  }

  Widget _buildLearningModuleCases(){
    return Container(
      margin: EdgeInsets.all(8.0),
      child: Column(
        children: [
          BlocProvider(
            create: (_) => _learningModuleCasesBloc,
            child: BlocListener<LearningModuleCasesBloc, LearningModuleCasesState>(
              listener: (context, state) {
                if(state is LearningModuleCasesFailure){
                  Scaffold.of(context).showSnackBar(
                    SnackBar(content: Text(state.error)),
                  );
                }
              },
              child: BlocBuilder<LearningModuleCasesBloc, LearningModuleCasesState>(
                builder: (context, state){
                  if(state is LearningModuleCasesInitial){
                    return _buildLoading();
                  }else if(state is LearningModuleCasesLoading){
                    return _buildLoading();
                  }else if(state is LearningModuleCasesLoaded){
                    return _buildLearningModuleCasesLoaded(context, state.modules);
                  }else if(state is LearningModuleCasesFailure){
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

  Widget _buildLearningModuleCasesLoaded(BuildContext context, List<ModulesItem> modules) {
    return Expanded(
        child: Container(
          padding: EdgeInsets.all(8.0),
          width: double.infinity,
          height: 400,
          child: ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: modules.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  child: Container(
                    child: Card(
                      child: Container(
                        margin: EdgeInsets.all(16.0),
                        child: Column(
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.all(8.0),
                              child: Column(
                                children: <Widget>[
                                  Image.network(modules[index].file, fit: BoxFit.cover,)
                                ],
                              ),
                            ),
                            Text("Annotations: ",textAlign: TextAlign.left, style: TextStyle(fontWeight: FontWeight.bold),),
                            Container(
                              margin:  EdgeInsets.all(8.0),
                              child: Column(
                                children: <Widget>[
                                ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: modules[index].annotations.length,
                                    itemBuilder: (context, index2) {
                                      return Container(
                                        child: Card(
                                          child: Container(
                                            margin: EdgeInsets.all(16.0),
                                            child: Column(
                                              children: <Widget>[
                                                Text(modules[index].annotations[index2].description.toString())
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                  }),
                                ],
                              )
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  onTap: () {
                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (context) => LearningModuleScreen(
                    //             categoriesId: practiceModel[index].id.toString()
                    //         )
                    //     )
                    // );
                  },
                );
              }),
        ));
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