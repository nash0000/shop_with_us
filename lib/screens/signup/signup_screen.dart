import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_with_us/models/user.dart';
import 'package:shop_with_us/screens/login/login_screen.dart';
import 'package:shop_with_us/screens/signup/cubit/signup_cubit.dart';
import 'package:shop_with_us/screens/signup/cubit/signup_states.dart';
import 'package:shop_with_us/shared/colors/colors.dart';
import 'package:shop_with_us/shared/components/components.dart';
import 'package:shop_with_us/shared/constant.dart';

class SignUpScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final passWordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double signUpScreenHeight = MediaQuery.of(context).size.height;

    return BlocProvider(
      create: (BuildContext context) => SignUpCubit(),
      child: BlocConsumer<SignUpCubit, SignUpStates>(
        listener: (context, state) {
          if (state is SignUpLoadingState) {
            showAlertDialoag(context: context, text: 'please wait...');
          }
          if (state is SignUpSuccessState) {
            //close the progress dialog in the last state
            Navigator.pop(context);
            navigateToReplaceMe(
              context,
              LoginScreen(
                email: emailController.text,
                password: passWordController.text,
              ),
            );
          }
          if (state is SignUpErrorState) {
            //close the progress dialog in the last state
            Navigator.pop(context);
            showAlertDialoag(
              context: context,
              text: 'This account is already exist ',
              error: true,
            );
          }
        },
        builder: (context, state) {
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
                        showLogo(screenHeight: signUpScreenHeight),
                        SizedBox(
                          height: signUpScreenHeight * 0.04,
                        ),
                        buildTextFormField(
                          title: KTextFormName,
                          controller: nameController,
                          icon: Icons.person,
                        ),
                        //
                        SizedBox(
                          height: signUpScreenHeight * 0.03,
                        ),
                        buildTextFormField(
                          title: KTextFormEmail,
                          keyboardType: TextInputType.emailAddress,
                          controller: emailController,
                          icon: Icons.email,
                        ),
                        SizedBox(
                          height: signUpScreenHeight * 0.03,
                        ),
                        buildTextFormField(
                          title: KTextFormPhone,
                          controller: phoneController,
                          icon: Icons.phone_android,
                        ),
                        SizedBox(
                          height: signUpScreenHeight * 0.03,
                        ),
                        buildTextFormField(
                          title: KTextFormPassword,
                          keyboardType: TextInputType.visiblePassword,
                          controller: passWordController,
                          icon: Icons.lock,
                          obscureText: true,
                        ),
                        SizedBox(
                          height: signUpScreenHeight * 0.05,
                        ),
                        buildButton(
                          onPressed: () {
                            String name = nameController.text.trim();
                            String email = emailController.text.trim();
                            String phone = phoneController.text.trim();
                            String passWord = passWordController.text.trim();

                            if (_formKey.currentState.validate()) {
                              _checkValidationAndSignUP(
                                context: context,
                                name: name,
                                email: email,
                                phone: phone,
                                password: passWord,
                              );
                            }
                          },
                          title: KSignUp,
                        ),
                        SizedBox(
                          height: signUpScreenHeight * 0.05,
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
                                navigateToReplaceMe(context, LoginScreen());
                              },
                              child: Text(
                                KSignIn,
                                style: TextStyle(
                                    color: KSloganColor, fontSize: 16),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: signUpScreenHeight * 0.05,
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
}

void _checkValidationAndSignUP({
  @required BuildContext context,
  @required String name,
  @required String email,
  @required String phone,
  @required String password,
}) {
  SignUpCubit.get(context).signUp(
      user: User(
    userName: name,
    userEmail: email,
    userPhone: phone,
    userPassword: password,
  ));
}
