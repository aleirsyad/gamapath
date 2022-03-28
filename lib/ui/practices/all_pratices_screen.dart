import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gamapath/ui/practices/practices_screen.dart';

import '../../bloc/pratices/pratices_bloc.dart';
import '../../bloc/pratices/pratices_event.dart';
import 'package:gamapath/styles/theme.dart' as Style;

import '../../bloc/pratices/pratices_state.dart';
import '../../model/PracticeModel.dart';

class AllPraticesScreen extends StatefulWidget{
  const AllPraticesScreen({Key? key}): super(key: key);

  @override
  _AllPraticesScreenState createState() => _AllPraticesScreenState();
}

class _AllPraticesScreenState extends State<AllPraticesScreen> {
  final PraticesBloc _praticesBloc = PraticesBloc();
  TextEditingController _textFieldController = TextEditingController();

  @override
  void initState() {
    _praticesBloc.add(GetPratices());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar:
      AppBar(
        backgroundColor: Style.Colors.mainColor,
        title: Text("Pre-Post Test"),
      ),
      body: _buildAllPratices(),
    );
  }

  Widget _buildAllPratices(){
    return Container(
        margin: EdgeInsets.all(8.0),
        child: Column(
          children: [
            BlocProvider(
                create: (_) => _praticesBloc,
                child: BlocListener<PraticesBloc, PraticesState>(
                  listener: (context, state){
                    if(state is PraticesFailure){
                      Scaffold.of(context).showSnackBar(
                        SnackBar(content: Text(state.error)),
                      );
                    }
                  },
                  child: BlocBuilder<PraticesBloc, PraticesState>(
                    builder: (context, state){
                      if(state is PraticesInitial){
                        return _buildLoading();
                      }else if(state is PraticesLoading) {
                        return _buildLoading();
                      }else if(state is PraticesLoaded){
                        return _buildAllPraticesLoaded(context,state.practice);
                      }else if(state is PraticesFailure){
                        return Container();
                      }
                      return Container();
                    },
                  ),
                )
            ),
          ],
        )
    );
  }

  Future<void> _displayTextInputDialog(BuildContext context,  List<PracticeItem> practiceModel, int index) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Enroll Code'),
            content: TextField(
              controller: _textFieldController,
              decoration: InputDecoration(hintText: "Masukkan Enroll Code"),
            ),
            actions: <Widget>[
              FlatButton(
                color: Colors.red,
                textColor: Colors.white,
                child: Text('CANCEL'),
                onPressed: () {
                  setState(() {
                    Navigator.pop(context);
                  });
                },
              ),
              FlatButton(
                color: Colors.green,
                textColor: Colors.white,
                child: Text('OK'),
                onPressed: () {
                  if(_textFieldController.text == practiceModel[index].enrollCode.toString()){
                    Navigator.pushReplacement(context, MaterialPageRoute(
                        builder: (context) => PracticesScreen(
                          practicesId: practiceModel[index].id.toString(),
                          practicesName: practiceModel[index].name,
                        )
                    ));
                  }
                  else{
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("Enroll code salah!"),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                  _textFieldController.clear();
                  // setState(() {
                  //   // codeDialog = valueText;
                  // });
                },
              ),

            ],
          );
        });
  }

  Widget _buildAllPraticesLoaded(
      BuildContext context, List<PracticeItem> practiceModel) {
    return Expanded(
        child: Container(
            width: double.infinity,
            height: 500,
            child: ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: practiceModel.length,
                itemBuilder: (context, index){
                  return GestureDetector(
                    child: Container(
                      child: Card(
                        child: Container(
                          margin:  EdgeInsets.all(16.0),
                          child: Column(
                            children: <Widget>[
                              Text(practiceModel[index].name)
                            ],
                          ),
                        ),
                      ),
                    ),
                    onTap: () {
                      _displayTextInputDialog(context, practiceModel, index);
                    },
                  );
                })
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