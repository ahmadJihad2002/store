import 'package:hash/models/shop_app/login_model.dart';

abstract class HomeBodyStates {}

class HomeBodyInitialStates extends HomeBodyStates {}

class BottomNavAppBarChangeStates extends HomeBodyStates {}

abstract class ShopLoginStates {}

class ShopLoginInitialState extends ShopLoginStates {}

class ShopLoginLoadingState extends ShopLoginStates {}

class ShopLoginSuccessState extends ShopLoginStates {
  ShopLoginModel loginModel;

  ShopLoginSuccessState(
    this.loginModel,
  );
}

class ShopLoginErrorState extends ShopLoginStates {
  final String error;

  ShopLoginErrorState(this.error);
}

class ShopRegLoadingState extends ShopLoginStates {}

class ShopRegSuccessState extends ShopLoginStates {}

class ShopRegErrorState extends ShopLoginStates {
  final String error;

  ShopRegErrorState(this.error);
}

class ShopLoginChangePasswordVisibilityState extends ShopLoginStates {}
