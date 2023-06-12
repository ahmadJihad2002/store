import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

Widget defaultButton(
    {required function,
    required String text,
    double width = double.infinity,
    Color backgroundColor = Colors.blue,
    double radius = 3.0}) {
  return InkWell(
    onTap: function,
    child: Container(
      width: width,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(radius),
      ),
      alignment: Alignment.center,
      padding: const EdgeInsets.all(15),
      child: Text(
        text,
        style: TextStyle(color: Colors.white),
      ),
    ),
  );
}

Widget defaultFormField({
  required TextEditingController controller,
  required TextInputType inputType,
  required String label,
  required IconData icon,
  required validate,
  String? hint,
  Function? onSubmit,
  Function? onchange,
  Function? onTap,
  IconData? suffix,
  bool isPassword = false,
  VoidCallback? suffixOnTap,
}) {
  return TextFormField(
    obscureText: isPassword,
    style: TextStyle(),
    decoration: InputDecoration(
      suffix: IconButton(
        onPressed: suffixOnTap,
        icon: Icon(suffix),
      ),
      border: const OutlineInputBorder(),
      prefixIcon: Icon(icon),
      hintText: hint,
      label: Text(label),
    ),
    controller: controller,
    keyboardType: inputType,
    validator: validate,
  );
}

Widget defaultTextButton({
  required TextEditingController controller,
  required function,
  required String text,
}) {
  return TextButton(
    onPressed: function,
    child: Text(text.toUpperCase()),
  );
}

Widget defaultIconButton({
  required void Function() onPressed,
  required Icon icon,
}) {
  return IconButton(onPressed: onPressed, icon: icon);
}

void showToast({required String text, required ToastStates state}) {
  Fluttertoast.showToast(
      msg: text,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: chooseToastColor(state),
      textColor: Colors.white,
      fontSize: 16.0);
}

enum ToastStates { success, error, warning }

Color chooseToastColor(ToastStates state) {
  Color color;

  switch (state) {
    case ToastStates.success:
      color = Colors.green;
      break;

    case ToastStates.warning:
      color = Colors.amber;
      break;

    case ToastStates.error:
      color = Colors.red;
      break;
  }

  return color;
}
