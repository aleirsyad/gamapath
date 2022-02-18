import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gamapath/bloc/practice/practice_bloc.dart';
import 'package:gamapath/bloc/practice/practice_event.dart';
import 'package:gamapath/bloc/practice/practice_state.dart';
import 'package:gamapath/bloc/user/user_bloc.dart';
import 'package:gamapath/bloc/user/user_event.dart';
import 'package:gamapath/bloc/user/user_state.dart';
import 'package:gamapath/model/PracticeModel.dart';
import 'package:gamapath/model/UserModel.dart';
import 'package:gamapath/styles/theme.dart' as Style;

class MainScreen extends StatefulWidget{
  const MainScreen({Key? key}): super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen>{
  final PracticeBloc _practiceBloc = PracticeBloc();
  final UserBloc _userBloc = UserBloc();

  @override
  void initState(){
    _userBloc.add(GetUser());
    _practiceBloc.add(GetPractice());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        body: _buildUser()
        // _buildPractice(),
        // SafeArea(
        //   child: SingleChildScrollView(
        //   padding: EdgeInsets.fromLTRB(24.0, 40.0, 24.0, 0),
        //   child: Column(
        //     crossAxisAlignment: CrossAxisAlignment.start,
        //     children: [
        //       Column(
        //         crossAxisAlignment: CrossAxisAlignment.start,
        //         children: [
        //           Text(
        //             'HAI, GAMAPATH',
        //             style: TextStyle(
        //             fontSize: 24,
        //             fontWeight: FontWeight.w700,
        //             ).copyWith(color: Style.Colors.secondBlack),
        //           ),
        //         ],
        //       ),
        //
        //     ],
        //     ),
        //   )
        // ),
    );
  }

  Widget _buildUser(){
    return Container(
      margin: EdgeInsets.all(8.0),
      child: Column(
        children: [
          BlocProvider(
              create: (_) => _userBloc,
              child: BlocListener<UserBloc, UserState>(
                listener: (context, state){
                  if(state is UserFailure){
                    Scaffold.of(context).showSnackBar(
                      SnackBar(content: Text(state.error)),
                    );
                  }
                },
                child: BlocBuilder<UserBloc, UserState>(
                  builder: (context, state){
                    if(state is UserInitial){
                      return _buildLoading();
                    }else if(state is UserLoading) {
                      return _buildLoading();
                    }else if(state is UserLoaded){
                      return _buildUserLoaded(context, state.user);
                    }else if(state is UserFailure){
                      return Container();
                    }
                    return Container();
                  },
                ),
              )
          ),
          BlocProvider(
              create: (_) => _practiceBloc,
              child: BlocListener<PracticeBloc, PracticeState>(
                listener: (context, state){
                  if(state is PracticeFailure){
                    Scaffold.of(context).showSnackBar(
                      SnackBar(content: Text(state.error)),
                    );
                  }
                },
                child: BlocBuilder<PracticeBloc, PracticeState>(
                  builder: (context, state){
                    if(state is PracticeInitial){
                      return _buildLoading();
                    }else if(state is PracticeLoading) {
                      return _buildLoading();
                    }else if(state is PracticeLoaded){
                      return _buildPracticeLoaded(context, state.practice);
                    }else if(state is PracticeFailure){
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

  Widget _buildUserLoaded(
      BuildContext context, User user){
    return Container(
      margin: EdgeInsets.all(8.0),
      child: Card(
        child: Container(
          margin:  EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              Text("Hai ${user.name}",
                style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600),)
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPractice(){
    return Container(
      margin: EdgeInsets.all(8.0),
      child: BlocProvider(
        create: (_) => _practiceBloc,
        child: BlocListener<PracticeBloc, PracticeState>(
          listener: (context, state){
            if(state is PracticeFailure){
              Scaffold.of(context).showSnackBar(
                SnackBar(content: Text(state.error)),
              );
            }
          },
          child: BlocBuilder<PracticeBloc, PracticeState>(
            builder: (context, state){
              if(state is PracticeInitial){
                return _buildLoading();
              }else if(state is PracticeLoading) {
                return _buildLoading();
              }else if(state is PracticeLoaded){
                return _buildPracticeLoaded(context, state.practice);
              }else if(state is PracticeFailure){
                return Container();
              }
              return Container();
            },
          ),
        )
      ),
    );
  }

  Widget _buildPracticeLoaded(
      BuildContext context, List<PracticeItem> practiceModel){
    return ListView.builder(itemCount: practiceModel.length,itemBuilder: (context, index){
      return Container(
        margin: EdgeInsets.all(8.0),
        child: Card(
          child: Container(
            margin:  EdgeInsets.all(8.0),
            child: Column(
              children: <Widget>[
                Text(practiceModel[index].name)
              ],
            ),
          ),
        ),
      );
    });
  }

  Widget _buildLoading() => Center(child: CircularProgressIndicator());
}