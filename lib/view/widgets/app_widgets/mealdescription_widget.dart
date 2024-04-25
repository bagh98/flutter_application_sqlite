import 'package:flutter/material.dart';

import '../../../constants/app_consts.dart';
import '../../../models/meal_model.dart';

Widget MealsDescription(BuildContext context, MealModel meal) {
  Size size = MediaQuery.of(context).size;
  return Container(
    width: size.width < 480 ? size.width : size.width * .5,
    padding: EdgeInsets.symmetric(horizontal: 50.0, vertical: 20.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          meal.name,
          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 19.0),
        ),
        Padding(
          padding: EdgeInsets.only(top: 10.0),
          child: Text("${meal.name}:${AppConstants.mealdescription}"),
        )
      ],
    ),
  );
}
