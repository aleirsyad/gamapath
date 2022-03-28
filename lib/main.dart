import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gamapath/repositories/user_repository.dart';
import 'package:gamapath/styles/theme.dart' as Style;
import 'package:gamapath/ui/auth/login/login_screen.dart';
import 'package:gamapath/ui/auth/register/register_screen.dart';
import 'package:gamapath/ui/home/home_screen.dart';
import 'package:gamapath/ui/intro/intro_screen.dart';
import 'bloc/auth/auth.dart';
import 'bloc/auth/auth_bloc.dart';

class SimpleBlocDelegate extends BlocDelegate{
  @override
  void onEvent(Bloc bloc, Object event) {
    super.onEvent(bloc, event);
    print(event);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    print(transition);
  }

  @override
  void onError(Bloc bloc, Object error, StackTrace stacktrace) {
    super.onError(bloc, error, stacktrace);
    print(error);
  }
}
void main() {
  BlocSupervisor.delegate = SimpleBlocDelegate();
  final userRepository = UserRepository();
  runApp(
    BlocProvider<AuthenticationBloc>(
      create: (context){
        return AuthenticationBloc(userRepository: userRepository)
            ..add(AppStarted());
      },
        child: MyApp(userRepository: userRepository),
    ),
  );
}

class MyApp extends StatelessWidget {
  final UserRepository userRepository;
  MyApp({Key? key, required this.userRepository}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(

        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state){
          if(state is AuthenticationAuthenticated){
            return MainScreen();
          }
          if(state is AuthenticationUnauthenticated){
            return LoginScreen(userRepository: userRepository);
          }
          if(state is AuthenticationNeedRegister){
            return RegisterScreen(userRepository: userRepository);
          }
          if(state is AuthenticationLoading){
            return Scaffold(
              body: Container(
                color: Colors.white,
                width: MediaQuery.of(context).size.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      height: 25.0,
                      width: 25.0,
                      child: CircularProgressIndicator(
                        valueColor: new AlwaysStoppedAnimation<Color>(
                            Style.Colors.mainColor),
                        strokeWidth: 4.0,
                      ),
                    )
                  ],
                ),
              ),
            );
          }
          return Scaffold(
            body: Container(
              color: Colors.white,
              width: MediaQuery.of(context).size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: 25.0,
                    width: 25.0,
                    child: CircularProgressIndicator(
                      valueColor: new AlwaysStoppedAnimation<Color>(
                          Style.Colors.mainColor),
                      strokeWidth: 4.0,
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}