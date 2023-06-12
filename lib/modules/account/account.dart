import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hash/modules/account/cardBuilder.dart';
import 'package:hash/shared/components/components.dart';
import 'package:hash/shared/cubit/shop_home_cubit/cubit.dart';
import 'package:hash/shared/cubit/shop_home_cubit/states.dart';
import 'package:hash/shared/cubit/shop_login_cubit/cubit.dart';
import 'package:hash/shared/cubit/shop_login_cubit/states.dart';

class Account extends StatelessWidget {
  const Account({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer< ShopCubit , ShopStates  >(
      listener: (context, state) {},
      builder: (context, state) {
        ShopCubit cubit = ShopCubit.get(context);


        return SafeArea(
          child: Scaffold(
            appBar: AppBar(),
            body: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconsCard(
                  context: context,
                  title: 'nigga',
                  icon1: Icons.shopping_cart,
                  icon2: Icons.shopping_cart,
                  icon3: Icons.shopping_cart,
                  icon4: Icons.shopping_cart,
                  title1: 'nigga',
                  title2: 'bitch',
                  title3: 'hony',
                  title4: 'babe',
                ),
                IconsCard(
                  context: context,
                  title: 'تواصل',
                  icon1: Icons.media_bluetooth_off,
                  icon2: Icons.shopping_cart,
                  icon3: Icons.account_circle_rounded,
                  icon4: Icons.shopping_cart,
                  title1: 'facebook',
                  title2: 'web',
                  title3: 'LinkedIn',
                  title4: 'babe',
                )

                // Card(
                //   elevation: 8.0,
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.spaceAround,
                //     children: [
                //       defaultIconButton(
                //         icon: Icon(Icons.shopping_cart),
                //         onPressed: () {},
                //       ),
                //       defaultIconButton(
                //         icon: Icon(Icons.local_shipping),
                //         onPressed: () {},
                //       ),
                //       defaultIconButton(
                //         icon: Icon(Icons.add_chart_rounded),
                //         onPressed: () {},
                //       ),
                //       defaultIconButton(
                //         icon: Icon(Icons.shopping_cart),
                //         onPressed: () {},
                //       ),
                //     ],
                //   ),
                // )
              ],
            ),
          ),
        );
      },
    );
  }
}
