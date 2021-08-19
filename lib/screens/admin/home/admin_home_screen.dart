import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_with_us/screens/admin/home/cubit/admin_home_cubit.dart';
import 'package:shop_with_us/screens/admin/home/cubit/admin_home_states.dart';
import 'package:shop_with_us/screens/admin/orders/cubit/orders_cubit.dart';
import 'package:shop_with_us/screens/login/login_screen.dart';
import 'package:shop_with_us/shared/colors/colors.dart';
import 'package:shop_with_us/shared/components/components.dart';

class AdminHomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OrdersCubit()..loadOrders(),
      child: BlocConsumer<AdminHomeCubit, AdminHomeStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var currentIndex = AdminHomeCubit.get(context).currentIndex;
          return Scaffold(
            backgroundColor: KWhiteColor,
            body: AdminHomeCubit.get(context).bodies[currentIndex],
            bottomNavigationBar: Container(
              height: 60.0,
              decoration: BoxDecoration(
                color: KSecondaryColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(
                    25.0,
                  ),
                  topRight: Radius.circular(25.0),
                ),
                boxShadow: [
                  BoxShadow(
                    color: KGreyColor.withOpacity(0.3),
                    spreadRadius: 5,
                    blurRadius: 15,
                  ),
                ],
              ),
              child: BottomNavigationBar(
                unselectedItemColor: KGreyColor,
                items: [
                  BottomNavigationBarItem(
                    icon: GestureDetector(
                      child: Icon(
                        Icons.logout,
                      ),
                      onTap: () {
                        navigateAndFinish(context, LoginScreen());
                        AdminHomeCubit.get(context).signOut();
                      },
                    ),
                    label: 'Exit',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(
                      Icons.view_list_sharp,
                    ),
                    label: 'Orders',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(
                      Icons.shopping_bag,
                    ),
                    label: 'Products',
                  ),
                ],
                backgroundColor: Colors.transparent,
                onTap: (index) {
                  AdminHomeCubit.get(context).changeIndex(index);
                },
                //current index match this index
                currentIndex: currentIndex,
                type: BottomNavigationBarType.fixed,
                fixedColor: KMainColor,
                elevation: 0.0,
              ),
            ),
          );
        },
      ),
    );
  }
}
