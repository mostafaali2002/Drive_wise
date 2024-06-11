import 'package:flutter/material.dart';

typedef OnButtonPressed = void Function();
typedef onTap = void Function();
var phone_User = TextEditingController();
//resizeToAvoidBottomInset: false, =>important

Widget defaultButton({
  required Color background,
  Color textcolor = Colors.white,
  required String text,
  required OnButtonPressed function,
}) =>
    Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        color: background,
      ),
      width: 350,
      height: 60,
      child: MaterialButton(
        onPressed: function,
        child: Text(
          text,
          style: TextStyle(fontSize: 30.0, color: textcolor),
        ),
      ),
    );
Widget defaultTextFormField({
  required String hintText,
  bool obscure = false,
  required TextEditingController controller,
  required TextInputType inputType,
  required FormFieldValidator validate,
  required IconData prefix,
  IconData? suffix,
  onTap? ontap,
}) =>
    TextFormField(
      style: const TextStyle(fontSize: 30),
      controller: controller,
      onTap: ontap,
      cursorHeight: 20,
      validator: validate,
      keyboardType: inputType,
      obscureText: obscure,
      decoration: InputDecoration(
          errorStyle: const TextStyle(fontSize: 20),
          filled: true,
          fillColor: Colors.white70,
          labelStyle:
              const TextStyle(fontSize: 20.0, fontWeight: FontWeight.w400),
          hintText: hintText,
          hintStyle: const TextStyle(color: Color.fromRGBO(134, 118, 118, 1)),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          prefixIcon: Icon(
            prefix,
            color: Colors.black,
            size: 40,
          ),
          suffixIcon: suffix != null
              ? Icon(
                  suffix,
                  color: Colors.black,
                )
              : null),
    );

Widget Button(
        {required Color background,
        required Function function,
        required String text}) =>
    Container(
      width: double.infinity,
      height: 35.0,
      color: background,
      child: MaterialButton(
        onPressed: function(function),
        child: Text(
          text,
          style: const TextStyle(fontSize: 20.0, color: Colors.white),
        ),
      ),
    );
