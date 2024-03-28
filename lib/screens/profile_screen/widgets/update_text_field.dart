import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UpdateTextField extends StatefulWidget {
  const UpdateTextField({
    super.key,
    required this.title,
    required this.subTitle,
  });

  final String title;
  final String subTitle;

  @override
  State<UpdateTextField> createState() => _UpdateTextFieldState();
}

class _UpdateTextFieldState extends State<UpdateTextField> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.title),
        SizedBox(
          height: 10.h,
        ),
        TextField(
          readOnly: true,
          decoration: InputDecoration(
            hintText: widget.subTitle,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(
                16.r,
              ),
              borderSide: BorderSide(
                color: Colors.amberAccent,
                width: 2.w,
              ),
            ),
          ),
        ),
        SizedBox(
          height: 10.h,
        ),
      ],
    );
  }
}
