import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_with_us/network/firebase_auth.dart';
import 'package:shop_with_us/screens/admin/home/cubit/admin_home_states.dart';
import 'package:shop_with_us/screens/admin/orders/orders_screen.dart';
import 'package:shop_with_us/screens/admin/products/manage_products_home_screen.dart';

class AdminHomeCubit extends Cubit<AdminHomeStates> {
  AdminHomeCubit() : super(AdminHomeInitialState());

  static AdminHomeCubit get(context) => BlocProvider.of(context);

  var bodies = [Container(), OrdersScreen(), ManageProductsHomeScreen()];

  int currentIndex = 1;
  changeIndex(index) {
    emit(AdminHomeIndexState());
  }

  signOut() {
    FirebaseAuthService.signOut();
  }
}
