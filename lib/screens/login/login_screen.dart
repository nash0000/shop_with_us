import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_with_us/screens/login/cubit/login_cubit.dart';
import 'package:shop_with_us/screens/login/cubit/login_states.dart';
import 'package:shop_with_us/screens/signup/signup_screen.dart';
import 'package:shop_with_us/shared/colors/colors.dart';
import 'package:shop_with_us/shared/components/components.dart';
import 'package:shop_with_us/shared/constant.dart';

class LoginScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final String email;
  final String password;

  LoginScreen({this.email, this.password});

  final emailController = TextEditingController();
  final passWordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double loginScreenHeight = MediaQuery.of(context).size.height;

    if (email != null && password != null) {
      emailController.text = email;
      passWordController.text = password;
    }

    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginStates>(
        listener: (context, state) {
          if (state is LoginLoadingState) {
            showAlertDialoag(
              context: context,
              text: 'please wait...',
            );
          }
          if (state is LoginSuccessState) {
            //close the progress dialog in the last state
            Navigator.pop(context);
            if (state.mode == LoginCubit.get(context).userMode) {
              // navigateAndFinish(
              //   context,
              //  HomeScreen(),
              // );
            } else if (state.mode == LoginCubit.get(context).adminMode) {
              // AdminHomeCubit.get(context).currentIndex = 1;
              // navigateAndFinish(
              //   context,
              //   AdminHomeScreen(),
              // );
            }
          }
          if (state is LoginErrorState) {
            //close the progress dialog in the last state
            Navigator.pop(context);
            showAlertDialoag(
              context: context,
              text: "This account not found",
              error: true,
            );
          }
        },
        builder: (context, state) {
          String defaultMode = LoginCubit.get(context).currentMode;
          String adminMode = LoginCubit.get(context).adminMode;
          String userMode = LoginCubit.get(context).userMode;

          return Scaffold(
            backgroundColor: KMainColor,
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: 50,
                          width: double.infinity,
                        ),
                        showLogo(screenHeight: loginScreenHeight),
                        SizedBox(
                          height: loginScreenHeight * 0.1,
                        ),
                        buildTextFormField(
                          icon: Icons.email,
                          title: KTextFormEmail,
                          controller: emailController,
                          keyboardType: TextInputType.emailAddress,
                        ),
                        SizedBox(
                          height: loginScreenHeight * 0.3,
                        ),
                        buildTextFormField(
                          title: KTextFormEmail,
                          keyboardType: TextInputType.visiblePassword,
                          controller: passWordController,
                          icon: Icons.lock,
                          obscureText: true,
                        ),
                        SizedBox(height: 15),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Radio(
                              activeColor: Colors.black,
                              value: LoginCubit.get(context).userMode,
                              groupValue: LoginCubit.get(context).currentMode,
                              onChanged: (value) {
                                LoginCubit.get(context).changeToUserMode();
                              },
                            ),
                            Text(
                              KIamUser,
                              style: TextStyle(color: KTextDarkColor),
                            ),
                            Radio(
                              activeColor: Colors.black,
                              value: LoginCubit.get(context).adminMode,
                              groupValue: LoginCubit.get(context).currentMode,
                              onChanged: (value) {
                                LoginCubit.get(context).changeToAdminMode();
                              },
                            ),
                            Text(
                              KIamAdmin,
                              style: TextStyle(color: KTextDarkColor),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        buildButton(
                          onPressed: () {
                            String email = emailController.text.trim();
                            String password = passWordController.text.trim();

                            if (_formKey.currentState.validate()) {
                              _checkAdminOrUserAndLogin(
                                context: context,
                                email: email,
                                password: password,
                                defaultMode: defaultMode,
                                adminMode: adminMode,
                                userMode: userMode,
                              );
                            }
                          },
                          title: KSignIn,
                        ),
                        SizedBox(
                          height: loginScreenHeight * 0.05,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Flexible(
                              child: Text(
                                KHaveNoAccount,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style:
                                    TextStyle(color: KGreyColor, fontSize: 16),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                navigateToReplaceMe(context, SignUpScreen());
                              },
                              child: Text(
                                KSignUp,
                                style: TextStyle(
                                    fontSize: 16, color: KSloganColor),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: loginScreenHeight * 0.05,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  _checkAdminOrUserAndLogin(
      {context, email, password, defaultMode, adminMode, userMode}) {
    const String adminPassword = 'nash12';
    if (defaultMode == userMode) {
      LoginCubit.get(context)
          .signIn(email: email, password: password, mode: userMode);
    } else if (defaultMode == adminMode) {
      if (password == adminPassword) {
        LoginCubit.get(context)
            .signIn(email: email, password: password, mode: adminMode);
      } else {
        showAlertDialoag(
          context: context,
          text: 'Wrong Credentials ',
          error: true,
        );
      }
    }
  }
}
