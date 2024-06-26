import 'package:flutter/material.dart';

import '../../../constants/global_consts.dart';

Widget MyButton({required String name, GestureTapCallback? onTap}) {
  return ElevatedButton(
    style: ButtonStyle(backgroundColor: MaterialStateProperty.all(appbarcolor)),
    onPressed: onTap,
    child: Text(name),
  );
}
