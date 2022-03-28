import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gamapath/main.dart';
import 'package:gamapath/ui/auth/login/login_screen.dart';
import 'package:gamapath/ui/home/home_screen.dart';
import 'package:image_picker/image_picker.dart';

import '../../bloc/profile/profile_bloc.dart';
import '../../bloc/profile/profile_event.dart';
import 'package:gamapath/styles/theme.dart' as Style;

import '../../bloc/profile/profile_state.dart';
import '../../model/UserModel.dart';
import '../../repositories/user_repository.dart';

class ProfileScreen extends StatefulWidget{
  const ProfileScreen({Key? key}): super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final userRepository = UserRepository();
  final ProfileBloc _profileBloc = ProfileBloc();
  TextEditingController _textFieldController = TextEditingController();
  var _usernameController = TextEditingController();
  var _emailController = TextEditingController();
  final picker = ImagePicker();

  @override
  void initState() {
    _profileBloc.add(GetProfile());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Style.Colors.mainColor,
        title: Text("Profil"),
      ),
      body:  BlocProvider(
      create: (_) => _profileBloc,
      child: BlocListener<ProfileBloc, ProfileState>(
        listener: (context, state){
          if(state is SaveProfileLoaded){
            Navigator.pushAndRemoveUntil(context,MaterialPageRoute(builder: (context) => MainScreen()), (route) => false);
          }
          if(state is LoggedOut){
            Navigator.pushAndRemoveUntil(context,MaterialPageRoute(builder: (context) => LoginScreen(userRepository: userRepository)), (route) => false);
          }
        },
        child: _buildProfile(context),
      ))
    );
  }

  void onPhotoSaved(BuildContext context, File imageSource){
    BlocProvider.of<ProfileBloc>(context).add(
        GetProfilePhotoSaved(photo: imageSource)
    );
  }

  void saveProfile(BuildContext context, String _name, String _email, File _avatar){
    BlocProvider.of<ProfileBloc>(context).add(
        SaveProfileButtonPressed(name: _name, email: _email, avatar: _avatar)
    );
    //Navigator.pushAndRemoveUntil(context,MaterialPageRoute(builder: (context) => MainScreen()), (route) => false);
  }

  void saveProfileNoPhoto(BuildContext context, String _name, String _email){
    BlocProvider.of<ProfileBloc>(context).add(
        SaveProfileNoPhotoButtonPressed(name: _name, email: _email)
    );
    //Navigator.pushAndRemoveUntil(context,MaterialPageRoute(builder: (context) => MainScreen()), (route) => false);
  }

  void logout(BuildContext context){
    BlocProvider.of<ProfileBloc>(context).add(
        LogoutButtonPressed()
    );
    //Navigator.pushAndRemoveUntil(context,MaterialPageRoute(builder: (context) => MainScreen()), (route) => false);
  }

  Widget _buildProfile(BuildContext context){
    return Container(
      margin: EdgeInsets.all(8.0),
      child: Column(
        children: [
          BlocProvider(
            create: (_) => _profileBloc,
            child: BlocListener<ProfileBloc, ProfileState>(
              listener: (context, state) {
                if(state is ProfileFailure){
                  Scaffold.of(context).showSnackBar(
                    SnackBar(content: Text(state.error)),
                  );
                }
              },
              child: BlocBuilder<ProfileBloc, ProfileState>(
                builder: (context, state){
                  if(state is ProfileInitial){
                    return _buildLoading();
                  }else if(state is ProfileLoading){
                    return _buildLoading();
                  }else if(state is ProfileLoaded){
                    return _buildProfileLoaded(context, state.user);
                  }else if(state is SavePhotoLoaded){
                    return _buildProfileWithSavedPhoto(context, state.photo, state.user);
                  } else if(state is ProfileFailure){
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

  Future selectOrTakePhoto(BuildContext context, ImageSource imageSource) async {
    final pickedFile = await picker.getImage(source: imageSource);

    setState(() {
      if (pickedFile != null) {
        var image = File(pickedFile.path);
        onPhotoSaved(context, image);
        //_profileBloc.add(GetProfile());
      } else
        print('No photo was selected or taken');
    });
  }

  Widget _buildProfileLoaded(
      BuildContext context, User user){
    _usernameController.text = user.name;
    _emailController.text = user.email;
    return Expanded(
        child: Column(
            children: <Widget>[
                Container(
                  padding: EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        child:  Container(
                          width: 150.0,
                          height: 180.0,
                          child: Image.network(user.profile_photo_url, fit: BoxFit.cover,),
                          // decoration: new BoxDecoration(
                          //     shape: BoxShape.rectangle,
                          //     image: new DecorationImage(
                          //         fit: BoxFit.fill,
                          //         image: _image == null
                          //             ? Image.network(user.profile_photo_url) : _image
                          //     )
                          // )
                        ),
                        onTap: (){
                          showDialog(
                            context: context,
                            builder: (BuildContext dialogContext){
                              return SimpleDialog(
                                title: Text('Select photo'),
                                children: <Widget>[
                                  SimpleDialogOption(
                                    child: Text('From gallery'),
                                    onPressed: () {
                                      selectOrTakePhoto(context, ImageSource.gallery);
                                      Navigator.pop(dialogContext);
                                    },
                                  ),
                                  SimpleDialogOption(
                                    child: Text('Take a photo'),
                                    onPressed: () {
                                      selectOrTakePhoto(context, ImageSource.camera);
                                      Navigator.pop(dialogContext);
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                        },
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Nama", style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),),
                          SizedBox(
                            height: 8,
                          ),
                          Container(
                            padding: EdgeInsets.fromLTRB(0.0, 8, 8, 8),
                            width: 200.0,
                            decoration: BoxDecoration(
                              color: Style.Colors.textWhiteGrey,
                              borderRadius: BorderRadius.circular(14.0),
                            ),
                            child: TextFormField(
                              keyboardType: TextInputType.emailAddress,
                              controller: _usernameController,
                              decoration: InputDecoration(
                                hintText: 'Nama',
                                hintStyle: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ).copyWith(color: Style.Colors.textGrey),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Text("Email", style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),),
                          SizedBox(
                            height: 8,
                          ),
                          Container(
                            padding: EdgeInsets.fromLTRB(0.0, 8, 8, 8),
                            width: 200.0,
                            decoration: BoxDecoration(
                              color: Style.Colors.textWhiteGrey,
                              borderRadius: BorderRadius.circular(14.0),
                            ),
                            child: TextFormField(
                              keyboardType: TextInputType.emailAddress,
                              controller: _emailController,
                              decoration: InputDecoration(
                                hintText: 'Email',
                                hintStyle: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ).copyWith(color: Style.Colors.textGrey),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
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
                      saveProfileNoPhoto(context, _usernameController.text, _emailController.text);
                    },
                    child: Center(
                      child: Text(
                        "Simpan Perubahan",
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
                      logout(context);
                    },
                    child: Center(
                      child: Text(
                        "Log Out",
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
            ]
        )
    );
  }

  Widget _buildProfileWithSavedPhoto(
      BuildContext context, File photo, User user){
    _usernameController.text = user.name;
    _emailController.text = user.email;
    return Expanded(
        child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      child:  Container(
                        width: 150.0,
                        height: 180.0,
                        child: Image.file(photo),
                        // decoration: new BoxDecoration(
                        //     shape: BoxShape.rectangle,
                        //     image: new DecorationImage(
                        //         fit: BoxFit.fill,
                        //         image: _image == null
                        //             ? Image.network(user.profile_photo_url) : _image
                        //     )
                        // )
                      ),
                      onTap: (){
                        showDialog(
                          context: context,
                          builder: (BuildContext dialogContext){
                            return SimpleDialog(
                              title: Text('Select photo'),
                              children: <Widget>[
                                SimpleDialogOption(
                                  child: Text('From gallery'),
                                  onPressed: () {
                                    selectOrTakePhoto(context, ImageSource.gallery);
                                    Navigator.pop(dialogContext);
                                  },
                                ),
                                SimpleDialogOption(
                                  child: Text('Take a photo'),
                                  onPressed: () {
                                    selectOrTakePhoto(context, ImageSource.camera);
                                    Navigator.pop(dialogContext);
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      },
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Nama", style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),),
                        SizedBox(
                          height: 8,
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(0.0, 8, 8, 8),
                          width: 200.0,
                          decoration: BoxDecoration(
                            color: Style.Colors.textWhiteGrey,
                            borderRadius: BorderRadius.circular(14.0),
                          ),
                          child: TextFormField(
                            keyboardType: TextInputType.emailAddress,
                            controller: _usernameController,
                            decoration: InputDecoration(
                              hintText: 'Nama',
                              hintStyle: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ).copyWith(color: Style.Colors.textGrey),
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Text("Email", style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),),
                        SizedBox(
                          height: 8,
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(0.0, 8, 8, 8),
                          width: 200.0,
                          decoration: BoxDecoration(
                            color: Style.Colors.textWhiteGrey,
                            borderRadius: BorderRadius.circular(14.0),
                          ),
                          child: TextFormField(
                            keyboardType: TextInputType.emailAddress,
                            controller: _emailController,
                            decoration: InputDecoration(
                              hintText: 'Email',
                              hintStyle: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ).copyWith(color: Style.Colors.textGrey),
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
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
                      saveProfile(context, _usernameController.text, _emailController.text, photo);
                    },
                    child: Center(
                      child: Text(
                        "Simpan Perubahan",
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

            ]
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