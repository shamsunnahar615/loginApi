import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomFromField extends StatelessWidget {
  final String? hintText;
  final String? labelText;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final bool obscureText;
  final void Function(String)? onChanged;
  Color? fillColor;
   CustomFromField({
    super.key,
    this.hintText,
    this.labelText,
    this.controller,
    this.keyboardType,
    this.validator,
    this.suffixIcon,
    this.prefixIcon,
  this.obscureText = false,
    this.onChanged,
    this.fillColor
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType ?? TextInputType.text,
        obscureText:obscureText,
        validator: validator,
        onChanged: onChanged,
        textInputAction:TextInputAction.done,
        autovalidateMode:AutovalidateMode.onUserInteraction,
        style: TextStyle(fontSize: 16.sp),
        decoration: InputDecoration(
          filled: true,
          fillColor:fillColor?? Color(0xffEFEFEF),
          // contentPadding: EdgeInsets.symmetric(vertical: 14.w),
          hintText: hintText,
           labelText: labelText,
           hintStyle: TextStyle(fontSize: 16.sp, color: Colors.black12),
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4.r),
            borderSide: BorderSide(color:Colors.deepPurple),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4.r),
            borderSide: BorderSide(
              color:Colors.deepPurple,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4.r),
            borderSide: BorderSide(color: Colors.red),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4.r),
            borderSide: BorderSide(color: Colors.red),
          ),
        ),
      ),
    );
  }
}
