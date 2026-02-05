import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loginapi/Validate.dart';
import 'package:loginapi/screen/email_verify_otp_screen.dart';
import 'package:loginapi/screen/login_viewmodel.dart';
import 'package:loginapi/screen/sign_in_screen.dart';
import '../custom_text_field.dart';

class Login extends ConsumerStatefulWidget {
  const Login({super.key});

  @override
  ConsumerState<Login> createState() => _LoginState();
}

class _LoginState extends ConsumerState<Login> {
  //===================== global key =====================
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  //============================ controller ==========================
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Form(
          key: _formKey,
          child: Column(
            children: [
              Container(
                height: 200.h,
                width: double.maxFinite,
                decoration: BoxDecoration(
                  color: Colors.deepPurple,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20.r),
                    bottomRight: Radius.circular(20.r),
                  ),
                ),
              ),
              SizedBox(height: 40.h),
              Text(
                "Log in",
                style: TextStyle(
                  fontSize: 25.sp,
                  fontWeight: FontWeight.w900,
                  color: Colors.deepPurple,
                ),
              ),
              SizedBox(height: 30.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Email",
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.deepPurple,
                      ),
                    ),
                    SizedBox(height: 10.h),
                    CustomFromField(
                      validator: emailValidator,
                      controller: emailController,
                    ),
                    SizedBox(height: 10.h),
                    Text(
                      "Password",
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.deepPurple,
                      ),
                    ),
                    SizedBox(height: 10.h),
                    CustomFromField(
                      validator: passwordValidator,
                      controller: passwordController,
                    ),
                    SizedBox(height: 30.h),
                    GestureDetector(
                      onTap: () async {
                        if (_formKey.currentState!.validate()) {
                          log(emailController.text);
                          log(passwordController.text);
                          final res = await ref
                              .read(userLoginProvider.notifier)
                              .userRegister(
                                email: emailController.text.trim(),
                                password: passwordController.text.trim(),
                                type: "carrier",
                              );
                          if (res.isSuccess) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => EmailVerifyOtpScreen(
                                  email: emailController.text.trim(),
                                  userType: "carrier",
                                ),
                              ),
                            );
                          } else {}
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
                          "log in",
                          style: TextStyle(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          "Don't have an account?",
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: Colors.black,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SignInScreen(),
                              ),
                            );
                          },
                          child: Text(
                            "sign up",
                            style: TextStyle(
                              fontSize: 15.sp,
                              color: Colors.deepPurple,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
