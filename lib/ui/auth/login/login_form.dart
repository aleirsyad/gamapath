import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gamapath/bloc/auth/auth_state.dart';
import 'package:gamapath/bloc/login/login_bloc.dart';
import 'package:gamapath/repositories/user_repository.dart';
import 'package:gamapath/styles/theme.dart' as Style;
import 'package:gamapath/ui/auth/register/register_screen.dart';
import 'package:gamapath/ui/home/home_screen.dart';
import 'package:gamapath/ui/widgets/custom_button.dart';
import 'package:gamapath/ui/widgets/custom_checkbox.dart';

class LoginForm extends StatefulWidget {
  final UserRepository userRepository;
  LoginForm({Key? key, required this.userRepository})
      : assert(userRepository != null),
        super(key: key);

  @override
  State<LoginForm> createState() => _LoginFormState(userRepository);
}

class _LoginFormState extends State<LoginForm> {
  final UserRepository userRepository;
  _LoginFormState(this.userRepository);
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  //password
  bool passwordVisible = false;
  void togglePassword() {
    setState(() {
      passwordVisible = !passwordVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    _onLoginButtonPressed() {
      BlocProvider.of<LoginBloc>(context).add(
        LoginButtonPressed(
          email: _usernameController.text,
          password: _passwordController.text,
        ),
      );
    }

    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state is LoginFailure) {
          Scaffold.of(context).showSnackBar(
            SnackBar(
              content: Text("Login gagal."),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      child: BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state) {
          return Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: Colors.white,
            body: SafeArea(
              child: Padding(
                padding: EdgeInsets.fromLTRB(24.0, 40.0, 24.0, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'SELAMAT DATANG',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w700,
                          ).copyWith(color: Style.Colors.secondBlack),
                        ),
                        Text(
                          'Selamat datang kembali di aplikasi gamapath!',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                          ).copyWith(color: Style.Colors.secondBlack),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        // Image.asset(
                        //   'assets/images/accent.png',
                        //   width: 99,
                        //   height: 4,
                        // ),
                      ],
                    ),
                    SizedBox(
                      height: 48,
                    ),
                    Form(
                      child: Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: Style.Colors.textWhiteGrey,
                              borderRadius: BorderRadius.circular(14.0),
                            ),
                            child: TextFormField(
                              keyboardType: TextInputType.emailAddress,
                              controller: _usernameController,
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
                          SizedBox(
                            height: 32,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: Style.Colors.textWhiteGrey,
                              borderRadius: BorderRadius.circular(14.0),
                            ),
                            child: TextFormField(
                              obscureText: !passwordVisible,
                              controller: _passwordController,
                              decoration: InputDecoration(
                                hintText: 'Password',
                                hintStyle: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ).copyWith(color: Style.Colors.textGrey),
                                suffixIcon: IconButton(
                                  color: Style.Colors.grey,
                                  splashRadius: 1,
                                  icon: Icon(passwordVisible
                                      ? Icons.visibility_outlined
                                      : Icons.visibility_off_outlined),
                                  onPressed: togglePassword,
                                ),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 32,
                    ),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.start,
                    //   children: [
                    //     CustomCheckbox(),
                    //     SizedBox(
                    //       width: 12,
                    //     ),
                    //     Text('Remember me',
                    //         style: TextStyle(
                    //             fontSize: 16, fontWeight: FontWeight.w400)),
                    //   ],
                    // ),
                    // SizedBox(
                    //   height: 32,
                    // ),
                    SizedBox(
                        child: state is LoginLoading
                            ? Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      height: 25.0,
                                      width: 25.0,
                                      child: CupertinoActivityIndicator(),
                                    )
                                  ],
                                ))
                          ],
                        )
                            : Material(
                          borderRadius: BorderRadius.circular(14.0),
                          elevation: 0,
                          child: Container(
                            height: 56,
                            decoration: BoxDecoration(
                              color: Style.Colors.mainColor,
                              borderRadius: BorderRadius.circular(14.0),
                            ),
                            child: Material(
                              color: Colors.transparent,
                              child: RaisedButton(
                                color: Style.Colors.mainColor,
                                disabledColor: Style.Colors.textWhiteGrey,
                                disabledTextColor: Style.Colors.textGrey,
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                    BorderRadius.circular(14.0)),
                                onPressed: _onLoginButtonPressed,
                                child: Center(
                                  child: Text(
                                    "LOGIN",
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
                        )),
                    // SizedBox(
                    //   height: 24,
                    // ),
                    // Center(
                    //   child: Text(
                    //     'OR',
                    //     style:
                    //     TextStyle(fontSize: 16, fontWeight: FontWeight.w600)
                    //         .copyWith(color: Style.Colors.grey),
                    //   ),
                    // ),
                    // SizedBox(
                    //   height: 24,
                    // ),
                    // CustomPrimaryButton(
                    //   buttonColor: Style.Colors.titleColor,
                    //   textValue: 'Login with SSO',
                    //   textColor: Style.Colors.greyBack,
                    // ),
                    SizedBox(
                      height: 50,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Belum memiliki akun? ",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w400)
                              .copyWith(color: Style.Colors.grey),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => RegisterScreen(
                                      userRepository: userRepository,
                                    )));
                          },
                          child: Text(
                            'SIGN UP',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w400)
                                .copyWith(color: Style.Colors.mainColor),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}