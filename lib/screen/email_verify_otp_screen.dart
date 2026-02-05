import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loginapi/screen/home.dart';
import 'package:loginapi/screen/login_viewmodel.dart';
import 'package:pinput/pinput.dart';

class EmailVerifyOtpScreen extends ConsumerStatefulWidget {
  final String email;
  final String userType;
  const EmailVerifyOtpScreen({
    super.key,
    required this.email,
    required this.userType,
  });

  @override
  ConsumerState<EmailVerifyOtpScreen> createState() =>
      _EmailVerifyOtpScreenState();
}

class _EmailVerifyOtpScreenState extends ConsumerState<EmailVerifyOtpScreen> {
  //===================== form Key =========================
  final _formKey = GlobalKey<FormState>();
  //========================== controller =======================
  final TextEditingController _otpTEController = TextEditingController();
  //==================== pinput ===================
  final defaultpinTheme = PinTheme(
    height: 50.h,
    width: 40.w,
    textStyle: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w500,
      color: Color(0xff000000),
    ),
    decoration: BoxDecoration(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(5.r),
      border: Border.all(color: Color(0xffDBDBDB), width: 1.w),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back),
          ),
        ),
        body: Form(
          key:_formKey,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 40.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child: Column(
                    children: [
                      SizedBox(height: 25.h),
                      Text(
                        "Vérification",
                        style: TextStyle(
                          fontSize: 25.sp,
                          fontWeight: FontWeight.w900,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: 25.h),
                      Container(
                        height: 1.h,
                        width: double.maxFinite,
                        color: Color(0xffE6E6E6),
                      ),
                      SizedBox(height: 25.h),
                      Text(
                        textAlign: TextAlign.center,
                        "Nous vous avons envoyé un code à\n${widget.email}",
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 15.h),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Pinput(
                    controller:_otpTEController, //=========================== most
                    length: 6,
                    disabledPinTheme: defaultpinTheme,
                    validator: (value) {
                      if (value == null || value.length < 6) {
                        return "Veuillez entrer un code a 6 chiffres";
                      }
                      return null;
                    },
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    focusedPinTheme: defaultpinTheme.copyWith(
                      decoration: BoxDecoration(
                        border: Border.all(color: Color(0xffDBDBDB), width: 1.w),
                      ),
                    ),
                    onCompleted: (v) {
                      if (_formKey.currentState!.validate()) {
                        debugPrint("OTP:$v");
                      }
                    },
                  ),
                ),
                SizedBox(height: 25.h),
                GestureDetector(
                  onTap: () async{
                    if(_formKey.currentState!.validate()){
                      log(_otpTEController.text);
                      final res = await ref.read(userLoginProvider.notifier).verifyEmail(email:widget.email, token:_otpTEController.text.trim());
                      if(res.isSuccess){
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Home(),
                          ),
                        );
                      }else{}
                    }
                  },
                  child: Container(
                    alignment: Alignment.center,
                    height: 46.h,
                    width: double.maxFinite,
                    decoration: BoxDecoration(
                      color: Colors.deepPurple,
                      borderRadius: BorderRadius.circular(4.r),
                    ),
                    child: Text(
                      "Verification",
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
