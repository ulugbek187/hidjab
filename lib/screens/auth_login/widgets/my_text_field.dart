import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MyTextField extends StatelessWidget {
  const MyTextField({
    super.key,
    required this.type,
    required this.iconPath,
    required this.hinText,
    required this.onChanged,
    required this.regExp,
    required this.errorText,
    required this.controller,
  });

  final TextEditingController controller;
  final TextInputType type;
  final String iconPath;
  final String hinText;
  final RegExp regExp;
  final String errorText;
  final ValueChanged onChanged;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: type,
      onChanged: onChanged,
      style: const TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.w300,
        color: Colors.white,
      ),
      validator: (String? value) {
        if (value == null ||
            value.isEmpty ||
            !regExp.hasMatch(value) ||
            value.length < 3) {
          return errorText;
        } else {
          return null;
        }
      },
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.black.withOpacity(0.05000000074505806),
        contentPadding: const EdgeInsets.symmetric(
          vertical: 16,
          horizontal: 15,
        ),
        errorStyle: const TextStyle(fontWeight: FontWeight.w400, color: Colors.red),
        errorBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.red,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
          borderSide: BorderSide(
            width: 1,
            color: Colors.orange,
          ),
        ),
        enabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(
            width: 1,
            color: Colors.white,
          ),
        ),

        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
          borderSide: BorderSide(
            width: 1,
            color: Colors.blue,
          ),
        ),
        prefixIcon: iconPath.isNotEmpty
            ? Padding(
          padding: const EdgeInsets.fromLTRB(0, 8, 8, 8),
          child: SvgPicture.asset(
            iconPath,
            width: 13.w,
            height: 12.h,
          ),
        )
            : null,
        hintText: hinText,
        hintStyle: const TextStyle(
          fontWeight: FontWeight.w400,
          fontSize: 14,
          color: Colors.white,
        ),
      ),
    );
  }
}
