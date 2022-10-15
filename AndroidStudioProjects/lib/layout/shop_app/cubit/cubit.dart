import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/layout/shop_app/cubit/states.dart';
import 'package:untitled/models/shop_app/categories_model.dart';
import 'package:untitled/models/shop_app/change_favorites_model.dart';
import 'package:untitled/models/shop_app/favorites_model.dart';
import 'package:untitled/models/shop_app/home_model.dart';
import 'package:untitled/modules/shop_app/categories/cateogries_screen.dart';
import 'package:untitled/modules/shop_app/favorites/favorites_screen.dart';
import 'package:untitled/modules/shop_app/products/products_screen.dart';
import 'package:untitled/modules/shop_app/settings/settings_screen.dart';
import 'package:untitled/shared/components/constants.dart';
import 'package:untitled/shared/network/end_points.dart';
import 'package:untitled/shared/network/remote/dio_helper.dart';

class ShopCubit extends Cubit<ShopStates>
{
  ShopCubit(ShopStates initialState) : super(initialState);

  static ShopCubit get(context) => BlocProvider.of(context);
  int currentIndex = 0;
  List <Widget> bottomScreens = [
    ProductsScreen(),
    CategoriesScreen(),
    FavoritesScreen(),
    SettingsScreen(),
  ];

  void changeBottom(int index)
  {
    currentIndex = index;
    emit(ShopChangeBottomNavState());
  }

  HomeModel? homeModel;

  Map<int,bool>favourite= {};
  void getHomeData(){
    emit(ShopLoadingHomeDataState());
    DioHelper.getData(
        path: Home,
        token: token).then((value) {
      homeModel=HomeModel.fromJson(value.data);
      homeModel!.data.products.forEach((element) {
        favourite.addAll({element.id:element.favorites});
      });
      // printFullText(homeModel!.data.banners.toString());
      // print(homeModel!.status);
      // print(favourite);

      emit(ShopSuccessHomeDataState());
    }).
    catchError((error)
    {
      emit(ShopErrorHomeDataState());
      print(error.toString());
    });
  }

  CategoriesModel? categoriesModel;

  void getCategoriesData(){
    DioHelper.getData(
        path: GET_CATEGORIES,
        token: token).then((value) {
      categoriesModel=CategoriesModel.fromJson(value.data);
      emit(ShopSuccessCategoriesState());
    }).
    catchError((error)
    {
      emit(ShopErrorCategoriesState());
      print(error.toString());
    });
  }


  ChangeFavoritesModel? changeFavouritesModel;

  void changeFavourites(int productId)
  {
    favourite[productId] = !favourite[productId]!;

    emit( ShopChangeFavoritesState());

    DioHelper.postData(
        url: FAVORITES,
        data:{
          'product_id':productId
        } ,
      token: token,
    ).then((value)
    {
      changeFavouritesModel = changeFavouritesModel!.fromJson(value.data);
      print(value.data);

      if(!changeFavouritesModel!.status!)
      {
        favourite[productId] = !favourite[productId]!;
      } else
      {
        getFavorites();
      }

      emit( ShopSuccessChangeFavoritesState(changeFavouritesModel!));
    }).catchError((error)
    {
      favourite[productId] = !favourite[productId]!;
      ShopErrorChangeFavoritesState();
    });
  }

  FavouritesModel? favoritesModel;

  void getFavorites()
  {
    emit(ShopLoadingGetFavoritesState());
    
    DioHelper.getData(
        path: FAVORITES,
        token: token
    ).then((value) {
      favoritesModel=FavouritesModel.fromJson(value.data);
      printFullText(value.data.toString());

      emit(ShopSuccessGetFavoritesState());
    }).catchError((error) {
      emit(ShopErrorGetFavoritesState());
      print(error.toString());
    });
  }
}