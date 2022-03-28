import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gamapath/bloc/learning_module/learning_module_bloc.dart';
import 'package:gamapath/bloc/learning_module/learning_module_event.dart';
import 'package:gamapath/styles/theme.dart' as Style;

import '../../bloc/learning_module/learning_module_state.dart';
import '../../model/LearningModuleModel.dart';
import 'learning_module_detail_screen.dart';

class LearningModuleScreen extends StatefulWidget{
  final String categoriesName;
  final String categoriesId;
  const LearningModuleScreen({Key? key, required this.categoriesName, required this.categoriesId}): super(key: key);

  @override
  _LearningModuleScreenState createState() => _LearningModuleScreenState();
}

class _LearningModuleScreenState extends State<LearningModuleScreen>{
  final LearningModuleBloc _learningModuleBloc = LearningModuleBloc();

  @override
  void initState(){
    _learningModuleBloc.add(GetLearningModule(categoriesId: widget.categoriesId));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
      AppBar(
        backgroundColor: Style.Colors.mainColor,
        title: Text(widget.categoriesName),
      ),
      body: _buildLearningModule(),
    );
  }

  Widget _buildLearningModule(){
    return Container(
      margin: EdgeInsets.all(8.0),
      child: Column(
        children: [
          // Container(
          //   child: Card(
          //     shape: RoundedRectangleBorder(
          //       borderRadius: BorderRadius.circular(14.0),
          //     ),
          //     clipBehavior: Clip.antiAliasWithSaveLayer,
          //     color: Style.Colors.colorWhite,
          //     child: Padding(
          //       padding: EdgeInsetsDirectional.fromSTEB(14, 14, 14, 14),
          //       child: Column(
          //         mainAxisSize: MainAxisSize.max,
          //         children: [
          //           Align(
          //             alignment: AlignmentDirectional(-1, -1),
          //             child: Text(
          //               'Cari Bus',
          //               style: TextStyle(
          //                   fontSize: 14, fontWeight: FontWeight.w600),
          //             ),
          //           ),
          //           SizedBox(
          //             height: 20,
          //           ),
          //           Column(
          //             children: [
          //               Container(
          //                 height: 56,
          //                 width: double.infinity,
          //                 padding: const EdgeInsets.all(20.0),
          //                 decoration: BoxDecoration(
          //                   color: Style.Colors.textWhiteGrey,
          //                   borderRadius: BorderRadius.circular(14.0),
          //                 ),
          //                 child: DropdownButtonHideUnderline(
          //                   child: DropdownButton(
          //                     hint: Text("Dari"),
          //                     value: _start,
          //                     items: _shuttle.map((value) {
          //                       return DropdownMenuItem(
          //                           child: Text(value), value: value);
          //                     }).toList(),
          //                     onChanged: (value) {
          //                       setState(() {
          //                         _start = value;
          //                       });
          //                     },
          //                   ),
          //                 ),
          //               ),
          //             ],
          //           ),
          //           SizedBox(
          //             height: 10,
          //           ),
          //           Column(
          //             children: [
          //               Container(
          //                   height: 56,
          //                   width: double.infinity,
          //                   padding: const EdgeInsets.all(20.0),
          //                   decoration: BoxDecoration(
          //                     color: Style.Colors.textWhiteGrey,
          //                     borderRadius: BorderRadius.circular(14.0),
          //                   ),
          //                   child: DropdownButtonHideUnderline(
          //                     child: DropdownButton(
          //                       hint: Text("Tujuan"),
          //                       value: _destination,
          //                       items: _shuttle.map((value) {
          //                         return DropdownMenuItem(
          //                             child: Text(value), value: value);
          //                       }).toList(),
          //                       onChanged: (value) {
          //                         setState(() {
          //                           _destination = value;
          //                         });
          //                       },
          //                     ),
          //                   )),
          //             ],
          //           ),
          //           SizedBox(
          //             height: 10,
          //           ),
          //           Material(
          //             borderRadius: BorderRadius.circular(14.0),
          //             elevation: 0,
          //             child: Container(
          //               height: 56,
          //               decoration: BoxDecoration(
          //                 color: Style.Colors.mainColor,
          //                 borderRadius: BorderRadius.circular(14.0),
          //               ),
          //               child: Material(
          //                 color: Colors.transparent,
          //                 child: RaisedButton(
          //                   color: Style.Colors.mainColor,
          //                   disabledColor: Style.Colors.textWhiteGrey,
          //                   disabledTextColor: Style.Colors.textGrey,
          //                   shape: RoundedRectangleBorder(
          //                       borderRadius: BorderRadius.circular(14.0)),
          //                   onPressed: () {
          //                     Navigator.of(context)
          //                         .pushReplacement(MaterialPageRoute(
          //                       builder: (context) => ShuttleFilterScreen(
          //                         start: _start,
          //                         destination: _destination,
          //                       ),
          //                     ));
          //                   },
          //                   child: Center(
          //                     child: Text(
          //                       "Cari Shuttle",
          //                       style: TextStyle(
          //                           fontSize: 18,
          //                           fontWeight: FontWeight.w600)
          //                           .copyWith(
          //                           color: Style.Colors.colorWhite),
          //                     ),
          //                   ),
          //                 ),
          //               ),
          //             ),
          //           )
          //         ],
          //       ),
          //     ),
          //   ),
          //   // decoration: new BoxDecoration(
          //   //   boxShadow: [
          //   //     new BoxShadow(
          //   //       color: Style.Colors.greyBack,
          //   //       blurRadius: 0.0,
          //   //     ),
          //   //   ],
          //   // ),
          // ),
          BlocProvider(
            create: (_) => _learningModuleBloc,
            child: BlocListener<LearningModuleBloc, LearningModuleState>(
              listener: (context, state) {
                if(state is LearningModuleFailure){
                  Scaffold.of(context).showSnackBar(
                    SnackBar(content: Text(state.error)),
                  );
                }
              },
              child: BlocBuilder<LearningModuleBloc, LearningModuleState>(
                builder: (context, state){
                  if(state is LearningModuleInitial){
                    return _buildLoading();
                  }else if(state is LearningModuleLoading){
                    return _buildLoading();
                  }else if(state is LearningModuleLoaded){
                    return _buildLearningModuleLoaded(context, state.learningModule);
                  }else if(state is LearningModuleFailure){
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

  Widget _buildLearningModuleLoaded(BuildContext context, List<LearningModuleItem> learningModulModel){
    return Container(
      margin:  EdgeInsets.all(8.0),
      child: Column(
        children:<Widget> [
          // Align(
          //   alignment: Alignment.centerLeft,
          //   child: Container(
          //     margin:  EdgeInsets.all(8.0),
          //     child: Text("Kategori: " + widget.categoriesName),
          //   ),
          // ),
          ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: learningModulModel.length,
              itemBuilder: (context, index){
                return GestureDetector(
                  child: Container(
                    child: Card(
                      child: Container(
                        margin:  EdgeInsets.all(16.0),
                        child: Column(
                          children: <Widget>[
                            Text(learningModulModel[index].name)
                          ],
                        ),
                      ),
                    ),
                  ),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => LearningModuleDetailScreen(
                              learningModuleName: learningModulModel[index].name,
                              learningModuleId: learningModulModel[index].id.toString(),
                            )
                        )
                    );
                  },
                );
              })
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