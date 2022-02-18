import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gamapath/bloc/register/register_bloc.dart';
import 'package:gamapath/bloc/register/register_event.dart';
import 'package:gamapath/bloc/register/register_state.dart';
import 'package:gamapath/repositories/user_repository.dart';
import 'package:gamapath/styles/theme.dart' as Style;
import 'package:gamapath/ui/auth/login/login_screen.dart';
import 'package:gamapath/ui/widgets/custom_button.dart';
import 'package:gamapath/ui/widgets/custom_checkbox.dart';

class RegisterForm extends StatefulWidget {
  final UserRepository userRepository;
  RegisterForm({Key? key, required this.userRepository})
      : assert(userRepository != null),
        super(key: key);

  @override
  State<RegisterForm> createState() => _RegisterFormState(userRepository);
}

class _RegisterFormState extends State<RegisterForm> {
  bool passwordVisible = false;
  bool cpasswordVisible = false;
  void togglePassword() {
    setState(() {
      passwordVisible = !passwordVisible;
      cpasswordVisible = !cpasswordVisible;
    });
  }

  final UserRepository userRepository;
  _RegisterFormState(this.userRepository);
  final _roleController = TextEditingController();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _passwordcController = TextEditingController();
  final _prodiController = TextEditingController();
  final _nimController = TextEditingController();
  final _groupController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _onRegisterButtonPressed() {
      BlocProvider.of<RegisterBloc>(context).add(RegisterButtonPressed(
          role: _roleController.text,
          name: _nameController.text,
          email: _emailController.text,
          password: _passwordController.text,
          password_c: _passwordcController.text,
          program_study_id: _prodiController.text,
          nim: _nimController.text,
          group: _groupController.text));
    }

    return BlocListener<RegisterBloc, RegisterState>(
      listener: (context, state) {
        if (state is RegisterFailure) {
          Scaffold.of(context).showSnackBar(
            SnackBar(
              content: Text("Register failed."),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      child: BlocBuilder<RegisterBloc, RegisterState>(
        builder: (context, state) {
          return Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: Colors.white,
            body: SafeArea(
              child: SingleChildScrollView(
                padding: EdgeInsets.fromLTRB(24.0, 40.0, 24.0, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'HAI, GAMAPATH',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w700,
                          ).copyWith(color: Style.Colors.secondBlack),
                        ),
                        Text(
                          'Silakan mendaftar akun disini!',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                          ).copyWith(color: Style.Colors.secondBlack),
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
                              controller: _roleController,
                              decoration: InputDecoration(
                                hintText: 'Daftar Sebagai',
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
                              controller: _nameController,
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
                            height: 32,
                          ),
                          Container(
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
                          SizedBox(
                            height: 32,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: Style.Colors.textWhiteGrey,
                              borderRadius: BorderRadius.circular(14.0),
                            ),
                            child: TextFormField(
                              controller: _prodiController,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                hintText: 'Program',
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
                              controller: _nimController,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                hintText: 'NIM',
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
                              controller: _groupController,
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                hintText: 'Kelompok',
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
                          SizedBox(
                            height: 32,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: Style.Colors.textWhiteGrey,
                              borderRadius: BorderRadius.circular(14.0),
                            ),
                            child: TextFormField(
                              obscureText: !cpasswordVisible,
                              controller: _passwordcController,
                              decoration: InputDecoration(
                                hintText: 'Ulangi Password',
                                hintStyle: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ).copyWith(color: Style.Colors.textGrey),
                                suffixIcon: IconButton(
                                  color: Style.Colors.grey,
                                  splashRadius: 1,
                                  icon: Icon(cpasswordVisible
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
                    SizedBox(
                        child: state is RegisterLoading
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
                                onPressed: _onRegisterButtonPressed,
                                child: Center(
                                  child: Text(
                                    "SIGN UP",
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
                    SizedBox(
                      height: 50,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Sudah memiliki akun? ",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w400)
                              .copyWith(color: Style.Colors.grey),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LoginScreen(
                                      userRepository: userRepository,
                                    )));
                          },
                          child: Text(
                            'LOGIN',
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