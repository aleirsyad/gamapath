import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gamapath/bloc/home/home_bloc.dart';
import 'package:gamapath/bloc/home/home_event.dart';
import 'package:gamapath/bloc/home/home_state.dart';
import 'package:gamapath/model/PracticeModel.dart';
import 'package:gamapath/model/UserModel.dart';
import 'package:gamapath/styles/theme.dart' as Style;
import 'package:gamapath/ui/learning_module/learning_module_screen.dart';
import 'package:gamapath/ui/practices/all_pratices_screen.dart';
import 'package:gamapath/ui/practices/practices_screen.dart';
import 'package:gamapath/ui/profile/profile_screen.dart';

import '../../model/CategoriesModel.dart';

class MainScreen extends StatefulWidget{
  const MainScreen({Key? key}): super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen>{
  final HomeBloc _homeBloc = HomeBloc();
  TextEditingController _textFieldController = TextEditingController();

  @override
  void initState(){
    _homeBloc.add(GetHome());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        body: _buildHome()
    );
  }

  Widget _buildHome(){
    return Container(
      margin: EdgeInsets.all(8.0),
      child: Column(
        children: [
          BlocProvider(
              create: (_) => _homeBloc,
              child: BlocListener<HomeBloc, HomeState>(
                listener: (context, state){
                  if(state is HomeFailure){
                    Scaffold.of(context).showSnackBar(
                      SnackBar(content: Text(state.error)),
                    );
                  }
                },
                child: BlocBuilder<HomeBloc, HomeState>(
                  builder: (context, state){
                    if(state is HomeInitial){
                      return _buildLoading();
                    }else if(state is HomeLoading) {
                      return _buildLoading();
                    }else if(state is HomeLoaded){
                      return _buildHomeLoaded(context, state.user, state.practice, state.categories);
                    }else if(state is HomeFailure){
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

  Widget _buildHomeLoaded(
      BuildContext context, User user,  List<PracticeItem> practiceModel, List<CategoriesItem> categoriesModel){
    return Expanded(
      // margin: EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(top: 24.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    margin:  EdgeInsets.all(8.0),
                    child: Text("Hai ${user.name}",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 8.0),
                child: Card(
                  child: Container(
                    margin:  EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Column(children: [
                            GestureDetector(
                                child: Container(
                                  margin: EdgeInsets.all(8.0),
                                  child: Column(
                                    children: <Widget>[
                                      Container(
                                          width: 60.0,
                                          height: 60.0,
                                          decoration: new BoxDecoration(
                                              shape: BoxShape.circle,
                                              image: new DecorationImage(
                                                  fit: BoxFit.cover,
                                                  image: new NetworkImage(
                                                      user.profile_photo_url)
                                              )
                                          )),
                                      // Text(user.profile_photo_url),
                                      // Image.network(user.profile_photo_url, fit: BoxFit.cover,)
                                    ],
                                  ),
                                ),
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ProfileScreen()
                                    )
                                );
                              },
                            ),
                          Text("Profil", style: TextStyle(
                              color: Style.Colors.mainColor
                          ),),
                        ],),
                        Column(
                          children: [
                            Container(
                                margin: EdgeInsets.all(8.0),
                                width: 60.0,
                                height: 60.0,
                                child: Center(
                                  child: Text(DateTime.now().day.toString()+"/"+DateTime.now().month.toString()),
                                ),
                                decoration: new BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Style.Colors.fourthColor
                                )),
                            Text("Tanggal", textAlign: TextAlign.center, style: TextStyle(
                                color: Style.Colors.mainColor
                            ),),
                          ],
                        ),
                        Column(
                          children: [
                            GestureDetector(
                              child: Container(
                                margin: EdgeInsets.all(8.0),
                                child: Column(
                                  children: <Widget>[
                                    Container(
                                      padding: EdgeInsets.all(16.0),
                                        width: 60.0,
                                        height: 60.0,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Style.Colors.thirdColor,
                                        ),
                                        child:Container(
                                            decoration: new BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: Style.Colors.thirdColor,
                                                image: new DecorationImage(
                                                  fit: BoxFit.contain,
                                                  image: AssetImage("images/iconsettings.png"),
                                                )
                                            )
                                        ),
                                    ),
                                    // Text(user.profile_photo_url),
                                    // Image.network(user.profile_photo_url, fit: BoxFit.cover,)
                                  ],
                                ),
                              ),
                              onTap: () {
                                // Navigator.push(
                                //     context,
                                //     MaterialPageRoute(
                                //         builder: (context) => ProfileScreen()
                                //     )
                                // );
                              },
                            ),
                            Text("Pengaturan", textAlign: TextAlign.end, style: TextStyle(
                                color: Style.Colors.mainColor
                            ),),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  margin:  EdgeInsets.fromLTRB(8.0, 24.0, 8.0, 8.0 ),
                  child: Text("Kategori",
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ),
              ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: categoriesModel.length,
                  itemBuilder: (context, index){
                    return GestureDetector(
                      child: Container(
                        child: Card(
                          child: Container(
                            margin:  EdgeInsets.all(12.0),
                            child: Column(
                              children: <Widget>[
                                Text(categoriesModel[index].name)
                              ],
                            ),
                          ),
                        ),
                      ),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LearningModuleScreen(
                                    categoriesName: categoriesModel[index].name,
                                    categoriesId: categoriesModel[index].id.toString()
                                )
                            )
                        );
                      },
                    );
                  }),
              Container(
                margin:  EdgeInsets.fromLTRB(8.0, 24.0, 8.0, 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text("Pre - Post Test",
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600),),
                    GestureDetector(
                      child:  Text("Lihat Semua", textAlign: TextAlign.end, style: TextStyle(
                          color: Style.Colors.mainColor
                      ),),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AllPraticesScreen()
                            )
                        );
                      },
                    )

                  ],
                ),
              ),
              Expanded(
                  child: Container(
                      width: double.infinity,
                      height: 300,
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
                                // Navigator.push(
                                //     context,
                                //     MaterialPageRoute(
                                //         builder: (context) => LearningModuleScreen(
                                //             categoriesName: practiceModel[index].name,
                                //             categoriesId: practiceModel[index].id.toString()
                                //         )
                                //     )
                                // );
                              },
                            );
                          })
                  )
              )

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

  Future<void> _displayTextInputDialog(BuildContext context,  List<PracticeItem> practiceModel, int index) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Enroll Code'),
            content: TextField(
              // onChanged: (value) {
              //   setState(() {
              //     value = "";
              //   });
              // },
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
}