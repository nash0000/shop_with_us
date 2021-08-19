import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_with_us/screens/admin/home/cubit/admin_home_cubit.dart';
import 'package:shop_with_us/screens/login/login_screen.dart';
import 'package:shop_with_us/shared/components/components.dart';
import 'package:shop_with_us/shared/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    initApp();

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AdminHomeCubit()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Cloths Shop',
        theme: theme(),
        home: LoginScreen(),
      ),
    );
  }
}
