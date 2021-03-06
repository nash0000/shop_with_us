import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_with_us/network/firebase_auth.dart';
import 'package:shop_with_us/screens/login/cubit/login_states.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(LoginInitialState());

  static LoginCubit get(context) => BlocProvider.of(context);

  String currentMode = 'user';
  String adminMode = 'admin';
  String userMode = 'user';

  changeToAdminMode() {
    currentMode = adminMode;
    emit(LoginAdminState());
  }

  changeToUserMode() {
    currentMode = userMode;
    emit(LoginUserState());
  }

  signIn({email, password, String mode}) {
    //change the state
    emit(LoginLoadingState());

    //post the date
    FirebaseAuthService.signIn(email: email, password: password).then((value) {
      emit(LoginSuccessState(mode));
    }).catchError((e) {
      emit(LoginErrorState(e.toString()));
    });
  }
}
