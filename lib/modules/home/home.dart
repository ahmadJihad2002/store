import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hash/shared/cubit/shop_home_cubit/cubit.dart';
import 'package:hash/shared/cubit/shop_home_cubit/states.dart';
import 'package:hash/shared/drawer/Drawer.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        ShopCubit cubit = ShopCubit.get(context);

        return Scaffold(
          drawer: drawer(),
          body: cubit.screens[cubit.screenIndex],
          bottomNavigationBar: BottomNavigationBar(
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(Icons.category), label: 'first'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.account_circle_rounded), label: 'second'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.shopping_cart), label: 'third'),
            ],
            onTap: (index) {
              print('index');
              print(index);
              cubit.changeIndex(index);
            },
            currentIndex: cubit.screenIndex,
          ),
        );
      },
    );
  }
}
