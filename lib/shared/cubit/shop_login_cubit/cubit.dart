import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hash/models/shop_app/login_model.dart';
import 'package:hash/modules/account/account.dart';
import 'package:hash/modules/cart/cart.dart';
import 'package:hash/modules/category/category.dart';
import 'package:hash/shared/cubit/shop_login_cubit/states.dart';
import 'package:hash/shared/network/end_point.dart';
import 'package:hash/shared/network/remote/dio_helper.dart';

class HomeBodyCubit extends Cubit<HomeBodyStates> {
  HomeBodyCubit() : super(HomeBodyInitialStates());

  static HomeBodyCubit get(context) => BlocProvider.of(context);

  int screenIndex = 0;

  List screens = [
    CategoryScreen(),
    Account(),
    Cart(),
  ];

  void changeIndex(int index) {
    screenIndex = index;
    emit(BottomNavAppBarChangeStates());
  }
}

class ShopLoginCubit extends Cubit<ShopLoginStates> {
  ShopLoginCubit() : super(ShopLoginInitialState());
  late ShopLoginModel loginModel;

  static ShopLoginCubit get(context) => BlocProvider.of(context);

  void userLogin({
    required String email,
    required String password,
  }) {
    emit(ShopLoginLoadingState());

    // login using default API
    /*
    DioHelper.postData(
      url: LOGIN,
      data: {'email': email, 'password': password},
    ).then((value) {

      loginModel = ShopLoginModel.formJson(value.data);
      print(loginModel.status);
      emit(ShopLoginSuccessState(loginModel));
    }).catchError((error) {
      print(error);
      emit(
        ShopLoginErrorState(error.toString()),
      );
    });



   */
  }

  Function navigateToNextScreen(BuildContext context, Widget screen) {
    // Perform navigation here
    return () => Navigator.pushNamed(
        context,'register');
  }

  void userRegister({
    required String email,
    required String password,
  }) {
    emit(ShopLoginLoadingState());

    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) => emit(ShopRegSuccessState()))
        .catchError((error) {
      ShopRegErrorState(error);
    });

    // reg using default API
    /*
    DioHelper.postData(
      url: LOGIN,
      data: {'email': email, 'password': password},
    ).then((value) {

      loginModel = ShopLoginModel.formJson(value.data);
      print(loginModel.status);
      emit(ShopLoginSuccessState(loginModel));
    }).catchError((error) {
      print(error);
      emit(
        ShopLoginErrorState(error.toString()),
      );
    });

    */
  }

  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;

  void changePasswordVisibility() {
    suffix = Icons.visibility_off_outlined;
    isPassword = !isPassword;
    suffix =
        isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(ShopLoginChangePasswordVisibilityState());
  }
}
