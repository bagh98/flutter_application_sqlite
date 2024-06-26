import 'package:get/get.dart';

import '../models/meal_model.dart';
import '../services/meal_sevice.dart';

class AppController extends GetxController {
  MealServices mealServices = MealServices();
  List<MealModel> meals = [];
  List<MealModel> cartmeals = [];
  List<MealModel> favmeals = [];
  bool isLoading = true;

  @override
  void onInit() {
    super.onInit();
    loadDB();
  }

  loadDB() async {
    await mealServices.openDB();
    loadItems();
    getCardList();
    getFavList();
  }

  getItem(int id) {
    return meals.singleWhere((element) => element.id == id);
  }

  bool isAlreadyInCart(id) {
    return cartmeals.indexWhere((element) => element.shopId == id) > -1;
  }

  bool isAlreadyInFavLIST(id) {
    return favmeals.indexWhere((element) => element.shopId == id) > -1;
  }

  getCardList() async {
    try {
      List list = await mealServices.getCartList();
      cartmeals.clear();
      list.forEach((element) {
        cartmeals.add(MealModel.fromJson(element));
      });
      update();
    } catch (e) {
      print(e);
    }
  }

  getFavList() async {
    try {
      List list = await mealServices.getFavList();
      favmeals.clear();
      list.forEach((element) {
        favmeals.add(MealModel.fromJson(element));
      });
      update();
    } catch (e) {
      print(e);
    }
  }

  loadItems() async {
    try {
      isLoading = true;
      update();

      List list = await mealServices.loadItems();
      list.forEach((element) {
        meals.add(MealModel.fromJson(element));
      });

      isLoading = false;
      update();
    } catch (e) {
      print(e);
    }
  }

  setToFav(int id, bool flag) async {
    int index = meals.indexWhere((element) => element.id == id);

    meals[index].fav = flag;
    update();
    try {
      await mealServices.setItemAsFavourite(id, flag);
    } catch (e) {
      print(e);
    }
  }

  Future addToCart(MealModel item) async {
    isLoading = true;
    update();
    var result = await mealServices.addToCart(item);
    isLoading = false;
    update();
    return result;
  }

  removeFromCart(int shopId) async {
    mealServices.removeFromCart(shopId);
    int index = cartmeals.indexWhere((element) => element.shopId == shopId);
    cartmeals.removeAt(index);
    update();
  }

  Future addToFav(MealModel item) async {
    isLoading = true;
    update();
    var result = await mealServices.addToFav(item);
    isLoading = false;
    update();
    return result;
  }

  removeFromFav(int shopId) async {
    mealServices.removeFromFav(shopId);
    int index = favmeals.indexWhere((element) => element.shopId == shopId);
    favmeals.removeAt(index);
    update();
  }
}
