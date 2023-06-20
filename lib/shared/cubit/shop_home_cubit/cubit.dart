import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hash/models/shop_app/categories_models.dart';
import 'package:hash/models/shop_app/home_model.dart';
import 'package:hash/modules/account/account.dart';
import 'package:hash/modules/cart/cart.dart';
import 'package:hash/modules/category/category.dart';
import 'package:hash/modules/products/products_screen.dart';
import 'package:hash/shared/components/constanse.dart';
import 'package:hash/shared/cubit/shop_home_cubit/states.dart';
import 'package:hash/shared/network/end_point.dart';
import 'package:hash/shared/network/local/cache_helper.dart';
import 'package:hash/shared/network/remote/dio_helper.dart';

class ShopCubit extends Cubit<ShopStates> {
  ShopCubit() : super(ShopInitialStates());

  static ShopCubit get(context) => BlocProvider.of(context);

  int screenIndex = 0;

  List screens = [
    ProductScreen(),
    Account(),
    Cart(),
  ];

  void changeIndex(int index) {
    screenIndex = index;
    emit(ShopBottomNavAppBarChangeStates());
  }

  HomeModel? homeModel;

  void getHomeData() {
    DioHelper.getData(url: HOME, token: token).then((value) {
      homeModel = HomeModel.formJson(value.data);
      emit(ShopSuccessHomeDataStates());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorHomeDataStates());
    });
    emit(ShopLoadingHomeDataStates());
  }




  CategoriesModel? categoriesModel;

  void getCategoriesModel() {
    DioHelper.getData(url: GET_CATEGORIES, token: token).then((value) {
      categoriesModel = CategoriesModel.formJson(value.data);
      emit(ShopSuccessCategoriesStates());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorCategoriesStates());
    });
    emit(ShopLoadingCategoriesSStates());
  }





}
