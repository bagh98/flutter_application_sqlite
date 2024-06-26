import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants/app_consts.dart';
import '../../constants/global_consts.dart';
import '../../controller/app_controller.dart';
import '../../models/meal_model.dart';
import '../../services/meal_sevice.dart';
import '../../view/widgets/app_widgets/myappbar_widget.dart';
import '../widgets/app_widgets/mealsitem_widget.dart';

// ignore: must_be_immutable
class HomeScreen extends StatelessWidget {
  MealServices mealServices = MealServices();
  final AppController controller = Get.put(AppController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: scafoldcolor,
        appBar: MyAppBar(
            context, controller, true, true, AppConstants.restaurantname),
        body: Container(
          child: GetBuilder<AppController>(
            init: controller,
            builder: (_) => controller.isLoading
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : LayoutBuilder(
                    builder: (BuildContext ctx, BoxConstraints constraints) {
                      if (constraints.maxWidth < 480) {
                        return MealsNormalGrid(context, controller.meals);
                      } else {
                        return MealsWideGrid(context, controller.meals);
                      }
                    },
                  ),
          ),
        ));
  }
}

Widget MealsNormalGrid(BuildContext context, List<MealModel> meals) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: GridView.builder(
      shrinkWrap: true,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, childAspectRatio: 0.8),
      itemBuilder: (BuildContext context, int index) {
        return MealItem(context, meals[index]);
      },
      itemCount: meals.length,
    ),
  );
}

Widget MealsWideGrid(BuildContext context, List<MealModel> meals) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: GridView.builder(
      shrinkWrap: true,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3, childAspectRatio: 1.1),
      itemBuilder: (BuildContext context, int index) {
        return MealItem(context, meals[index]);
      },
      itemCount: meals.length,
    ),
  );
}
