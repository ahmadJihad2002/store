import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hash/firebase_options.dart';
import 'package:hash/modules/home/home.dart';
import 'package:hash/modules/login/login.dart';
import 'package:hash/modules/login/register.dart';
import 'package:hash/shared/components/constanse.dart';
import 'package:hash/shared/cubit/shop_home_cubit/cubit.dart';
import 'package:hash/shared/cubit/shop_home_cubit/states.dart';
import 'package:hash/shared/cubit/shop_login_cubit/cubit.dart';
import 'package:hash/shared/network/local/cache_helper.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Bloc.observer = MyBlocObserver();
  Widget widget;
  token = await CacheHelper.getData(key: 'token');
  print('token');
  print(token);
  if (token.isEmpty) {
    widget = Login();
  } else {
    widget = Home();
  }
  runApp(MyApp(startWidget: widget));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.startWidget});

  final Widget startWidget;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
              create: (BuildContext context) => ShopCubit()
                ..getHomeData()
                ..getCategoriesModel()),
          BlocProvider(
            create: (BuildContext context) => ShopLoginCubit(),
          )
        ],
        child: BlocConsumer<ShopCubit, ShopStates>(
          listener: (context, state) {},
          builder: (context, state) {
            return MaterialApp(
                routes: {'register': (context) => Register()},
                debugShowCheckedModeBanner: false,
                title: 'Flutter Demo',
                theme: ThemeData(
                  textTheme: TextTheme(
                      displayLarge: TextStyle(
                          fontSize: 30,
                          color: Colors.black,
                          fontWeight: FontWeight.bold)),
                  scaffoldBackgroundColor: Colors.white,
                  primarySwatch: Colors.blue,
                  appBarTheme: AppBarTheme(color: Colors.blue),
                  bottomNavigationBarTheme: BottomNavigationBarThemeData(),
                ),
                themeMode: ThemeMode.light,
                darkTheme: ThemeData(),
                home: Login());
          },
        ));
  }
}
